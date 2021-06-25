function [m] = mean3bands(im)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
[~,C,B] = size(im);

if B == 3
    im = reshape(im,[],3);
    m = mean(im);
elseif C == 3
    m = mean(im);
else
    m = NaN(1);
end

end

