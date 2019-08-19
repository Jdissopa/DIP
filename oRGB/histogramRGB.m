function histogramRGB(RGB)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    histogram(RGB(:,:,1),40,'FaceColor','r')
    hold on
    histogram(RGB(:,:,2),40,'FaceColor','g')
    histogram(RGB(:,:,3),40,'FaceColor','b')
end

