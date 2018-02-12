function [hypothesis,status] = AnalysisPacketHypothesisSimple(packet, Rem, hypothesis, InitFlag)
persistent WeightHypothesis

if(InitFlag)
    WeightHypothesis = 0;
    status = 'none';
    hypothesis = struct('bits_count',7,'parity','even'); 
    return;
end

ValueReliableWeight = 10;

if(hypothesis.bits_count == 7 && ~strcmp(hypothesis.parity,'none'))    
    if(packet(2) == 0)
        WeightHypothesis = 0;
        hypothesis = struct('bits_count',8,'parity','even'); 
        status = 'fail';
        return;
    else
        if(strcmp(hypothesis.parity,'even'))            
            if(Rem ~= packet(1))
                WeightHypothesis = 0;
                hypothesis = struct('bits_count',7,'parity','odd'); 
                status = 'fail';
                return;                             
            end
        else                        
            if(Rem == packet(1))
                WeightHypothesis = 0;
                hypothesis = struct('bits_count',7,'parity','none'); 
                status = 'fail';
                return;                             
            end            
        end
    end
elseif(hypothesis.bits_count == 7 && strcmp(hypothesis.parity,'none'))
    if(packet(1) == 0)
        WeightHypothesis = 0;
        hypothesis = struct('bits_count',8,'parity','even'); 
        status = 'fail';  
        return;
    end
elseif(hypothesis.bits_count == 8 && ~strcmp(hypothesis.parity,'none'))
    if(packet(3) == 0)
        WeightHypothesis = 0;
        hypothesis = struct('bits_count',7,'parity','even');
        status = 'invalid';
        return;
    else
        if(strcmp(hypothesis.parity,'even'))                        
            if(Rem ~= packet(2))
                WeightHypothesis = 0;
                hypothesis = struct('bits_count',8,'parity','odd'); 
                status = 'fail';
                return;                             
            end
        else                        
            if(Rem == packet(2))
                WeightHypothesis = 0;
                hypothesis = struct('bits_count',8,'parity','none'); 
                status = 'fail';
                return;                             
            end            
        end        
    end
elseif(hypothesis.bits_count == 8 && strcmp(hypothesis.parity,'none'))
    if(packet(2) == 0)
        WeightHypothesis = 0;
        hypothesis = struct('bits_count',7,'parity','even'); 
        status = 'reply';
        return;
    end    
end

if(WeightHypothesis == ValueReliableWeight)
    status = 'reliable';    
    return;
end

WeightHypothesis = WeightHypothesis + 1;

if(WeightHypothesis == ValueReliableWeight)
    status = 'reliable';    
else
    status = 'process';
end