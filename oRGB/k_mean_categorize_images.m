
% datasets = ["STARE" "DiaretDB0"];
% images = ["D:\workspace\DIP\oRGB\dataset\stare-photos" "D:\workspace\DIP\oRGB\dataset\diaretdb0_v_1_1\resources\images\diaretdb0_fundus_images"];
% wildcard = ["\*.ppm" "\*.png*"];
% fn = 527;


datasets = ["STARE"];
images = ["D:\workspace\DIP\oRGB\dataset\stare-photos"];
wildcard = ["\*.ppm"];
fn = 397;


filename = string(zeros(fn,1));
image_stats = zeros(fn,4);
row = 1;

for original_index = 1:numel(datasets)
    files=dir(fullfile(images(original_index),wildcard(original_index)));
    n1=numel(files);
    
    for idx = 1:n1
        im = files(idx).name;
        filename(row) = im;
        
        disp(strcat("working on: ",im))
        inImg = imread(fullfile(images(original_index),im));

        [X, inx] = ROI(inImg);
        
        pic_3_colmn = reshape(X,[],3);
        
        retina = pic_3_colmn(inx,:);
        mean_retina = mean(retina);
        
        percent_over_red = sum(retina(:,1) >= 240) / size(retina,1) * 100;

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
        
        image_stats(row,1) = category_index;
        
        A = rgb2lab(X);
        A3 = reshape(A,[],3);
        
        image_stats(row,2:end) = skewness(A3(inx,:));

        row = row + 1;
    end
end


% [idx,C] = kmeans(skew,3);
opts = statset('Display','final');
[idx,C] = kmeans(image_stats(2:end),5,'Distance','cityblock',...
    'Replicates',5,'Options',opts);

filexls = 'C:\Users\jessa\OneDrive - Prince of Songkla University\papers\comparative_papers\ผลการทดลอง\แบ่งSTARE5กลุ่มตามctgry_skewness.xlsx';

writematrix(["filename" "group" "category" "skew_L" "skew_A" "skew_B"], filexls);

for t = 1:fn
    result = {filename(t),idx(t),image_stats(t,:)};
    writecell(result, filexls, 'WriteMode', 'append');
end

disp("Done!!")