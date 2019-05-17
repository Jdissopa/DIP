function [lcc] = rgb2d2lcc(rgb2D)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    %reshape the rgb into 2D matrix N x 3
    %[ 3 2 1 ]
    %| 5 3 6 |
    %| 5 2 6 |
    %| 2 5 6 |
    %|  ...  |
    %[ R G B ]
    %tranform matrix to transform rgb to L,C1,C2
    tran_rgb2lcc = [0.299 0.5 0.866;
                    0.587 0.5 -0.866;
                    0.114 -1.0 0.0];
    %get L,C1,C2
    %[ 3 2 1 ]
    %| 5 3 6 |
    %| 5 2 6 |
    %| 2 5 6 |
    %|  ...  |
    %[ L C C ]
    lcc = rgb2D * tran_rgb2lcc;
end

