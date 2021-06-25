

datasets = ["STARE" "DiaretDB0"];
images = ["D:\workspace\DIP\oRGB\dataset\stare-photos" "D:\workspace\DIP\oRGB\dataset\diaretdb0_v_1_1\resources\images\diaretdb0_fundus_images\"];
wildcard = ["\*.ppm" "\*.png*"];

output = "D:\workspace\DIP\oRGB\experiment\proposed\";

result_file = "C:\Users\jessa\OneDrive - Prince of Songkla University\papers\comparative_papers\ผลการทดลอง\";
xlsfile = "Adjust_parameter_attemp01.xlsx";

header = ["file_name" "scale"...
    "tile_row_L" "tile_col_L"...
    "tile_row_A" "tile_col_A"...
    "tile_row_B" "tile_col_B"...
    "cliplimit_L" "cliplimit_A" "cliplimit_B"...
    "mean_R" "mean_G" "mean_B"...
    "mean_L" "mean_A" "mean_B2"...
    "mean_L'" "mean_A'" "mean_B2'"...
    "std_R" "std_G" "std_B"...
    "std_L" "std_A" "std_B2"...
    "std_L'" "std_A'" "std_B2'"...
    "skew_R" "skew_G" "skew_B"...
    "skew_L" "skew_A" "skew_B2"...
    "skew_L'" "skew_A'" "skew_B2'"];

writematrix(header, result_file+xlsfile);

tiles = [3,6,12,24,48];

for original_index = 1:numel(datasets)
    files=dir(fullfile(images(original_index),wildcard(original_index)));
    n1=numel(files);
    
    for idx = 1:n1
        im = files(idx).name;
        disp(strcat("working on: ",im))
        inImg = imread(fullfile(images(original_index),im));

        [X, inx] = ROI(inImg);
        
        for scale = 7.5:-0.5:4.5
            for tileL_inx = 1:length(tiles)
                tile_L = [tiles(tileL_inx) tiles(tileL_inx)];
                for tileA_inx = 1:length(tiles)
                    tile_A = [tiles(tileA_inx) tiles(tileA_inx)];
                    for tileB_inx = 1:length(tiles)
                        tile_B = [tiles(tileB_inx) tiles(tileB_inx)];
                        
                        clipLimitL = 0.001;
                        clipLimitA = 0.001;
                        clipLimitB = 0.001;
                        
                        disp("working on: " + im + " scale " + scale...
                            + "tileL[" + tile_L(1) + "," + tile_L(2) + "]"...
                            + " , tileA[" + tile_A(1) + "," + tile_A(2) + "]"...
                            + " , tileB[" + tile_B(1) + "," + tile_B(2) + "]")
                        
                        [Z,LABp,contrast_lab,mean_lab, skew_lab] = claheLab(X, inx,scale,tile_L, tile_A, tile_B, [clipLimitL clipLimitA clipLimitB],'rayleigh');
                        
                        [clipLimitL,Z,LABp,contrast_lab,mean_lab,skew_lab] = find_clipLimit(X,inx,scale,[clipLimitL clipLimitA clipLimitB], skew_lab, tile_L, tile_A, tile_B, 1,Z,LABp,contrast_lab,mean_lab);
                        [clipLimitA,Z,LABp,contrast_lab,mean_lab,skew_lab] = find_clipLimit(X,inx,scale,[clipLimitL clipLimitA clipLimitB], skew_lab, tile_L, tile_A, tile_B, 2,Z,LABp,contrast_lab,mean_lab);
                        [clipLimitB,Z,LABp,contrast_lab,mean_lab,skew_lab] = find_clipLimit(X,inx,scale,[clipLimitL clipLimitA clipLimitB], skew_lab, tile_L, tile_A, tile_B, 3,Z,LABp,contrast_lab,mean_lab);
                            
                        
                        Z_3_columns = reshape(Z, [],3);
                        LABp_3_columns = reshape(LABp,[],3);
                        
%                         ["file_name" "scale"...
%                         "tile_row_L" "tile_col_L"...
%                         "tile_row_A" "tile_col_A"...
%                         "tile_row_B" "tile_col_B"...
%                         "cliplimit_L" "cliplimit_A" "cliplimit_B"...
%                         "mean_R" "mean_G" "mean_B"...
%                         "mean_L" "mean_A" "mean_B2"...
%                         "mean_L'" "mean_A'" "mean_B2'"...
%                         "std_R" "std_G" "std_B"...
%                         "std_L" "std_A" "std_B2"...
%                         "std_L'" "std_A'" "std_B2'"...
%                         "skew_R" "skew_G" "skew_B"...
%                         "skew_L" "skew_A" "skew_B2"...
%                         "skew_L'" "skew_A'" "skew_B2'"];

                        to_write = {im,scale,...
                            tile_L,...
                            tile_A,...
                            tile_B,...
                            [clipLimitL clipLimitA clipLimitB],...
                            mean(Z_3_columns(inx,:)),...
                            mean_lab,...
                            mean(LABp_3_columns(inx,:)),...
                            std(double(Z_3_columns(inx,:)))...
                            contrast_lab,...
                            std(LABp_3_columns(inx,:)),...
                            skewness(double(Z_3_columns(inx,:))),...
                            skew_lab,...
                            skewness(LABp_3_columns(inx,:))};
                        
                        
                        writecell(to_write, result_file+xlsfile, 'WriteMode', 'append');
                        
                    end
                end
            end
        end
        
    end
end

disp("end")

function [clipLimit_return,Z,LABp,contrast_lab,mean_lab,skew_lab] = find_clipLimit(X,inx,scale,clipLimit, skew_lab, tile_L, tile_A, tile_B, index,Z,LABp,contrast_lab,mean_lab)
    repeating_detect_inx = 2;
    repeating_detect = ones(1,5) * -Inf;

    repeating_detect(1) = skew_lab(index);
    getInLoop = 0;
    while (skew_lab(index) < 0) && (~all(repeating_detect(:) == repeating_detect(1)))
        getInLoop = 1;
        clipLimit(index) = clipLimit(index) + 0.001;
        
        [Z,LABp,contrast_lab,mean_lab, skew_lab] = claheLab(X, inx,scale,tile_L, tile_A, tile_B, clipLimit,'rayleigh');
        
        if repeating_detect(1) == skew_lab(index)
            repeating_detect(repeating_detect_inx) = skew_lab(index);
            repeating_detect_inx = repeating_detect_inx + 1;
        elseif repeating_detect(repeating_detect_inx - 1) > skew_lab(index)
            break;
        else
            repeating_detect = ones(1,5) * -Inf;
            repeating_detect(1) = skew_lab(index);
            repeating_detect_inx = 2;
        end
    end
    
    if all(repeating_detect == repeating_detect(1))
        clipLimit_return = clipLimit(index) - (0.001*5);
    elseif getInLoop
        clipLimit_return = clipLimit(index) - 0.001;
    else
        clipLimit_return = clipLimit(index);
    end
end

