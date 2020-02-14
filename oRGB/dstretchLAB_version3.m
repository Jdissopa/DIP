function [dtretched] = dstretchLAB_version3(data,targetMean,W)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    data = medfilt3(data,[3,3,3]);
    %datamu = [x x x]
    datamu = mean(data);
    
    %                [ x ]
    % eigenvalues =  | x |
    %                [ x ]
    [U,~,eigenvalues] = pca(data);
    
    %(DE)^-1/2
    DE = diag(eigenvalues) * diag([1 1 0]);
    DEOneoverTwo = DE;
    DEOneoverTwo(DE ~= 0) = DE(DE ~= 0).^(-1/2);
    
    %D^-1
    DPowerMinus1 = diag(eigenvalues.^-1);
    
    %stretching or Q
    % W = [x x x]
    Q = diag(DPowerMinus1 * W');
    Q(3,3) = 0.5;
    
    T =  U * DEOneoverTwo * U' * Q;
    g = (data - datamu) * T + targetMean;
    
    dtretched = g;

end

