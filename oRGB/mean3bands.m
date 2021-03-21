function [m] = mean3bands(im)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[~,C,B] = size(im);

if B == 3
    im = reshape(im,[],3);
elseif B == 1
    if C == 3
else
    return
end
m = mean(im);
end

