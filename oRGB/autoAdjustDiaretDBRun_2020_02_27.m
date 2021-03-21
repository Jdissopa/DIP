
brightRange = [128 128 16];
idealMean = [192 96 32];

writtenDir = './retinal_quality/2020-02-28_diaret_4/';
imageFolder = './dataset/diaretdb0_v_1_1/resources/images/diaretdb0_fundus_images/';

maskFolder = './dataset/diaretdb0_v_1_1/resources/images/diaretdb0_binary_masks/';

write = 0;

disp('file,MeanR,MeanG,MeanB,rCover,gCover,bCover,lCover')

for I = 19:130

    if I < 10
        image = 'image00';
    elseif I < 100
        image = 'image0';
    else
        image = 'image';
    end
    
    filename = strcat(image,string(I));
    filepath = strcat(imageFolder,filename,'.png');

    im = imread(filepath);

    [~,inx] = ROI(im);
    
    im3column = reshape(im,[],3);
    roi = im3column(inx,:);
    
    covs = cov(double(roi));
    [V,D] = svd(covs);
    
    div = 4;
    
    loop = 1;
    while(loop)
        [x,newData] = dstretchLAB_version6_2(double(roi),idealMean,brightRange,V,div);
        
        [Min,Max,Mean,rCover,gCover,bCover,lCover] = get_stats_info(x);
        loop = continue_loop(rCover,gCover,lCover);
        if loop
            div = adjust_div(Min,Max,rCover,gCover,div);
        end
    end
    
    disp(strcat(filename,',',string(Mean(1)),',',string(Mean(2)),',',string(Mean(3)),',',string(rCover),',',string(gCover),',',string(bCover),',',string(lCover)))
    im3column(inx,:) = uint8(x);
    dis = reshape(im3column,size(im));
    figure, imshow(dis)
    
    %toMontage = [im dis];
    %figure, imshow(toMontage)
    if write == 1
        imwrite(dis,strcat(writtenDir,filename,'.png'));
        imwrite(toMontage,strcat(writtenDir,filename,'_montage.png'));
        
        f = figure;
        histogramRGB(x,256);
        title(filename);
        saveas(f,strcat(writtenDir,filename,'_histogram.png'));
        close(f)
    else
        %figure
        %histogramRGB(x,256);
        %title(filename);
    end
end

disp('end')

function [inx] = get_mask(filename,maskFolder)
    filepath = strcat(maskFolder,filename,'_valid.png');
    im = imread(filepath);
    inx = find(im==1);
end

function [loop] = continue_loop(rCover,gCover,lCover)
    if rCover < 0.9 || gCover < 0.9 || lCover < 0.9
        loop = 1;
    else
        loop = 0;
    end  
end

function [div] = adjust_div(Min,Max,rCover,gCover,div)
    if rCover < 0.9 || gCover < 0.9 || any(Min < 0) || any(Max > 256)
        div = div + 0.1;
    else
        div = div - 0.1;
    end
end

function [Min,Max,Mean,rCover,gCover,bCover,lCover] = get_stats_info(x)
    Min = min(x);
    Max = max(x);
    Mean = mean(uint8(x));

    cr = sum(x(:,1) >= 112 & x(:,1) <= 240);
    cg = sum(x(:,2) >= 16 & x(:,2) <= 144);
    cb = sum(x(:,3) >= 16 & x(:,3) <= 32);
    all = size(x,1);

    rCover = cr /all;
    gCover = cg /all;
    bCover = cb /all;

    Ls = sum(x,2)/3;
    lCover = sum(Ls >= 48 & Ls <= 144) / all;
end
