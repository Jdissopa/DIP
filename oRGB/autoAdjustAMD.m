function [x_final] = autoAdjustAMD(pic,numbFactor,colormodel)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

%if pic not vector of 3, convert
[~,~,B] = size(pic);
if(B == 3)
    im = reshape(pic,[],3);
elseif (B == 1)
    im = pic;
else
    return;
end

if strcmpi(colormodel,'rgb')
    %the delta of ideal range of RGB
    deltaIdeal = [128 128 32];
    idealMean = [192 96 32];
elseif strcmpi(colormodel,'ycrcb')
    %the delta of ideal range of RGB
    deltaIdeal = [97.9625 -40.6825 2.4649];
    idealMean = [117 181 80];
else
    return;
end

im = double(im);

rho = std(im);
muX = mean(im);

alpha = deltaIdeal ./ (numbFactor * rho);

x = alpha .* im + (idealMean - alpha .* muX);

if (B == 3)
    x_final = reshape(x,size(pic));
else
    x_final = x;
end

end

