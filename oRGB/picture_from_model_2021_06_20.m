datasets = ["STARE" "DiaretDB0"];
images = ["D:\workspace\DIP\oRGB\dataset\stare-photos" "D:\workspace\DIP\oRGB\dataset\diaretdb0_v_1_1\resources\images\diaretdb0_fundus_images"];
wildcard = ["\*.ppm" "\*.png*"];


output_des = "C:\Users\jessa\OneDrive - Prince of Songkla University\papers\comparative_papers\ผลการทดลอง\Proposed\exp_2021_06_20(3)\";

% result_path = "C:\Users\jessa\OneDrive - Prince of Songkla University\papers\comparative_papers\ผลการทดลอง\";
% result_files = ["retana_stats_STARE_2021_06_14.xlsx" "retana_stats_DiaretDB0_2021_06_14.xlsx"];

% header = ["file_name"...
%     "mean_r" "mean_g" "mean_b"...
%     "G/R ratio"	"B/R ratio"...
%     "min_r"	"min_g"	"min_b"...
%     "max_r"	"max_g"	"max_b"...
%     "std_r"	"std_g"	"std_b"...
%     "M3" "QSSIM" "GCF" "LOE"...
%     "mean_l" "mean_a" "mean_b"...
%     "min_l" "min_a"	"min_b"...
%     "max_l"	"max_a"	"max_b"...
%     "std_l"	"std_a"	"std_b"];

scale = 5.5;

distribution = 'rayleigh';

for original_index = 1:numel(datasets)
    files=dir(fullfile(images(original_index),wildcard(original_index)));
    n1=numel(files);
    
    if original_index == 1
        yfit = group(1:397);
    else
        yfit = group(398:end);
    end
    
    for idx = 1:n1
        im = files(idx).name;
        disp(strcat("working on: ",im))
        inImg = imread(fullfile(images(original_index),im));

        [X, inx] = ROI(inImg);
        [R,C,~] = size(inImg);
        inx_bool = zeros(R*C,1);
        inx_bool(inx) = 1;
        
        p = lookup(yfit(idx),:);
        
        [Z,~,~,~,~] = claheLab(X, inx,scale,[p(2) p(2)], [p(3) p(3)], [p(4) p(4)], [p(5) p(6) p(7)],distribution);
       
        Z = uint8(Z*255);

        Z3 = reshape(Z,[],3);
        
        Z3(~inx_bool,:) = 0;
        rgb = reshape(Z3,size(inImg));
        
        split_name = split(im,'.');
        imwrite(rgb, fullfile(output_des,(split_name(1)+".png")))
        
    end
end

disp("END!!")