function [dtretched,newData] = dstretchLAB_version6_2(data,targetMean,deltaIdeal,eigenVector,div)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    data = medfilt3(data,[3,3,3]);
    %st = [x x x]
    st = std(data);
    datamu = mean(data);

    %% scale
    delta = deltaIdeal ./ (st * div);
    scale = diag(delta);
    
    newData = data - datamu;
    
    %%
    T =  eigenVector * scale * eigenVector';
    %dtretched = (data - datamu) * T + targetMean;
    dtretched = newData * T + targetMean;

end