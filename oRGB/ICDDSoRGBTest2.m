
im = pale1;
k = 0.5;

%BCETed = BCET(ul, 0, 255, 130);

orgb = rgb2orgb(im);

ICDDSed = ICDDSoRGB(orgb,k);

newRGB = orgb2rgb(ICDDSed, size(im));

newRGB = uint8(rescale(newRGB) * 255);

figure, imshow(newRGB)
title(strcat('k = ', string(k)))

%BCETed = BCET(newRGB, 0, 255, 120);