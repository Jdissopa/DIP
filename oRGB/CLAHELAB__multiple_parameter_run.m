
datasets = ["STARE" "DiaretDB0"];
images = ["D:\workspace\DIP\oRGB\dataset\stare-photos" "D:\workspace\DIP\oRGB\dataset\diaretdb0_v_1_1\resources\images\diaretdb0_fundus_images"];
wildcard = ["\*.ppm" "\*.png*"];

% header = ["mean_r" "mean_g" "mean_b" "G/R ratio" "B/R ratio" "min_r" "min_g" "min_b" "max_r" "max_g" "max_b" "std_r" "std_g" "std_b" "M3" "QSSIM" "GCF" "LOE"];

result_file = "C:\Users\jessa\OneDrive - Prince of Songkla University\papers\comparative_papers\ผลการทดลอง\";
xlsfile = "";

header = ["file_name" "scale" "tile_L" "tile_A" "tile_B"...
    "cliplimit_L" "cliplimit_A" "cliplimit_B"...
    "mean_R" "mean_G" "mean_B"...
    "mean_L" "mean_A" "mean_B2"...
    "std_R" "std_G" "std_B"...
    "std_L" "std_A" "std_B2"...
    "skew_R" "skew_G" "skew_B"...
    "skew_L" "skew_A" "skew_B2"];

writematrix(header,"C:\Users\jessa\OneDrive - Prince of Songkla University\papers\comparative_papers\ผลการทดลอง\test.xlsx"

for original_index = 1:numel(datasets)
    files=dir(fullfile(images(original_index),wildcard(original_index)));
    n1=numel(files);
    
    summary_stats = zeros(35,18);
    row_count = 1;
    
    for scale = 4.5:0.5:6.5
        
        scale_str = pad(strrep(string(scale),".",""),2,'right','0');
        
        for clipLimit = 0.02:0.005:0.05
            
            clipLimit_str = pad(strrep(string(clipLimit),".",""),4,'right','0');
            
            stats_info = zeros(n1,18);

            for idx = 1:n1
                im = files(idx).name;
                disp(strcat("working on: ",im))
                inImg = imread(fullfile(images(original_index),im));

                [X, inx] = ROI(inImg);
                [Z,LABp] = claheLab(X, inx,scale,8, clipLimit,'rayleigh');
                tmp = uint8(Z*255);
                tmp3 = reshape(tmp,[],3);
                
                stats_info(idx,1:3) = mean(tmp3(inx,:));
                stats_info(idx,4) = stats_info(idx,2)/stats_info(idx,1);
                stats_info(idx,5) = stats_info(idx,3)/stats_info(idx,1);
                stats_info(idx,6:8) = min(tmp3(inx,:));
                stats_info(idx,9:11) = max(tmp3(inx,:));
                stats_info(idx,12:14) = std(double(tmp3(inx,:)));
                
                stats_info(idx,15) = m3colorfulness(tmp3);
                stats_info(idx,16) = qssim(X, tmp);
                stats_info(idx,17) = getGlobalContrastFactor(tmp(:,:,2));
                stats_info(idx,18) = LOE(X, tmp);
            end
            
            output_filename = strcat(result_file,datasets(original_index),'_',scale_str,clipLimit_str,'.xlsx')
            writematrix(stats_info,output_filename);
            
            summary_stats(row_count,:) = mean(stats_info);
            row_count = row_count + 1;
        end
    end
    
    summary_filename = strcat(result_file,'summary_',datasets(original_index),'.xlsx')
    writematrix(summary_stats,summary_filename);
        
end