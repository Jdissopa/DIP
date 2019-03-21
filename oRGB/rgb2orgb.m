function orgb = rgb2orgb(input)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    %rgb to lcc
    lcc = rgb2lcc(input);
    
    %lcc to orgb
    orgb = lcc2orgb(lcc);
end

