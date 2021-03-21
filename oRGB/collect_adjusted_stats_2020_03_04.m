%%
%load all the adjusted images and then convert to lab to take a look on
%their statistical characteristics in lab color model, consists of 
%
%mean  
%      meanL meanA meanB
% pic1  x.xx x.xx  x.xx
% pic2  x.xx x.xx  x.xx
%
%min 
%       minL minA  minB
% pic1  x.xx x.xx  x.xx
% pic2  x.xx x.xx  x.xx
%
%max
%       maxL maxA  maxB
% pic1  x.xx x.xx  x.xx
% pic2  x.xx x.xx  x.xx
%
%histograms
%       histogramL
%        0   1  2  ...  
% pic1  xx  xx  xx ...
% pic2  xx  xx  xx ...
%       histogramA
%        0   1  2  ...  
% pic1  xx  xx  xx ...
% pic2  xx  xx  xx ...
%       histogramB
%        0   1  2  ...  
% pic1  xx  xx  xx ...
% pic2  xx  xx  xx ...

%%

imageFolder = './retinal_quality/2020-02-28_diaret_3/';

for I = 1:130

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
    
    lab = rgb2lab(double(roi)/255);
    
    Mean(I,:) = mean(lab);
    Min(I,:) = min(lab);
    Max(I,:) = max(lab);
    
    sd = std(lab);
    
    XMin(I,:) = -1.96 * sd + Mean(I,:);
    XMax(I,:) = 1.96 * sd + Mean(I,:);
end


%% get_histogram
function [x,y] = get_histogram(min,max,data,inc)
    curr = min;
    I = 1;
    while curr <= max
        x(I,1) = curr;
        y(I,1) = sum(data >= curr & data < curr+inc);
        I = I + 1;
        curr = curr + inc;
    end
end










