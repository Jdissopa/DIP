

im = retina;

%g = dStretchAJSathitRGB(im,[192 96 32]/255,[60 60 60]);
%figure, imshow(uint8(g))

%C = rgb2labOCV(reshape([32 150 200],[1,1,3]));
%C = reshape(C,[],3);

lab = rgb2lab(double(im)/255);
p = dstretch(lab,[30 100 100],[60 60 20]);
%lb = uint8(lab2rgbOCV(p) * 255);
%lb = rescale(lab2rgbOCV(p));
lb3 = lab2rgb(p);
lb = uint8(lb3 * 255);
%replace the blue band with the old one
%lb(:,:,3) = RGB(:,:,3);
figure, imshow(lb)
