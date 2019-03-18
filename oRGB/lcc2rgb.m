function rgb2D = lcc2rgb(input)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    
    lcc2rgb_matrix = [1 0.114 0.7436;
                        1 0.114 -0.4111
                        1 -0.886 0.1663];
    rgb2D = lcc2rgb_matrix * input;
end

