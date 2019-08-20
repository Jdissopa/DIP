
im = x14_L;
%im = RGB2;

%lab
lab = rgb2labOCV(im);
dslab = dstretch(lab,[120 120 120], [60 60 60]);
rgb = lab2rgbOCV(dslab);
%rgb = rgb2displayablergb(rgb);
%rgb = uint8(rgb * 255);
%figure, imshow(rgb)
%figure, histogramRGB(x14_L)
%figure, histogramRGB(rgb)
%figure, scatter3RGB(x14_L)
%figure, scatter3RGB(rgb)
satDecor = reshape(rgb,[],3);

%rgb
%dsrgb = dstretch(double(im),[120 120 120]', [50 50 50]');
%rgb = rgb2displayablergb(dsrgb);
%figure, imshow(rgb)