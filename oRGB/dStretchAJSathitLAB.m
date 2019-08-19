function [dtretched] = dStretchAJSathitLAB(input,targetMean,targetSigma)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    %reshape the input to 1 column per band
    [~,~,B] = size(input);
    data = reshape(input, [], B);
    
    %find mean and sigma for each column
    dataMu = mean(data);
    dataSigma = std(data);
    
    %eigenvectors must transpose first to mimic the ones in the C++ code
    [eigenvectors,~,eigenvalues] = pca(data);
    %eigenvectors = eigenvectors';
    
    %suppress Blue and Yellow Band
    %e = eye(3);
    %e(9) = 0;
    
    scale = diag(eigenvalues);
    scale(scale ~= 0) = scale(scale ~= 0).^(-1/2);
    
    %scaling matrix (Sc)
    %eigDataSigma = sqrt(eigenvalues);
    %scale = diag(1.0./eigDataSigma);
    
    %stretching matrix (St)
    stretch = double(diag(targetSigma));
    
    %subtract the mean from input data
    zmudata = data - dataMu;
    
    repMu = targetMean;
    
    %transformed = zmudata;
    %if data(:,3) < 127.5
    %transformed(data(:,3) < 127.5) = zmudata*(eigenvectors * scale * eigenvectors' * stretch);
    
    %if data(:,3) >= 127.5
    
    transformed = zmudata*(eigenvectors * scale * eigenvectors' * stretch);
    transformed = transformed + repMu;
    
    dtretched = reshape(transformed,size(input));
end

