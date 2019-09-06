function [x_final] = autoAdjustAMDOneBandATime(im,deltaIdeal,idealMean,numbFactor)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


    %deltaIdeal = [128 128 32];
    %idealMean = [192 96 32];

im = double(im);

rho = std(im);
muX = mean(im);

alpha = deltaIdeal / (numbFactor * rho);

x = alpha * im + (idealMean - alpha * muX);

x_final = x;

end

