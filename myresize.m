function xrgbres = myresize(xrgb , N, M, method)
    
    %Get width and length of original image
    len = length(xrgb(:,1,1));
    wid = length(xrgb(1,:,1));
    %Get width and length of output image
    new_len = N;
    new_wid = M;
    %Calculate the scaling factors
    len_scale = len / new_len;
    wid_scale = wid / new_wid;
    %Create black image
    img_new = zeros(new_len,new_wid,3);
    
    %~~~Nearest neightbour method~~~
    if strcmp(method,'nearest')
        %for every pixel in output image
        for seires=1:new_len
            for stiles=1:new_wid
                %find which pixel it would be in old image
                old_seires = round(seires*len_scale);
                old_stiles = round(stiles*wid_scale);
                %if pixel is out of bounds, use the border pixel
                if old_seires > len
                   old_seires = len; 
                end
                %if pixel is out of bounds, use the border pixel
                if old_stiles > wid
                    old_stiles = wid;
                end
                %use old image pixel color as the color for the pixel of the output image 
                img_new(seires,stiles,:) = xrgb(old_seires,old_stiles,:);

            end
        end
        
        %return the image
        xrgbres = img_new;
        
    %~~~Bilinear interpolation~~~
    elseif strcmp(method,'linear')
        
        %for every pixel of the output image
        for seires=1:new_len
            for stiles=1:new_wid
                %find in which pixel SQUARE AREA it would be in old image
                x2 = round(seires*len_scale);
                y2 = round(stiles*wid_scale);
                
                x1 = round(x2 - len_scale);
                y1 = round(y2 - wid_scale);
                
                %Bring pixels in the image if they are out of bounds
                if x2 > len
                   x2 = len; 
                end

                if y2 > wid
                    y2 = wid;
                end
                
                if x1 < 1
                   x1 = 1; 
                end

                if y1 < 1
                    y1 = 1;
                end
                
                %Find the center of SQUARE AREA
                x = (x2+x1)/2;
                y = (y2+y1)/2;
                
                %Apply bilinear interpolation for the center found above
                %Once for each color
                %Formulas by wikipedia
                
                if x1 ~= x2 && y1 ~= y2 %Normal case, bilinear interpolation
                    red = (1/((x2-x1)*(y2-y1)))*...
                            [x2 - x x - x1]*[xrgb(x1,y1,1) xrgb(x1,y2,1);...
                                             xrgb(x2,y1,1) xrgb(x2,y2,1)]*[y2-y;y-y1];

                    green = (1/((x2-x1)*(y2-y1)))*...
                            [x2 - x x - x1]*[xrgb(x1,y1,2) xrgb(x1,y2,2);...
                                             xrgb(x2,y1,2) xrgb(x2,y2,2)]*[y2-y;y-y1];

                    blue = (1/((x2-x1)*(y2-y1)))*...
                            [x2 - x x - x1]*[xrgb(x1,y1,3) xrgb(x1,y2,3);...
                                             xrgb(x2,y1,3) xrgb(x2,y2,3)]*[y2-y;y-y1];
                                     
                elseif x1 == x2 && y1 ~= y2 %Bilinear only for y
                    
                    red = (xrgb(x1,y1,1)*(y2-y)+xrgb(x1,y2,1)*(y-y1))/(y2-y1);
                    green = (xrgb(x1,y1,2)*(y2-y)+xrgb(x1,y2,2)*(y-y1))/(y2-y1);
                    blue = (xrgb(x1,y1,3)*(y2-y)+xrgb(x1,y2,3)*(y-y1))/(y2-y1);
                    
                elseif y1 == y2 && x1 ~= x2 %Bilinear only for x
                    
                    red = (xrgb(x1,y1,1)*(x2-x)+xrgb(x2,y1,1)*(x-x1))/(x2-x1);
                    green = (xrgb(x1,y1,2)*(x2-x)+xrgb(x2,y1,2)*(x-x1))/(x2-x1);
                    blue = (xrgb(x1,y1,3)*(x2-x)+xrgb(x2,y1,3)*(x-x1))/(x2-x1);
                    
                else %No interpolation
                    
                    red = xrgb(x1,y1,1);
                    green = xrgb(x1,y1,2);
                    blue = xrgb(x1,y1,3);
                    
                end
                
                %Paint the output image pixel with the colors found
                img_new(seires,stiles,1) = red;
                img_new(seires,stiles,2) = green;
                img_new(seires,stiles,3) = blue;
                
            end
        end
        
        %return the image
        xrgbres = img_new;
        
    end
    
end