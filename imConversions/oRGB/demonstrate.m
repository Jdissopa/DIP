I = imread('peppers.png');
figure, imshow(I, [])
x = rescale(I,0,1,'InputMin',0,'InputMax',255);

peppers_orgb = rgb2orgb(x);

peppers_orgb_gray = [peppers_orgb(1,:); peppers_orgb(2:3,:) * 0];
peppers_orgb_yb = [peppers_orgb(1:2,:); peppers_orgb(3,:) * 0];
peppers_orgb_rg = [peppers_orgb(1,:); peppers_orgb(2,:) * 0; peppers_orgb(3,:)];

[~, pepper_rgb_gray] = orgb2rgb(peppers_orgb_gray, size(x));
figure, imshow(pepper_rgb_gray, []);

[~, pepper_rgb_yb] = orgb2rgb(peppers_orgb_yb, size(x));
figure, imshow(pepper_rgb_yb, []);

[~, pepper_rgb_rg] = orgb2rgb(peppers_orgb_rg, size(x));
figure, imshow(pepper_rgb_rg, []);