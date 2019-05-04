function [rgb3Layer] = rotateColor(rgb,angleD)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    orgb = rgb2orgb(rgb);
    
    %rotate
    rotated = [orgb(:,2) orgb(:,3)] * [cosd(angleD) sind(angleD); -sind(angleD) cosd(angleD)];
    
    %replace back to orgb
    lcc = orgb;
    lcc(:,2:3) = rotated;
    
    %convert back to rgb
    rgb3Column = lcc2rgb(lcc')';
    rgb3Layer = reshape(rgb3Column, size(rgb));
    
end

