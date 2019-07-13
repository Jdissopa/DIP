
im = sat;

%lab
lab = rgb2lab(im);
dslab = dstretch(lab,[120 120 120]', [50 50 50]');
rgb = lab2rgb(dslab);
rgb = rgb2displayablergb(rgb);
figure, imshow(rgb)

%rgb
dsrgb = dstretch(double(im),[120 120 120]', [50 50 50]');
rgb = rgb2displayablergb(dsrgb);
figure, imshow(rgb)