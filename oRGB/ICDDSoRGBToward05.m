function [satImage] = ICDDSoRGBToward05(oRGB,k)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    I = oRGB(:,1);
    
    a = min(oRGB(:,2:3),[],2);
    %a = min(oRGB,[],2);
    %a = min(abs(oRGB(:,2:3)),[],2);
    %a = min(abs(oRGB),[],2);
    %a = I;

    ka = k * a;
    Iprime = I;
    
    %the process of I > 0.5
    idx = I > 0.5;
    %filter only the I that > 0.5 and minus with ka
    Iprime(idx) = I(idx) - ka(idx);
    %find idx of the I that < 0.5 after the above subtraction
    idxLessthan05 = Iprime < 0.5;
    %find the overlaped indeces of the I > 0.5 and < 0.5 after the
    %subtraction
    overlappedIdx = idx + idxLessthan05;
    overlappedIdx = overlappedIdx == 2;
    %reset the values to 0.5
    Iprime(overlappedIdx) = 0.5;
    
    %the process of I < 0.5
    idx = I < 0.5;
    %filter only the I that < 0.5 and plus with ka
    Iprime(idx) = I(idx) + ka(idx);
    %find idx of the I that > 0.5 after the above addition
    idxGrtthan05 = Iprime > 0.5;
    %find the overlaped indeces of the I < 0.5 and > 0.5 after the
    %addition
    overlappedIdx = idx + idxGrtthan05;
    overlappedIdx = overlappedIdx == 2;
    %reset the values to 0.5
    Iprime(overlappedIdx) = 0.5;
    
    %Iprime(I > 0.5) = I(I > 0.5) - ka(I > 0.5);
    %Iprime(I < 0.5) = I(I < 0.5) + ka(I < 0.5);
    l = I./Iprime;

    %oRpGpBp = (oRGB(:,2:3) - ka) .* l;
    %oRpGpBp = (oRGB - ka) .* l;
    
    % start of the working codes
    Ix = Iprime .* l;
    
    RG = oRGB(:,2);
    RG(RG > 0) = RG(RG > 0) - ka(RG > 0);
    RG(RG < 0) = RG(RG < 0) + ka(RG < 0);
    RG = RG .* l;
    
    YB = oRGB(:,3);
    YB(YB > 0) = YB(YB > 0) - ka(YB > 0);
    YB(YB < 0) = YB(YB < 0) + ka(YB < 0);
    YB = YB .* l;
    
    satImage = [Ix RG YB];
    %the end of the working codes
    
end

