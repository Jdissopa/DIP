
%brightRange = [4519 5321 892];
%idealMean = [0.4604 0.3147 0.4474];
%brightRange = [128 128 16];
%idealMean = [192 96 32];
%brightRange = [65.3438 75.8206 35.0466];
upperBound = rgb2lab(double([240 144 48])/255);
lowerBound = rgb2lab(double([112 16 16])/255);
brightRange = abs(lowerBound - upperBound);
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
    l = [];
    a = [];
    b = [];
    [l,a,b] = get_distinct_values(lab);
    [l4,~,~] = get_distinct_values(lab2);
    
    all = double(size(lab,1));
    l(1,3) = l(1,2)/all * 100;
    for I = 2:size(l,1)
        l(I,3) = (l(I-1,3) + (l(I,2)/all));
    end
    l(:,3) = l(:,3) * 100;
    
    near25 = l(:,1);
    near25(:,2) = abs(l(:,3) - 2.5);
    near975 = l(:,1);
    near975(:,2) = abs(l(:,3) - 97.5);
    
    %sort
    S1 = sortrows(near25,2);
    S2 = sortrows(near975,2);
    
    covs = cov(lab);
    [V,D] = svd(covs);
    
    div = 4
    
    loop = 1;
    while(loop)
        [x,newData] = dstretchLAB_version6_2(lab,idealMean,brightRange,V,div);
        
        [l,a,b] = get_distinct_values(x);
        
        %[Min,Max,Mean,lCover,aCover,bCover] = get_stats_info(x,[20 -20 20],brightRange);
        %loop = continue_loop(lCover,aCover,bCover);
        %if loop
        %    div = adjust_div(Min,Max,lCover,aCover,bCover,div)
        %end
        div = div + 1
    end
end

disp('end')

function [l,a,b] = get_distinct_values(lab)
    l = unique(lab(:,1));
    [N,~] = histcounts(lab(:,1),[l;l(end) + 1]);
    l(:,2) = N;
    N = [];
    
    a = unique(lab(:,2));
    [N,~] = histcounts(lab(:,2),[a;a(end) + 1]);
    a(:,2) = N;
    N = [];
    
    b = unique(lab(:,3));
    [N,~] = histcounts(lab(:,3),[b;b(end) + 1]);
    b(:,2) = N;
end

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
