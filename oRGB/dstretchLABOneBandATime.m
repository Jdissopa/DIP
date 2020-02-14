function [dtretched] = dstretchLABOneBandATime(im,deltaIdeal,targetMean,numbFactor)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    data = im;

    %find mean and sigma for each column
    datamu = mean(data);
    dataSigma = std(data);
    
    %eigenvectors must transpose first to mimic the ones in the C++ code
    [U,~,eigenvalues] = pca(data);
    
    %scaling matrix (Sc)
    eigDataSigma = sqrt(eigenvalues);
    D = diag(1.0./eigDataSigma);
    %scale = diag(eigenvalues^(-1/2));
    
    %stretching matrix (St)
    alpha = deltaIdeal / (numbFactor * dataSigma);
    Q = alpha;
    
    T = U * D * U' * Q;
    g = (data - datamu) * T + targetMean;
    
    dtretched = g;

end

