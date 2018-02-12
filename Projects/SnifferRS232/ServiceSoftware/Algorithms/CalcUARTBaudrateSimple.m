function [baudrate, prescaler] = CalcUARTBaudrateSimple(LenBit)

Memory = zeros(1,49);

Memory(2) = 230400;
Memory(3) = 115200;
Memory(5) = 57600;
Memory(7) = 38400;
Memory(13) = 19200;
Memory(25) = 9600;
Memory(49) = 4800;
Memory(97) = 2400;

LenBit = LenBit + 1;
LenBit = bitshift(LenBit,-2);

baudrate = Memory(LenBit + 1);
prescaler = bitshift(LenBit,2);
