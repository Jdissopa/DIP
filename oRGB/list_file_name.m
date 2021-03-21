im_path = 'D:\workspace\DIP\oRGB\dataset\diaretdb0_v_1_1\resources\images\diaretdb0_fundus_images';
im_files=dir(fullfile(im_path,'\*.png*'));

n1=numel(im_files);

for idx = 1:n1
    input_img_id = im_files(idx).name;
    img_id = split(input_img_id,".");
    
    disp(img_id{1})
end
