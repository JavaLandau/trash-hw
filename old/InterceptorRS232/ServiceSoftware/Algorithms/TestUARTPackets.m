function rec_packet = TestUARTPackets()

clear all;
UARTParams = struct('baudrate',5,'bits_count',8,'parity','none','stop_bits','stopbit_1');

switch(UARTParams.stop_bits)
    case 'stopbit_1'
        stop_bits_len = 1;
    case 'stopbit_1.5'
        stop_bits_len = 1.5;
    case 'stopbit_2'
        stop_bits_len = 2;
end
TotalBits = UARTParams.bits_count + (~strcmp(UARTParams.parity,'none')) + stop_bits_len + 2; 

packet = zeros(1,TotalBits*UARTParams.baudrate);
for i = 1:length(packet)
    packet(i) = GenerateUARTPacket(UARTParams);
end

figure,
a = axes('Parent',gcf);
grid on,plot(packet,'Parent',a);
set(a,'YLim',[0 2]);

cnt_bits = 0;
rec_packet = zeros(1,floor(TotalBits));
for i = 1:length(packet)
    if(~rem(i,UARTParams.baudrate))
        cnt_bits = cnt_bits + 1;
        rec_packet(cnt_bits) = packet(i);
    end        
end

