function [rgb] = generateRGBinRanges(R,G,B)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    ranB = B(1):B(2);
    bSize = size(ranB,2);

    ranG = G(1):G(2);
    gSize = size(ranG,2);

    ranR = R(1):R(2);
    rSize = size(ranR,2);

    b = repmat(ranB',rSize*gSize, 1);

    g = repmat(ranG, bSize, 1); 
    g = g(:);
    g = repmat(g,size(b,1)/size(g,1), 1);

    r = repmat(ranR, size(b,1)/rSize, 1);
    r = r(:);

    rgb = [r g b];
end

