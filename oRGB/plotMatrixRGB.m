function plotMatrixRGB(rgb)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    rgb = reshape(rgb,[],3);
    figure
    plotmatrix(rgb,rgb);
end

