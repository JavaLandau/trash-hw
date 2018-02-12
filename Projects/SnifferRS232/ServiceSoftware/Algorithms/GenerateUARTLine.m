function Bit = GenerateUARTLine(UARTParams,Init)
global UARTState
global PauseCnt

LenPause = 15;

if(Init)    
    UARTState = 'pause';
    PauseCnt = round(LenPause*rand) + 8*UARTParams.baudrate;
end

if(strcmp(UARTState,'pause'))
    PauseCnt = PauseCnt - 1;
    if(~PauseCnt)
        UARTState = 'packet';
    end
    Bit = 1;
else
    [Bit,status] = GenerateUARTPacket(UARTParams);
    
    if(strcmp(status,'end'))
        PauseCnt = round(LenPause*rand) + 8*UARTParams.baudrate;
        UARTState = 'pause';
    end
end
