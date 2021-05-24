function q = myquant(x, w)
    %remove a very small proportion from x so that we don't get
    %an extra quantization level for a single value.
    %0 stays 0 because 0 - c*0 = 0
    x = x-(1/10000)*x;
    %Map the given number x to its floor
    q = floor(x/w);

end