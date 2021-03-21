
% gaussian blur by 2 and 15
g = imgaussfilt(x012,15);

% QSSIM = qssim(x012, g);


% convert image to hsv
hsv = rgb2hsv(g);

% reduce the satuaration to 40 and 10 percent
hsv(:,:,2) = hsv(:,:,2) * 10 / 100;

% convert back to rgb
rgb = hsv2rgb(hsv);

% scale to 255
rgb = uint8(rgb * 255);

QSSIM = qssim(x012, rgb);