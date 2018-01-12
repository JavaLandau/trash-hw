function baudrate = CalcUARTBaudrate(ArrayLenBit,Fmax)
guaranteed_presence = 5;

conf_interval = zeros(3,11);

conf_interval(:,1)= [90000;160000;115200];
conf_interval(:,2)= [50000;70000;57600];
conf_interval(:,3)= [35000;45000;38400];
conf_interval(:,4)= [18000;21000;19200];
conf_interval(:,5)= [9000;10000;9600];
conf_interval(:,6)= [4700;4900;4800];
conf_interval(:,7)= [2300;2500;2400];
conf_interval(:,8)= [1100;1300;1200];
conf_interval(:,9)= [550;650;600];
conf_interval(:,10)= [280;320;300];
conf_interval(:,11)= [100;120;110];

Array = sort(ArrayLenBit,'ascend');

for i = 1:(length(Array)-1)
    if(Array(i+1) == (Array(i) + 1))
        Array(i) = Array(i+1);
    elseif(Array(i+1) == (Array(i) - 1))
        Array(i+1) = Array(i);
    elseif((Array(i+1) == (Array(i) - 2)) || (Array(i+1) == (Array(i) + 2)))
        avr = (Array(i) + Array(i+1)) / 2;
        Array(i) = avr;
        Array(i+1) = avr;
    end
end

presense_count = 1;
RecLenBit = false;
for i = 2:length(Array)
    if(Array(i) == Array(i-1))
        presense_count = presense_count + 1;
        
        if(presense_count == guaranteed_presence)            
            RecLenBit = Array(i);
            break;
        end
    else
        presense_count = 0;
    end        
end

baudrate = -1;
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
