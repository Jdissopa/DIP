
filenames = {["01" "image001.png" "image005.png" "image010.png" "image130.png" "D:\workspace\DIP\oRGB\dataset\diaretdb0_v_1_1\resources\images\diaretdb0_fundus_images"], ...
    ["02" "image013.png" "image040.png" "image046.png" "image050.png" "D:\workspace\DIP\oRGB\dataset\diaretdb0_v_1_1\resources\images\diaretdb0_fundus_images"], ...
    ["03" "im0052.ppm" "im0102.ppm" "im0316.ppm" "im0354.ppm" "D:\workspace\DIP\oRGB\dataset\stare-photos"], ...
    ["04" "im0356.ppm" "im0357.ppm" "im0359.ppm" "im0367.ppm" "D:\workspace\DIP\oRGB\dataset\stare-photos"]};

% sets = ["01" "02" "03" "04"];

% tmp = split(filename, ".");
% dest_path = strcat("D:\workspace\DIP\oRGB\experiment\cropped\04\", tmp(1), "\");
% 
% files = [strcat("D:\workspace\DIP\oRGB\dataset\stare-photos\",filename) ...
%         strcat("D:\workspace\DIP\oRGB\experiment\ETHE\STARE\",tmp(1),".png") ...
%         strcat("D:\workspace\DIP\oRGB\experiment\iekt\STARE\sC+sX\sharpening\", tmp(1),".png") ...
%         strcat("D:\workspace\DIP\oRGB\experiment\proposed\STARE\scale65\",tmp(1),".png") ...
%         strcat("D:\workspace\DIP\oRGB\experiment\CLAHE\STARE\", tmp(1),".png") ...
%         strcat("D:\workspace\DIP\oRGB\experiment\Scale\STARE\", tmp(1),".png")];
    
% method = ["original" "ETHE" "IETK" "proposed" "CLAHE" "scale"];

% inImg = imread(files(1));
% [J,rect] = imcrop(inImg);
% save_to_file(J, dest_path, method(1), "png");

original_crop_image = "D:\workspace\DIP\oRGB\experiment\cropped";

adjusted_path = "C:\Users\jessa\OneDrive - Prince of Songkla University\papers\comparative_papers\ผลการทดลอง\Proposed\exp_2021_05_31";
% proposed_dir_path
    
for idx = 1:numel(filenames)
    
    file_vector = filenames{idx};
    
    proto_file_path = fullfile(original_crop_image,file_vector(1));
    
    for f = 5:5
        f_name = split(file_vector(f),".");
        
        final_original_file = fullfile(proto_file_path,f_name(1),"original.png");
        
        inImg = imread(fullfile(file_vector(end),file_vector(f)));
        subimg = imread(final_original_file);
        
        propimg = imread(fullfile(adjusted_path,f_name(1)+".png"));
        
        [x_start, x_end, y_start, y_end, ~, ~] = find_subimage_location(inImg, subimg);
        X = propimg(x_start:x_end, y_start:y_end, :);
        save_to_file(X, fullfile(proto_file_path,f_name(1)), 'proposed_3', "png");
    end
    
    
    
%     [J,~] = imcrop(inImg,rect);
%     
%     save_to_file(J, dest_path, method(idx), "png");
end
    