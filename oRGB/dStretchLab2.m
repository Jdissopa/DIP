function [dstretched] = dStretchLab2(input, targetMean, targetSigma)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    %[M,N] = size(input);
    %data = reshape(input, 1, M*N);
    
    %data mu and sigma
    dataMu = mean(input);
    dataSigma = std(input);
   
    %project the zero mean data to eigenspace
    [eigenvectors,score,eigenvalues] = pca(input - dataMu);
    
    eigDataSigma = sqrt(eigenvalues);
    scale = diag(1.0./eigDataSigma);
    
    stretch = diag(targetSigma);
    
    %zero mean the chroma data
    %zmudata = input - dataMu;
    zmudata = score;
    
    repMu = targetMean;
    
    transformed = zmudata * (eigenvectors' * scale * stretch) + repMu;
    
    %substitute the new chroma to the old ones 
    %dstretched = [input(:,1) transformed];
    dstretched = transformed;
end

