function saveasppm(x, filename , K)
    %Get width and length of image
    wid = length(x(1,:,1));
    len = length(x(:,1,1));
    %Open file to write as binary
    ppm_out = fopen(filename,'w');
    %Create a vector to store pixels as r b g r b g ...
    ppm_array = zeros(len*wid*3,1);
    %Write header
    fprintf(ppm_out, 'P6 %d %d %d ',wid,len,K);
    %Noob style indexing for extra points
    index = 1;
    %Compose vector r g b r g b of the image
    for i=1:len
        
        for j = 1:wid
            
            ppm_array(index) = x(i,j,1);
            index = index+1;
            ppm_array(index) = x(i,j,2);
            index=index+1;
            ppm_array(index) = x(i,j,3);
            index=index +1;
            
        end
        
    end
    
    %Write vector to file as binary, with specified binary accuracy
    %depending on how high our values are
    if K<=255
        fwrite(ppm_out,ppm_array,'uint8');
    else
        fwrite(ppm_out,ppm_array,'uint16','ieee-be');
    end
    %Close file
    fclose(ppm_out);
    
end