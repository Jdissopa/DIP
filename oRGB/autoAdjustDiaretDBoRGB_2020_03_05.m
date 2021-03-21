
brightRange = [164.377 102.876 239.733];
idealMean = rgb2orgb(double([192 96 32]));

writtenDir = './retinal_quality/2020-03-05/';
imageFolder = './dataset/diaretdb0_v_1_1/resources/images/diaretdb0_fundus_images/';

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
    
    orgb = rgb2orgb(double(roi));
    
    covs = cov(orgb);
    [V,D] = svd(covs);
    
    div = 4
    
    loop = 1;
    while(loop)
        [x,newData] = dstretchLAB_version6_2(orgb,idealMean,brightRange,V,div);
        
        [~, rgb] = orgb2rgb(x,0);
        im3column(inx,:) = uint8(rgb);
        dis = reshape(im3column,size(im));
        
        f = figure, imshow(dis)
        title(strcat('scale=',string(div)))
        imwrite(dis,strcat(writtenDir,'scale-',string(div),'.png'));
%         close(f)
        f = figure, histogramRGB(rgb,256);
        title(strcat('scale=',string(div)))
        saveas(f,strcat(writtenDir,'scale-',string(div),'_histogram.png'));
%         close(f)
        
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
