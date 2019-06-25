function [satImage] = ICDDSoRGB(oRGB,k)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    I = oRGB(:,1);
    
    %a = min(oRGB(:,2:3),[],2);
    a = min(oRGB,[],2);

    ka = k * a;
    Iprime = I - ka;
    l = I./Iprime;

    %oRpGpBp = (oRGB(:,2:3) - ka) .* l;
    oRpGpBp = (oRGB - ka) .* l;
    
    satImage = oRpGpBp;
    
    %oRpGpBp = uint8(rescale(RpGpBp) * 255);

    %satImage = reshape(RpGpBp, size(image));
    
    %satImage = [I oRpGpBp];
    

end

