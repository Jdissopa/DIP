
im = cdata;
korgb = 0.7;
krgb = 0.3;

%BCETed = BCET(ul, 0, 255, 130);

orgb = rgb2orgb(im);

ICDDSed = ICDDSoRGB(orgb,korgb);
newRGB = orgb2rgb(ICDDSed, size(im));
newRGB = uint8(rescale(newRGB) * 255);
figure, imshow(newRGB)
title(strcat('oRGB k = ', string(korgb)))

ICDDSed2 = ICDDS(im,krgb);
newRGB2 = uint8(rescale(ICDDSed2) * 255);
figure, imshow(newRGB2)
title(strcat('RGB k = ', string(krgb)))

%imwrite(newRGB, 'D:\Workspace\DIP\oRGB\nopaleimages\newones\nopale36orgb.jpg')

%BCETed = BCET(newRGB, 0, 255, 120);