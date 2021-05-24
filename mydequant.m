function x = mydequant(q, w)
    
    %Fix negative quantization levels so that we can dequantize correctly
    if q<0
       q = q+1; 
    end

    %Map a quantization level to the middle of the quantization band
    x = (q+(q+1))*w/2;
end