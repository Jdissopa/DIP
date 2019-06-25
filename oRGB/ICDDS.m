function [satImage] = ICDDS(image,k)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    rgb = reshape(double(image)/255, [], 3);

    matrixMulti = [1/3 1/3 1/3; -sqrt(2)/6 -sqrt(2)/6 2*sqrt(2)/6; 1/sqrt(2) -1/sqrt(2) 0]';
    iv1v2 = rgb * matrixMulti;
    I = iv1v2(:,1);
    
    a = min(rgb,[],2);

    ka = k * a;
    Iprime = I - ka;
    l = I./Iprime;

    RpGpBp = (rgb - ka) .* l;
    
    RpGpBp = uint8(rescale(RpGpBp) * 255);

    satImage = reshape(RpGpBp, size(image));
    

end

