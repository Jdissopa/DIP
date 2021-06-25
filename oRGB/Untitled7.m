
[X,inx] = ROI(image110);

RGB = pureTsikataRGB(X, inx);
% RGB = uint8(RGB);


[RGBClahe,LABpClahe] = pureClaheLab(X);
RGBClahe = uint8(RGBClahe * 255);


roiPixels = reshape(RGBClahe,[],3);
roiPixels = roiPixels(inx,:);