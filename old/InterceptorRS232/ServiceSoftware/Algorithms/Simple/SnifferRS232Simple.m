function [baudrate,hypothesis] = SnifferRS232Simple(Fmax, UARTBaudrate, BitsCount, Parity)
global RecState
global packet_status
global StopBitCount
global packet_state

BreakLenBit = 3200;
CountLen = 15;
StandbyTreshold = 16;
FreqFactory = 4;

baudrate = round(Fmax / UARTBaudrate);
UARTParams = struct('baudrate',baudrate,'bits_count',BitsCount,'parity',Parity,'stop_bits','stopbit_1');

hypothesis = 0;
[hypothesis,~] = AnalysisPacketHypothesisSimple(0, 0, hypothesis, true);
PrevBit = GenerateUARTLine(UARTParams,true);
LenBit = 1;
MinLenBit = BreakLenBit;
CountLen_cnt = 0;
standby_cnt = 0;
RecState = 'baudrate';
ReplyCount = 0;
main_cnt = 0;
main_prescaler = 1;

while(true)    
    Bit = GenerateUARTLine(UARTParams,false);
    
    main_cnt = main_cnt + 1;
    
    if(main_cnt < main_prescaler)
        continue;
    end
        
    main_cnt = 0;
    
    switch(RecState)
        case 'baudrate'
            if(PrevBit == Bit)
                LenBit = LenBit + 1;
                if(LenBit == BreakLenBit)
                    LenBit = 1;
                    MinLenBit = BreakLenBit;
                end
            else
                PrevBit = Bit;        
                CountLen_cnt = CountLen_cnt + 1;
                
                if(LenBit < MinLenBit)
                    MinLenBit = LenBit;
                end
                
                LenBit = 1;

                if(CountLen_cnt == CountLen)
                    [baudrate, prescaler] = CalcUARTBaudrateSimple(MinLenBit);

                    if(baudrate ~= 0)
                        RecState = 'search_standby';
                        StopBitCount = 0;
                        standby_cnt = 0;                        
                    end
                    
                    MinLenBit = BreakLenBit;
                    CountLen_cnt = 0;
                end    
            end
        case 'search_standby'
            if(Bit ~= 1)                                                
                if(StopBitCount)
                    standby_cnt = standby_cnt + 1;

                    if(standby_cnt == StandbyTreshold)
                        RecState = 'baudrate';
                        PrevBit = Bit;                                        
                    end
                end
                StopBitCount = 0;
            else
                StopBitCount = StopBitCount + 1;
                
                if(StopBitCount == 8*FreqFactory)
                    RecState = 'packet';
                    standby_cnt = 0;
                    hypothesis = struct('bits_count',7,'parity','even'); 
                    packet_count = 0;
                    packet_status = 'search_startbit';                    
                end
            end
        case 'packet'
            if(strcmp(packet_status,'search_startbit'))
                if(Bit == 0)
                    packet_status = 'search_middle';
                    middle_cnt = 0;                    
                end
            elseif(strcmp(packet_status,'search_middle'))
                if(Bit == 0)
                    middle_cnt = middle_cnt + 1;
                    if(middle_cnt == 3)
                        packet_status = 'process';
                        Rem = 0;
                        middle_cnt = 0;
                        main_prescaler = prescaler;
                        BaudratePacket = zeros(1,3);  
                    end
                else
                    packet_status = 'search_startbit';
                end
            elseif(strcmp(packet_status,'process'))
                packet_count = packet_count + 1;                
                
                if(packet_count <= hypothesis.bits_count)
                    Rem = xor(Rem,Bit);
                end
                
                if(packet_count > 7)
                    BaudratePacket(packet_count - 7) = Bit;
                end

                if(packet_count == 10)                         
                    if(~strcmp(packet_state,'startbit'))
                        return;
                    end

                    packet_count = 0;
                    [hypothesis,status] = AnalysisPacketHypothesisSimple(BaudratePacket, Rem, hypothesis, false);
                    main_prescaler = 1;
                    
                    switch(status)
                        case 'reply'                                
                            ReplyCount = ReplyCount + 1;
                            if(ReplyCount == 2)
                                ReplyCount = 0;
                                RecState = 'baudrate';                                
                                PrevBit = Bit;
                            end
                        case 'invalid'
                            RecState = 'search_standby';
                            StopBitCount = 0;
                        case 'reliable'
                            packet_status = 'search_startbit';
                            return;
                        case {'fail','process'}
                            packet_status = 'search_startbit';                                
                    end
                end
            end                        
    end
end