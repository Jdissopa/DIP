%define value of offset
S = reshape([192 96 32],1,1,3);
S = rgb2lab(double(S)/255);
S = reshape(S,[],3);

deltaIdeal = [51 101 43];
%upB = [85 78 73];
%lowB = [34 -23 30];
upB = [240 144 48];
lowB = [112 16 16];
cp = [30 30 0];

for I = 1:1
    
    suffix = '_good.JPG';

    filename = strcat(string(I),suffix);
    filepath = strcat('./retinal_quality/',filename);

    im = imread(filepath);

    [ROI,im_vector,inx] = roifind(im,10,255);

    keep = im_vector(:,3);

    lab = rgb2lab(double(ROI)/255);
    
    disp(filename)
    
    x = lab;
    
    
    
    x = lab;
    for band = 1:3
        factor = 1;
        tmp = dstretchLABOneBandATime(lab(:,band),deltaIdeal(band),S(band),factor);
        rgbtmp = lab2rgb(tmp);
        maxG = max(rgbtmp);
        minG = min(rgbtmp);

        %while maxG-cp(band) < upB(band) || minG+cp(band) > lowB(band)
        disp('band:',string(band))
        while minG < (lowB(band) - cp(band))
            factor = factor - 0.05;
            tmp = dstretchLABOneBandATime(lab(:,band),deltaIdeal(band),S(band),factor);
            rgbtmp = lab2rgb(tmp);
            maxG = max(tmp);
            minG = min(tmp);
            disp(strcat('min:',string(minG),' max:',string(maxG),' factor:',string(factor)))
        end
        %disp(strcat(string(band),':',string(factor)))
        x(:,band) = tmp;
    end

    rgb = uint8(lab2rgb(x) * 255);
    im_vector(inx,:) = uint8(rgb * 255);
    im_vector2 = [im_vector(:,1:2) keep];

    montage = [im reshape(im_vector2,size(im))];
    figure, imshow(montage)
    %imwrite(montage,strcat('./retinal_quality/LABAdjustFactor/',string(I),'_good.png'));
    
    disp(mean(im_vector2(:)))
    
end
