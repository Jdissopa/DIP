function [m] = max3bands(im)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[~,~,B] = size(im);

if B == 3
    im = reshape(im,[],3);
elseif B == 1
else
    return
end
m = max(im);
end