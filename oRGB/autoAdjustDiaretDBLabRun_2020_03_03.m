
%brightRange = [4519 5321 892];
%idealMean = [0.4604 0.3147 0.4474];
%brightRange = [128 128 16];
%idealMean = [192 96 32];
%brightRange = [65.3438 75.8206 35.0466];
brightRange = abs(rgb2lab(double([240 144 48]/255)) - rgb2lab(double([112 16 16])/255));
idealMean = rgb2lab(double([192 96 32])/255);

writtenDir = './retinal_quality/2020-02-28_diaret_4/';
imageFolder = './dataset/diaretdb0_v_1_1/resources/images/diaretdb0_fundus_images/';

maskFolder = './dataset/diaretdb0_v_1_1/resources/images/diaretdb0_binary_masks/';

write = 0;

disp('file,MeanL,MeanA,MeanB,lCover,aCover,bCover')

for I = 1:18

    if I < 10
        image = 'image00';
    elseif I < 100
        image = 'image0';
    else
        image = 'image';
    end
    
    filename = strcat(image,string(I))
    filepath = strcat(imageFolder,filename,'.png');

    im = imread(filepath);

    [~,inx] = ROI(im);
    
    im3column = reshape(im,[],3);
    roi = im3column(inx,:);
    
    lab = rgb2lab(double(roi)/255);
    
    covs = cov(lab);
    [V,D] = svd(covs);
    
    div = 4
    
    loop = 1;
    while(loop)
        [x,newData] = dstretchLAB_version6_2(lab,idealMean,brightRange,V,div);
        
        rgb = lab2rgb(x) * 255;
        im3column(inx,:) = uint8(rgb);
        dis = reshape(im3column,size(im));
        
        f = figure, imshow(dis)
        title(strcat('scale=',string(div)))
%         imwrite(dis,strcat(writtenDir,'scale-',string(div),'.png'));
%         close(f)
        f = figure, histogramRGB(rgb,256);
        title(strcat('scale=',string(div)))
%         saveas(f,strcat(writtenDir,'scale-',string(div),'_histogram.png'));
%         close(f)

        figure,histogram(x(:,1))
        title('L')
        figure,histogram(x(:,2))
        title('A')
        figure,histogram(x(:,3))
        title('B')
        
        %[Min,Max,Mean,lCover,aCover,bCover] = get_stats_info(x,[20 -20 20],brightRange);
        %loop = continue_loop(lCover,aCover,bCover);
        %if loop
        %    div = adjust_div(Min,Max,lCover,aCover,bCover,div)
        %end
        div = div + 1
    end
    
    disp(strcat(filename,',',string(Mean(1)),',',string(Mean(2)),',',string(Mean(3)),',',string(lCover),',',string(aCover),',',string(bCover)))
    rgb = lab2rgb(x) * 255;
    im3column(inx,:) = uint8(rgb);
    dis = reshape(im3column,size(im));
    
    toMontage = [im dis];
    figure, imshow(toMontage)
    if write == 1
        imwrite(dis,strcat(writtenDir,filename,'.png'));
        imwrite(toMontage,strcat(writtenDir,filename,'_montage.png'));
        
        f = figure;
        histogramRGB(rgb,256);
        title(filename);
        saveas(f,strcat(writtenDir,filename,'_histogram.png'));
        close(f)
    else
        figure
        histogramRGB(rgb,256);
        title(filename);
    end
end

disp('end')

function [inx] = get_mask(filename,maskFolder)
    filepath = strcat(maskFolder,filename,'_valid.png');
    im = imread(filepath);
    inx = find(im==1);
end

function [loop] = continue_loop(lCover,aCover,bCover)
    if lCover < 0.9 || aCover < 0.75
        loop = 1;
    else
        loop = 0;
    end  
end

function [div] = adjust_div(Min,Max,lCover,aCover,bCover,div)
    if lCover < 0.9 || aCover < 0.75 || Min(0) < 0 || any(Min < -128) || Max(0) > 100 || any(Max > 127)
        div = div + 0.1;
    else
        div = div - 0.1;
    end
end

function [Min,Max,Mean,lCover,aCover,bCover] = get_stats_info(x,loB,brightrange)
    Min = min(x);
    Max = max(x);
    Mean = mean(x);

    cl = sum(x(:,1) >= loB(1) & x(:,1) <= loB(1) + brightrange(1));
    ca = sum(x(:,2) >= loB(2) & x(:,2) <= loB(2) + brightrange(2));
    cb = sum(x(:,3) >= loB(3) & x(:,3) <= loB(3) + brightrange(3));
    all = size(x,1);

    lCover = cl /all;
    aCover = ca /all;
    bCover = cb /all;

    %Ls = sum(x,2)/3;
end
