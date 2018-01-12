function Statistic = TestSnifferRS232(Fmax, UARTBaudrate, BitsCount, Parity, CountTest)

Statistic = struct('total',0,'valid',0,'invalid',0);

for i = 1:CountTest
    clear global;
    [baudrate,hypothesis] = SnifferRS232Simple(Fmax, UARTBaudrate, BitsCount, Parity);
    
    if(baudrate ~= UARTBaudrate || hypothesis.bits_count ~= BitsCount || ...
       ~strcmp(hypothesis.parity, Parity))
        Statistic.invalid = Statistic.invalid + 1;
    else
        Statistic.valid = Statistic.valid + 1;
    end
    fprintf('Process = %%%d\n',round(100*i/CountTest));
end

