function q = imagequant(x, w1 , w2 , w3)
    %Get 1 2d array for each color
    r = x(:,:,1);
    g = x(:,:,2);
    b = x(:,:,3);
    %Quantize each array
    r_q = myquant(r,w1);
    g_q = myquant(g,w2);
    b_q = myquant(b,w3);
    %Compose final 3d array with quantized arrays
    q(:,:,1) = r_q;
    q(:,:,2) = g_q;
    q(:,:,3) = b_q;

end