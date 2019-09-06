for I = 1:1
    
        suffix = '_good.JPG';
        
        filename = strcat(string(I),suffix);
        filepath = strcat('./retinal_quality/',filename);
        
        im = imread(filepath);
        
        %do the ROI process
        [ROI,im_vector,inx] = roifind(im,10,255);
        numbFactor = 4;
        deltaIdeal = [128 128 32];
        idealMean = [192 96 32];
        upB = [240 144 48];
        lowB = [112 16 16];
        tmp = ROI;
        
        for band = 1:3
            g = autoAdjustAMDOneBandATime(ROI(:,band),deltaIdeal(band),idealMean(band),numbFactor);
            
            maxG = max(g);
            minG = min(g);
            round = 1;
            
            if band == 1 || band == 2
                fact = 30;
            else
                fact = 0;
            end
            
            while minG < (lowB(band) - fact) && round <= 50
                numbFactor = numbFactor + 0.1;
                g = autoAdjustAMDOneBandATime(ROI(:,band),deltaIdeal(band),idealMean(band),numbFactor);
                maxG = max(g);
                minG = min(g);
                round = round + 1;
            end
            
            tmp(:,band) = histeq(uint8(g),[lowB(band),upB(band)]);
        end
        
        im_vector(inx,:) = tmp;
        
        reshaped = reshape(im_vector,size(im));
        
        toMont = [im reshaped];
        figure, imshow(toMont)
        %imwrite(toMont,strcat('./retinal_quality/adjustFactor/',string(I),'_good_re.png'));
        
        %save histogram figure to picture
        t = figure;
        histogramRGB(tmp,256);
        title(filename);
        %saveas(t,strcat('./retinal_quality/adjustFactor/',string(I),'_good_gr.png'));
        %close(t)
end