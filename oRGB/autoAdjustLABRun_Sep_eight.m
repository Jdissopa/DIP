
%upRangergb = [240 144 48];
%downRangergb = [112 16 16];
%idealRangergb = upRangergb - downRangergb;

%upRangelab = rgb2lab(double(upRangergb)/255);
%lowRangelab = rgb2lab(double(downRangergb)/255);
brightRange = [65.3438 75.8206 35.0466];


idealMean = rgb2lab(double([192 96 32])/255);

disp('factorL,factorA,factorB,mean_red,mean_green,mean_blue,mean_greenOverRed,mean_blueOverRed,rangeL,rangeA,rangeB')

csv = [];

writtenDir = './retinal_quality/Q0.5RearrangeFormula/';

write = 1;

for I = 14:14

    suffix = '_good.JPG';

    filename = strcat(string(I),suffix);
    filepath = strcat('./retinal_quality/',filename);

    im = imread(filepath);

    [ROI,im_vector,inx] = roifind(im,10,255);
    lab = rgb2lab(double(ROI)/255);
    
    lab = medfilt3(lab,[3,3,3]);
    
    [U,~,eigenvalues] = pca(lab);
    
    D = getD(eigenvalues);
    T = getT(U,D);
    
    factor = [4 4 4];

    for band = 1:2
        %x = dstretchLABOneBandATime_version2(lab,brightRange,idealMean,T,factor);
        x = dstretchLABOneBandATime_version3(lab,idealMean,U,eigenvalues,brightRange);
        mean_x = mean(x);
        twoSD = 3.75 * std(x);
        mean_plus2SD = mean_x + twoSD;
        mean_subtract2SD = mean_x - twoSD;
        rangex = mean_plus2SD - mean_subtract2SD;
        
        %if any([1 2] == band)
        %    times_sd = 4;
        %else
        %    times_sd = 3;
        %end

        while rangex(band) < brightRange(band)
            %if brightRange(band) - rangex(band) < 10
            %    factor(band) = factor(band) - 0.01;
            %else
            factor(band) = factor(band) - 0.1;
            %end
            %x = dstretchLABOneBandATime_version2(lab,brightRange,idealMean,T,factor);
            x = dstretchLABOneBandATime_version3(lab,idealMean,U,eigenvalues,brightRange);
            mean_x = mean(x);
            twoSD = 3.75 * std(x);
            mean_plus2SD = mean_x + twoSD;
            mean_subtract2SD = mean_x - twoSD;
            rangex = mean_plus2SD - mean_subtract2SD;
            %disp(strcat('rangex:',string(rangex(band)),' factors:',string(factor(band))))
        end
    end

    rgb = uint8(lab2rgb(x) * 255);

    im_vector(inx,:) = rgb;
    dis = reshape(im_vector,size(im));
    toMontage = [im dis];
    if write == 1
        imwrite(dis,strcat(writtenDir,string(I),"_good_self_QU'DU.jpg"));
        %imwrite(toMontage,strcat(writtenDir,string(I),'_good_montage.png'));
    else
        figure, imshow(dis)
        figure, imshow(toMontage)
    end
    
    %save histogram figure to picture
    f = figure;
    histogramRGB(rgb,256);
    title(filename);
    if write == 1
        saveas(f,strcat(writtenDir,string(I),"_good_histogram_QU'DU.jpg"));
        close(f)
    end
    
    s = [factor mean(rgb) mean(rgb(:,2))/mean(rgb(:,1)) mean(rgb(:,3))/mean(rgb(:,1)) rangex];
    disp(s)
    if write == 1
        %csv(I,:) = s;
    end
    %disp(strcat(filename,',',string(factor(1)),',',string(factor(2)),',',string(factor(3)),',',string(mean(rgb(:,1))),',',string(mean(rgb(:,2))),',',string(mean(rgb(:,3))),',',string(mean(rgb(:,2))/mean(rgb(:,1))),',',string(mean(rgb(:,3))/mean(rgb(:,1))),',',string(rangex)))
end
if write == 1
    %csvwrite(strcat(writtenDir,'statistical_values.csv'),csv)
end
disp('end')
