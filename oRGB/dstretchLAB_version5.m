function [dtretched] = dstretchLAB_version5(data,targetMean,deltaIdeal)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    data = medfilt3(data,[3,3,3]);
    %st = [x x x]
    st = std(data);
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
    DEOneoverTwo = DE;
    DEOneoverTwo(DE ~= 0) = DE(DE ~= 0).^(-1/2);
    %% scale
    delta = deltaIdeal ./ (st * 4);
    scale = diag(delta);
    
    %%
    T =  U * scale * U';
    %dtretched = (data - datamu) * T + targetMean;
    dtretched = newData * T + targetMean;

end