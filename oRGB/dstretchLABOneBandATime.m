function [dtretched] = dstretchLABOneBandATime(im,deltaIdeal,targetMean,numbFactor)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    data = im;

    %find mean and sigma for each column
    dataMu = mean(data);
    dataSigma = std(data);
    
    %eigenvectors must transpose first to mimic the ones in the C++ code
    [eigenvectors,~,eigenvalues] = pca(data);
    %eigenvectors = eigenvectors';
    
    %scaling matrix (Sc)
    eigDataSigma = sqrt(eigenvalues);
    scale = diag(1.0./eigDataSigma);
    
    %stretching matrix (St)
    alpha = deltaIdeal / (numbFactor * dataSigma);
    stretch = alpha;
    
    %subtract the mean from input data
    zmudata = data - dataMu;
    %zmudata = data;
    
    repMu = targetMean;
    
    transformed = zmudata*(eigenvectors * scale * eigenvectors' * stretch);
    transformed = transformed + repMu;
    
    %dtretched = reshape(transformed,size(input));
    dtretched = transformed;

end

