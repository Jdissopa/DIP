function I_LCC = sRGB2LCC(I_sRGB)
%SRGB2LCC Summary of this function goes here
%   Detailed explanation goes here

    coefRGB2LCC = [0.299 0.587 0.114;0.5 0.5 -1.0;0.866 -0.866 0.0];

    I_sRGB = double(I_sRGB);
    [m,n,o] = size(I_sRGB);
    
    I_LCC = zeros(m,n,3);
    for r = 1:m
        for c = 1:n
            I_LCC(r, c, :) = coefRGB2LCC * reshape(I_sRGB(r,c,:), 3, 1);
        end
    end

end

