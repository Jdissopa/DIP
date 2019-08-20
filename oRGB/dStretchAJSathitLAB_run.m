im = retina;


lab = rgb2labOCV(im);

g = dstretch(lab,[32 190 196],[70 20 30]);
g(:,:,3) = lab(:,:,3);

lb = lab2rgbOCV(g);

%lbn = uint8(lb * 255);
%lbn(:,:,3) = im(:,:,3);

lbx = rescale(lb);


%figure, imshow(lbn)