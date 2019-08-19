function [satImage] = ICDDSoRGB(oRGB,k)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    I = oRGB(:,1);
    
    a = min(abs(oRGB(:,2:3)),[],2);

    ka = k * a;
    Iprime = I - ka;
    l = I./Iprime;

    RG = oRGB(:,2);
    idx = RG > 0;
    RG(idx) = RG(idx) + ka(idx);
    idx = RG < 0;
    RG(idx) = RG(idx) - ka(idx);
    RG = RG .* l;
    
    YB = oRGB(:,3);
    idx = YB > 0;
    YB(idx) = YB(idx) + ka(idx);
    idx = YB < 0;
    YB(idx) = YB(idx) - ka(idx);
    YB = YB .* l;
    
    satImage = [I RG YB];
    
end

