function [rgb] = lab2rgbOCV(lab)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

    %clamp lab
    lab = double(uint8(lab));
    
    %[M,N,W] = size(lab);
    
    %lab = reshape(lab,[],3);
    
    lab(:,:,1) = lab(:,:,1) * 100 / 255;
    lab(:,:,2:3) = lab(:,:,2:3) - 128;
    
    %lab = reshape(lab,M,N,W);
    
    rgb = lab2rgb(lab);

end

