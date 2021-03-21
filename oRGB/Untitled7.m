
[X,inx] = ROI(image110);

RGB = pureTsikataRGB(X, inx);
RGB = uint8(RGB);


[RGBClahe,LABpClahe] = pureClaheLab(RGB);
RGBClahe = uint8(RGBClahe * 255);