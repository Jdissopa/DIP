

datasets = ["STARE" "DiaretDB0"];
images = ["D:\workspace\DIP\oRGB\dataset\stare-photos" "D:\workspace\DIP\oRGB\dataset\diaretdb0_v_1_1\resources\images\diaretdb0_fundus_images"];
wildcard = ["\*.ppm" "\*.png*"];

output = "D:\workspace\DIP\oRGB\categories\";
category = ["red_oversaturation" "under_illumination" "weak_green" "excessive_blue" "other"];

for original_index = 1:numel(datasets)
    files=dir(fullfile(images(original_index),wildcard(original_index)));
    n1=numel(files);
    
    for idx = 1:n1
        im = files(idx).name;
        disp(strcat("working on: ",im))
        inImg = imread(fullfile(images(original_index),im));

        [X, inx] = ROI(inImg);
        
        pic_3_colmn = reshape(X,[],3);
        
        retina = pic_3_colmn(inx,:);
        mean_retina = mean(retina);
        
        written_file_name = split(im,".");
        written_file_name = strcat(written_file_name(1),".png");
        
%       count percent red pixel values >= 240
        percent_over_red = sum(retina(:,1) >= 240) / size(inx,1) * 100;
        
        category_index = 0;
        
        if percent_over_red > 15
            category_index = 1;
        elseif mean_retina(1) < 96
            category_index = 2;
        elseif mean_retina(2) / mean_retina(1) < 0.40
            category_index = 3;
        elseif mean_retina(3) / mean_retina(1) > 0.25
            category_index = 4;
        else
            category_index = 5;
        end
        
        filename = strcat(output,category(category_index),"\",datasets(original_index),"\",written_file_name);
        imwrite(inImg,filename);
        
    end
end

disp("end")