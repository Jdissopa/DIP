function [dstretched] = dStretchLab(input, targetMean, targetSigma)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    %extract only chroma axis
    ab = double(input(:,2:3));
    
    %zero mean the chroma data
    zeroMeanAB = ab - mean(ab(:));
    
    %project the zero mean data to eigenspace
    [eigVects,score] = pca(zeroMeanAB);
    
    %scale the data to unit variance
    score = score / std(score(:));
    
    %project the data back to the original points
    backToOriginal = score * eigVects';
    
    %stretch the data with the targetmean and targetsigma
    backToOriginal = backToOriginal * targetSigma + targetMean;
    
    %substitute the new chroma to the old ones 
    dstretched = [input(:,1) backToOriginal];
end

