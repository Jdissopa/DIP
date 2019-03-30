function [rgb3Layer, rgbMtrx] = orgb2rgb(orgb, dimension)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    %convert orgb to lcc
    lcc = orgb2lcc(orgb');
    
    %convert lcc to rgb
    rgbMtrx = lcc2rgb(lcc)';
    rgbMtrx = rescale(rgbMtrx, 0, 1, 'InputMin', 0, 'InputMax', 1);
    rgb3Layer = reshape(rgbMtrx', dimension);

end

