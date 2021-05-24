function x = imagedequant(q, w1 , w2 , w3)
    %Get a 2d array for each color
    r = q(:,:,1);
    g = q(:,:,2);
    b = q(:,:,3);
    %Dequantize each array
    r_dq = mydequant(r,w1);
    g_dq = mydequant(g,w2);
    b_dq = mydequant(b,w3);
    %Compose final dequantized 3d array
    x(:,:,1) = r_dq;
    x(:,:,2) = g_dq;
    x(:,:,3) = b_dq;
    
end