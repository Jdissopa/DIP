
for I = 1:3
    for J = 1:1
        if (J == 1)
            suffix = '_good.JPG';
        else
            suffix = '_bad.JPG';
        end
        filename = strcat(string(I),suffix);
        filepath = strcat('./retinal_quality/',filename);
        
        im = imread(filepath);
        
        %do the ROI process
        [ROI,im_vector,inx] = roifind(im,10,255);
        
        %convert rgb ROI to lab
        lab = rgb2lab(double(ROI)/255);
        
        %define value of offset
        S = reshape([192 96 32],1,1,3);
        S = rgb2lab(double(S)/255);
        S = reshape(S,[],3);
        
        %std of lab
        scale = std(lab);
        %scale(2) = scale(2) * 2.0;
        scale(3) = scale(3) * 0.0;
        
        %do dstretch
        g = dstretch(lab,S,scale);
        %g(:,3) = lab(:,3);
        
        %convert lab back to rgb
        lb = lab2rgb(g);
        
        %calculate new range and mean and replace Blue band
        lbtemp = lb * 255;
        muB = mean(lbtemp(:,3));
        lbtemp(:,3) = (lbtemp(:,3) - muB) + 32;
        lbtemp = uint8(lbtemp);
        %end of the calculation
        
        %substitute the ROI back to the image
        im_vector(inx,:) = lbtemp;
        
        %reshape the image vector back to displayable dimension
        rgb = reshape(im_vector,size(im));
        
        %plot pictures and histogram and mean
        %figure, montage({im,rgb});
        %title(string(I));
        figure, histogramRGB(lbtemp,256);
        title(string(I));
        m = mean(reshape(lbtemp,[],3));
        str = strcat(filename,': ',num2str(m));
        disp(str);
    end
end



