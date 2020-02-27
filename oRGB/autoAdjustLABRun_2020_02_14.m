
%brightRange = [65.3438 75.8206 35.0466];
brightRange = [128 128 16];
%idealMean = rgb2lab(double([192 96 32])/255);
idealMean = [192 96 32];

%disp('factorL,factorA,factorB,mean_red,mean_green,mean_blue,mean_greenOverRed,mean_blueOverRed,rangeL,rangeA,rangeB')

csv = [];

%writtenDir = './retinal_quality/Q0.5RearrangeFormula/';

%write = 0;

for I = 6:6

    suffix = '_good.JPG';

    filename = strcat(string(I),suffix);
    filepath = strcat('./retinal_quality/',filename);

    %im = imread(filepath);

    %[ROI,im_vector,inx] = roifind(im,10,255);
    [X, inx] = ROI(im);
    %lab = rgb2lab(double(ROI)/255);
    
    %x = dstretchLAB_version5(lab,idealMean,brightRange);
    
    im3column = reshape(X,[],3);
    roi = im3column(inx,:);
    [x,newData] = dstretchLAB_version6(double(roi),idealMean,brightRange);
    
    %adjA = (x(:,2) - 20).^1.3;
    %adjB = (x(:,3)).^0.5;
    %figure, histogram(real(adjA),255)
    %x(:,2) = real(adjA);
    %x(:,3) = real(adjB);

    %rgb = lab2rgb(x) * 255;
    %rgb(:,3) = ROI(:,3);
    
    im_vector = reshape(im,[],3);
    im_vector(inx,:) = uint8(x);
    dis = reshape(im_vector,size(im));
    
    figure, imshow(dis)
    
    toMontage = [im dis];
    if write == 1
        imwrite(dis,strcat(writtenDir,string(I),"_good_self_QU'DU.jpg"));
        %imwrite(toMontage,strcat(writtenDir,string(I),'_good_montage.png'));
    else
        figure, imshow(dis)
        %figure, imshow(toMontage)
    end
    
    %save histogram figure to picture
    f = figure;
    histogramRGB(rgb,256);
    title(filename);
    if write == 1
        saveas(f,strcat(writtenDir,string(I),"_good_histogram_QU'DU.jpg"));
        close(f)
    end
    
    s = [mean(rgb) mean(rgb(:,2))/mean(rgb(:,1)) mean(rgb(:,3))/mean(rgb(:,1))];
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
