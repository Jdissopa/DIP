function [dtretched] = dstretchLAB_version4(data,targetMean)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    data = medfilt3(data,[3,3,3]);
    %datamu = [x x x]
    datamu = mean(data);
    
    %                [ x ]
    % eigenvalues =  | x |
    %                [ x ]
    [U,newData,eigenvalues] = pca(data);

    %%
    stretch = diag(sqrt(diag(cov(data))));
    stretch(3,3) = 0.5;
    %%
    DE = diag(eigenvalues) * diag([1 1 0]);
    
    %% scale
    DEOneoverTwo = DE;
    DEOneoverTwo(DE ~= 0) = DE(DE ~= 0).^(-1/2);
    %%
    
    T =  U * DEOneoverTwo * U' * stretch;
    %dtretched = (data - datamu) * T + targetMean;
    
    %dtretched = U * DEOneoverTwo * U' * stretch + targetMean;
    
    dtretched = newData * T + targetMean;

end