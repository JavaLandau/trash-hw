function [baudrate, prescaler] = CalcUARTBaudrateSimple(LenBit)

Memory = zeros(1,49);
Memory(2) = 115200;
Memory(3) = 57600;
Memory(4) = 38400;
Memory(7) = 19200;
Memory(13) = 9600;
Memory(25) = 4800;
Memory(49) = 2400;

LenBit = LenBit + 1;
LenBit = bitshift(LenBit,-2);

baudrate = Memory(LenBit + 1);
prescaler = bitshift(LenBit,2);
