function baudrate = CalcUARTBaudrateSimple(LenBit,Fmax)
conf_interval = zeros(1,4);

conf_interval(1)= 115200;
conf_interval(2)= 57600;
conf_interval(3)= 38400;
conf_interval(4)= 19200;

baudrate = -1;

LenBit = LenBit + 1;
LenBit = bitshift(LenBit,-2);



if(rem(LenBit, 5) == 0)
    LenBit = LenBit + 1;
    
    if(rem(LenBit,5) == 0)
        LenBit = LenBit / 5;
        
        if(LenBit > 3)
            LenBit 
            baudrate = conf_interval(4) / LenBit;
        else
            baudrate = conf_interval
        end
    end
end
    


if(RecLenBit)
    baudrate = round(Fmax / RecLenBit);
    
    for i = 1:11
        if((baudrate >= conf_interval(1,i)) && (baudrate <= conf_interval(2,i)))
            baudrate = conf_interval(3,i);
            break;
        else
            if(i == 11)
                baudrate = -1;
            end
        end
    end    
end
