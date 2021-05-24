function xrgb = bayer2rgb(xb)
    
    %Get width and length of image xb
    len = length(xb(:,1));
    wid = length(xb(1,:));

    %Initialize arrays to split the color channels from original image xb
    R = zeros(len,wid);
    G = zeros(len,wid);
    B = zeros(len,wid);
    
    %Split the color channels
    for seires=1:len
        for stiles=1:wid
            if mod(seires,2) == 1
                R(seires,stiles) = 0;
                if mod(stiles,2)== 1
                    G(seires,stiles) = xb(seires,stiles);
                    B(seires,stiles) = 0;
                else
                    B(seires,stiles) = xb(seires,stiles);
                    G(seires,stiles) = 0;
                end
            else
                B(seires,stiles) = 0;
                if mod(stiles,2)== 1
                    R(seires,stiles) = xb(seires,stiles);
                    G(seires,stiles) = 0;
                else
                    G(seires,stiles) = xb(seires,stiles);
                    R(seires,stiles) = 0;
                end
            end
        end
    end
    
    %Make the kernels for convolution
    %Print the kernels so that they are visible
    kernel_rb = (1/4)*[1 2 1;...
                       2 4 2;...
                       1 2 1]
      
    kernel_g = (1/4)*[0 1 0;...
                      1 4 1;...
                      0 1 0]
    
    %Convolutions to fill the arrays with colors
    R_conv = conv2(R,kernel_rb,'same');

    G_conv = conv2(G,kernel_g,'same');

    B_conv = conv2(B,kernel_rb,'same');
    
    %Add the colors to a single 3D array
    img_conv(:,:,1) = R_conv;
    img_conv(:,:,2) = G_conv;
    img_conv(:,:,3) = B_conv;
    
    %return the result
    xrgb = img_conv;
end