function [baudrate,hypothesis] = SnifferRS232(Fmax, UARTBaudrate, BitsCount, Parity)
global RecState
global packet_status
global StopBitCount
global baudrate_feedback
global packet_state

baudrate_feedback = 0;
BreakLenBit = 6000;
CountLen = 15;
FreqFactory = 5;
StandbyTreshold = 16;

baudrate = round(Fmax / UARTBaudrate);
UARTParams = struct('baudrate',baudrate,'bits_count',BitsCount,'parity',Parity,'stop_bits','stopbit_1');

hypothesis = 0;
[hypothesis,~] = AnalysisPacketHypothesis(0, hypothesis, true);
PrevBit = GenerateUARTLine(UARTParams,true);
LenBit = 0;
ArrayLenBit = zeros(1,CountLen);
CountLen_cnt = 0;
main_cnt = 0;
main_prescaler = 1;
standby_cnt = 0;
RecState = 'baudrate';
ReplyCount = 0;

while(true)    
    Bit = GenerateUARTLine(UARTParams,false);
    
    main_cnt = main_cnt + 1;
    
    if(main_cnt ~= main_prescaler)
        continue;
    end
    
    main_cnt = 0;
    
    switch(RecState)
        case 'baudrate'
            if(PrevBit == Bit)
                LenBit = LenBit + 1;
                if(LenBit == BreakLenBit)
                    LenBit = 0;
                end
            else
                PrevBit = Bit;        
                CountLen_cnt = CountLen_cnt + 1;
                ArrayLenBit(CountLen_cnt) = LenBit;
                LenBit = 0;

                if(CountLen_cnt == CountLen)
                    baudrate = CalcUARTBaudrate(ArrayLenBit,Fmax);
                    baudrate_feedback = baudrate;

                    if(baudrate ~= -1)
                        RecState = 'search_standby';
                        StopBitCount = 0;
                        standby_cnt = 0;
                        main_prescaler = floor(Fmax / (baudrate*FreqFactory));
                    end
                    
                    CountLen_cnt = 0;
                end    
            end
        case 'search_standby'
            if(Bit ~= 1)                                                
                if(StopBitCount)
                    standby_cnt = standby_cnt + 1;

                    if(standby_cnt == StandbyTreshold)
                        RecState = 'baudrate';
                        main_prescaler = 1;
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
                    if(middle_cnt == 4)
                        packet_status = 'process';
                        baudrate_count = 0;
                        middle_cnt = 0;
                        BaudratePacket = zeros(1,10);  
                    end
                else
                    packet_status = 'search_startbit';
                end
            elseif(strcmp(packet_status,'process'))
                baudrate_count = baudrate_count + 1;
                
                if(baudrate_count == FreqFactory)
                    packet_count = packet_count + 1;
                    BaudratePacket(packet_count) = Bit;
                                                                          
                    if(packet_count == 10)                         
                        if(~strcmp(packet_state,'startbit'))
                            return;
                        end
                        
                        packet_count = 0;
                        [hypothesis,status] = AnalysisPacketHypothesis(BaudratePacket, hypothesis, false);
                        
                        switch(status)
                            case 'reply'                                
                                ReplyCount = ReplyCount + 1;
                                if(ReplyCount == 2)
                                    ReplyCount = 0;
                                    RecState = 'baudrate';
                                    main_prescaler = 1;
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
                    
                    baudrate_count = 0;
                end
            end                        
    end
end