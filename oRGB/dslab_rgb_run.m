
%im = sat;
im = x14_L;

%lab
lab = rgb2labOCV(im);
dslab = dstretch(lab,[120 120 120]', [50 50 50]');
rgb = lab2rgbOCV(dslab);
%rgb = rgb2displayablergb(rgb);
rgb = uint8(rgb * 255);
figure, imshow(rgb)

%rgb
%dsrgb = dstretch(double(im),[120 120 120]', [50 50 50]');
%rgb = rgb2displayablergb(dsrgb);
%figure, imshow(rgb)