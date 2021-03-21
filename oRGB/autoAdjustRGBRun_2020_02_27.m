
brightRange = [128 128 16];
idealMean = [192 96 32];

writtenDir = './retinal_quality/2020-02-27/';

write = 1;

for I = 1:18

    suffix = '_good.JPG';

    filename = strcat(string(I),suffix)
    filepath = strcat('./retinal_quality/',filename);

    im = imread(filepath);

    [~, inx] = ROI(im);
    
    im3column = reshape(im,[],3);
    roi = im3column(inx,:);
    
    covs = cov(double(roi));
    [V,D] = svd(covs);
    
    div = 4
    
    loop = 1;
    while(loop)
        [x,newData] = dstretchLAB_version6_2(double(roi),idealMean,brightRange,V,div);
        
        [Min,Max,Mean,rCover,gCover,bCover,lCover] = get_stats_info(x);
        loop = continue_loop(rCover,gCover,lCover);
        if loop
            div = adjust_div(Min,Max,rCover,gCover,div)
        end
    end
    
    im3column(inx,:) = uint8(x);
    dis = reshape(im3column,size(im));
    
    toMontage = [im dis];
    figure, imshow(toMontage)
    if write == 1
        imwrite(dis,strcat(writtenDir,string(I),"_good.png"));
        imwrite(toMontage,strcat(writtenDir,string(I),'_good_montage.png'));
        
        f = figure;
        histogramRGB(x,256);
        title(filename);
        saveas(f,strcat(writtenDir,string(I),"_good_histogram.png"));
        close(f)
    end
end

disp('end')

function [loop] = continue_loop(rCover,gCover,lCover)
    if rCover < 0.95 || gCover < 0.95 || lCover < 0.95
        loop = 1;
    else
        loop = 0;
    end  
end

function [div] = adjust_div(Min,Max,rCover,gCover,div)
    if rCover < 0.95 || gCover < 0.95 || any(Min < 0) || any(Max > 256)
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
