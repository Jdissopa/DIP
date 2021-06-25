
image_name = 'im0367';

%% STARE
image = strcat('D:\workspace\DIP\oRGB\dataset\stare-photos\',image_name,'.ppm');  

%% DIARET DB0
% image = strcat('D:\workspace\DIP\oRGB\dataset\diaretdb0_v_1_1\resources\images\diaretdb0_fundus_images\',image_name,'.png');

subimage = strcat('D:\workspace\DIP\oRGB\experiment\cropped\04\',image_name);

% ietk_image = strcat('D:\workspace\DIP\oRGB\experiment\iekt\DiaretDB0\sC+sX\sharpening\',image_name,'.png.png');
ietk_image = strcat('D:\workspace\DIP\oRGB\experiment\iekt\STARE\sC+sX\sharpening\',image_name,'.png');

inImg = imread(image);
subimg = imread(strcat(subimage,'\original.png'));
ietkimg = imread(ietk_image);

[x_start, x_end, y_start, y_end, ~, ~] = find_subimage_location(inImg, subimg);

% offset_x = 30;
% 
% x_start = x_start - offset_x;
% x_end = x_end - offset_x;

offset_y = 35;

y_start = y_start - offset_y;
y_end = y_end - offset_y;

X = ietkimg(x_start:x_end, y_start:y_end, :);

save_to_file(X, subimage, 'IETK_2', "png");

% figure, imshow(X)



