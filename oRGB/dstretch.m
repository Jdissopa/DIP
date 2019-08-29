function [dtretched] = dstretch(input, varargin)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    narginchk(2,3);
    
    % Process inputs
    %targetMean,targetSigma
    targetMean = varargin{1};
    if length(varargin) == 2
        targetSigma = varargin{2};
    else
        targetSigma = uint8.empty(3,0);
    end
    
    if isempty(input)
        return;
    end
    
    %reshape the input to 1 column per band
    %[~,~,B] = size(input);
    %data = reshape(input, [], B);
    data = input;
    
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
    if isempty(targetSigma)
        stretch = diag(dataSigma);
    else
        stretch = double(diag(targetSigma));
    end
    
    %subtract the mean from input data
    zmudata = data - dataMu;
    %zmudata = data;
    
    repMu = targetMean;
    
    transformed = zmudata*(eigenvectors * scale * eigenvectors' * stretch);
    transformed = transformed + repMu;
    
    %dtretched = reshape(transformed,size(input));
    dtretched = transformed;

end

