function [lcc2D, lcc3layer] = rgb2lcc(input)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    %reshape the rgb into 2D matrix 3 x N
    rgb2D = double(reshape(input, [], 3)');
    
    %tranform matrix to transform rgb to L,C1,C2
    tran_rgb2lcc = [0.299 0.587 0.114;
                    0.5 0.5 -1.0;
                    0.866 -0.866 0.0];
    %get L,C1,C2
    lcc2D = tran_rgb2lcc * rgb2D;
    lcc3layer = reshape(lcc2D', size(input));
end

