function [satImage] = ICDDSoRGB(oRGB,k)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    I = oRGB(:,1);
    
    a = min(oRGB(:,2:3),[],2);
    %a = min(oRGB,[],2);
    %a = min(abs(oRGB(:,2:3)),[],2);
    %a = min(abs(oRGB),[],2);
    %a = I;
    
    %idx1 = I > 127.5;
    %idx2 = I < 127.5;

    ka = k * a;
    %Iprime = I;
    %Iprime(idx1) = I(idx1) - ka(idx1);
    %Iprime(idx2) = I(idx2) + ka(idx2);
    Iprime = I - abs(ka);
    l = I./Iprime;

    %oRpGpBp = (oRGB(:,2:3) - ka) .* l;
    %oRpGpBp = (oRGB - ka) .* l;
    
    % start of the working codes
    %Ix = Iprime .* l;
    
    RG = oRGB(:,2);
    %RG(RG > 0) = RG(RG > 0) - ka(RG > 0);
    %RG(RG < 0) = RG(RG < 0) + ka(RG < 0);
    RG(RG > 0) = RG(RG > 0) + abs(ka(RG > 0));
    RG(RG < 0) = RG(RG < 0) - abs(ka(RG < 0));
    RG = RG .* l;
    
    YB = oRGB(:,3);
    %YB(YB > 0) = YB(YB > 0) - ka(YB > 0);
    %YB(YB < 0) = YB(YB < 0) + ka(YB < 0);
    YB(YB > 0) = YB(YB > 0) + abs(ka(YB > 0));
    YB(YB < 0) = YB(YB < 0) - abs(ka(YB < 0));
    YB = YB .* l;
    
    satImage = [I RG YB];
    %the end of the working codes
    
end

