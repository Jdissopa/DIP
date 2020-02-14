function [dtretched] = dstretchLABOneBandATime_version2(im,deltaIdeal,targetMean,T,numbFactor)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    data = im;

    %find mean and sigma for each column
    datamu = mean(data);
    dataSigma = std(data);
    
    %stretching matrix (St)
    alpha = deltaIdeal ./ (numbFactor .* dataSigma);
    Q = diag(alpha);
    
    T = T * Q;
    g = (data - datamu) * T + targetMean;
    
    dtretched = g;

end

