datasets = ["STARE" "DiaretDB0"];
images = ["D:\workspace\DIP\oRGB\dataset\stare-photos" "D:\workspace\DIP\oRGB\dataset\diaretdb0_v_1_1\resources\images\diaretdb0_fundus_images"];
wildcard = ["\*.ppm" "\*.png*"];

propsed_img_path = "C:\Users\jessa\OneDrive - Prince of Songkla University\papers\comparative_papers\ผลการทดลอง\Proposed\exp_2021_06_20(3)\";

result_path = "C:\Users\jessa\OneDrive - Prince of Songkla University\papers\comparative_papers\ผลการทดลอง\";
result_files = ["retana_stats_STARE_2021_06_20.xlsx" "retana_stats_DiaretDB0_2021_06_20.xlsx"];

header = ["file_name"...
    "mean_r" "mean_g" "mean_b"...
    "G/R ratio"	"B/R ratio"...
    "min_r"	"min_g"	"min_b"...
    "max_r"	"max_g"	"max_b"...
    "std_r"	"std_g"	"std_b"...
    "M3" "QSSIM" "GCF" "LOE"...
    "mean_l" "mean_a" "mean_b"...
    "min_l" "min_a"	"min_b"...
    "max_l"	"max_a"	"max_b"...
    "std_l"	"std_a"	"std_b"];


for original_index = 1:numel(datasets)
    files=dir(fullfile(images(original_index),wildcard(original_index)));
    n1=numel(files);
    
    
    xlsfile = fullfile(result_path, result_files(original_index));
    writematrix(header, xlsfile);
    
    for idx = 1:n1
        im = files(idx).name;
        disp(strcat("working on: ",im))
        inImg = imread(fullfile(images(original_index),im));
        [X, inx] = ROI(inImg);
        
        sp = split(im,".");
        proposedImg = imread(fullfile(propsed_img_path,sp(1)+".png"));
        Z3 = reshape(proposedImg,[],3);
        
        meanRGB = mean(Z3(inx,:));
        
        LABp = rgb2lab(proposedImg);
        LABp3 = reshape(LABp,[],3);

        to_write = {im,...
            meanRGB,...
            [meanRGB(2)/meanRGB(1) meanRGB(3)/meanRGB(1)],...
            min(Z3(inx,:)),...
            max(Z3(inx,:)),...
            std(double(Z3(inx,:))),...
            m3colorfulness(Z3(inx,:)),...
            qssim(X, proposedImg),...
            getGlobalContrastFactor(proposedImg(:,:,2)),...
            LOE(X, proposedImg),...
            mean(LABp3(inx,:)),...
            min(LABp3(inx,:)),...
            max(LABp3(inx,:)),...
            std(LABp3(inx,:))};
        
        writecell(to_write, xlsfile, 'WriteMode', 'append');
        
%         split_name = split(im,'.');
%         imwrite(rgb, fullfile(output_des,(split_name(1)+".png")))
        
    end
end

disp("END!!")