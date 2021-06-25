
image_name = 'im0367';

%% STARE
image = strcat('D:\workspace\DIP\oRGB\dataset\stare-photos\',image_name,'.ppm');  

%% DIARET DB0
% image = strcat('D:\workspace\DIP\oRGB\dataset\diaretdb0_v_1_1\resources\images\diaretdb0_fundus_images\',image_name,'.png');

subimage = strcat('D:\workspace\DIP\oRGB\experiment\cropped\04\',image_name);

% prop_image = strcat('D:\workspace\DIP\oRGB\experiment\proposed\DiaretDB0\scale_60_clip_0020\',image_name,'.png');
prop_image = strcat('D:\workspace\DIP\oRGB\experiment\proposed\STARE\scale_60_clip_0020\',image_name,'.png');

inImg = imread(image);
subimg = imread(strcat(subimage,'\original.png'));
propimg = imread(prop_image);

[x_start, x_end, y_start, y_end, ~, ~] = find_subimage_location(inImg, subimg);

X = propimg(x_start:x_end, y_start:y_end, :);

save_to_file(X, subimage, 'proposed_2', "png");



