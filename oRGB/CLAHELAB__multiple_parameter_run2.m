
datasets = ["STARE" "DiaretDB0"];
images = ["D:\workspace\DIP\oRGB\dataset\stare-photos" "D:\workspace\DIP\oRGB\dataset\diaretdb0_v_1_1\resources\images\diaretdb0_fundus_images"];
wildcard = ["\*.ppm" "\*.png*"];

% header = ["mean_r" "mean_g" "mean_b" "G/R ratio" "B/R ratio" "min_r" "min_g" "min_b" "max_r" "max_g" "max_b" "std_r" "std_g" "std_b" "M3" "QSSIM" "GCF" "LOE"];

result_file = "D:\workspace\DIP\oRGB\experiment\proposed\";


scale = 6.0;
clipLimit = 0.02;

scale_str = pad(strrep(string(scale),".",""),2,'right','0');
clipLimit_str = pad(strrep(string(clipLimit),".",""),4,'right','0');

inner_folder_name = strcat('scale_',scale_str,'_clip_',clipLimit_str);

for original_index = 1:numel(datasets)
    files=dir(fullfile(images(original_index),wildcard(original_index)));
    n1=numel(files);
    
    result_folder_name = strcat(result_file,datasets(original_index),'\',inner_folder_name);
    
    if ~exist(result_folder_name, 'dir')
       mkdir(result_folder_name);
    end

    for idx = 1:n1
        im = files(idx).name;
        disp(strcat("working on: ",im))
        inImg = imread(fullfile(images(original_index),im));
        
        file_name = split(im,".");
        file_name = strcat(result_folder_name,"\",file_name(1),".png");
        
        if exist(file_name, 'file')
            disp(strcat(im,' already exist'))
            continue
        end

        [X, inx] = ROI(inImg);
        
        if original_index == 1
            [R,C,~] = size(inImg);
            inx_bool = zeros(R*C,1);
            inx_bool(inx) = 1;
        end
        
        [Z,LABp] = claheLab(X, inx,scale,8, clipLimit,'rayleigh');
        tmp = uint8(Z*255);
        
        if original_index == 1
            tmp2 = reshape(tmp,[],3);
            tmp2(~inx_bool,:) = 0;
            tmp = reshape(tmp2,size(inImg));
        end
        
        %% save to file
        imwrite(tmp,file_name);
    end
            
end