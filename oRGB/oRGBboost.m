%im = BCET(pale_flowers,0,255,160);

orgb = rgb2orgb(pale_flowers);

ICDDSed = ICDDSoRGB(orgb, 0.3);

newRGB = orgb2rgb(ICDDSed,size(im));

%newRGB = uint8(rescale(newRGB) * 255);

%figure, imshow(im)
figure, imshow(rescale(newRGB))

figure, imshow(BCET(newRGB,0,255,180))

