function [satImage] = ICDDSoRGB(oRGB,k)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    I = oRGB(:,1);
    
    %a = min(oRGB(:,2:3),[],2);
    %a = min(oRGB,[],2);
    a = I;

    ka = k * a;
    Iprime = I;
    Iprime(I > 0.5) = I(I > 0.5) - ka(I > 0.5);
    Iprime(I < 0.5) = I(I < 0.5) + ka(I < 0.5);
    l = I./Iprime;

    %oRpGpBp = (oRGB(:,2:3) - ka) .* l;
    %oRpGpBp = (oRGB - ka) .* l;
    Ix = Iprime .* l;
    RG = oRGB(:,2);
    RG(RG >= 0) = RG(RG >= 0) - ka(RG >= 0);
    RG(RG < 0) = RG(RG < 0) + ka(RG < 0);
    RG = RG .* l;
    YB = oRGB(:,3);
    YB(YB >= 0) = YB(YB >= 0) - ka(YB >= 0);
    YB(YB < 0) = YB(YB < 0) + ka(YB < 0);
    YB = YB .* l;
    
    satImage = [Ix RG YB];
    
    %satImage = oRpGpBp;
    
    %oRpGpBp = uint8(rescale(RpGpBp) * 255);

    %satImage = reshape(RpGpBp, size(image));
    
    %satImage = [I oRpGpBp];
    

end

