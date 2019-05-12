function orgb = rgb2orgb(input)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    %rgb to lcc N x 3
    %[ 3 2 1 ]
    %| 5 3 6 |
    %| 5 2 6 |
    %| 2 5 6 |
    %|  ...  |
    %[ L C C ]
    lcc = rgb2lcc(input);
    
    %lcc to orgb
    orgb = lcc2orgb(lcc);
end

