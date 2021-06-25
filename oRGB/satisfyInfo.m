
%% STARE
images ='D:\workspace\DIP\oRGB\dataset\stare-photos';  
files=dir(fullfile(images,'\*.ppm*'));

out_path = 'D:\workspace\DIP\oRGB\experiment\proposed\STARE\scale65';
out_file = dir(fullfile(out_path,'\*.png*'));
%% DIARET DB0
% images ='D:\workspace\DIP\oRGB\dataset\diaretdb0_v_1_1\resources\images\diaretdb0_fundus_images';  
% files=dir(fullfile(images,'\*.png*'));
% 
% out_path = 'D:\workspace\DIP\oRGB\experiment\proposed\DiaretDB0\scale65';
% out_file = dir(fullfile(out_path,'\*.png*'));

%%

n1=numel(files); 

in_red_over = zeros(n1,1);
in_marked_under = zeros(n1,1);
in_weak_green = zeros(n1,1);
in_excess_blue = zeros(n1,1);

out_red_over = zeros(n1,1);
out_marked_under = zeros(n1,1);
out_weak_green = zeros(n1,1);
out_excess_blue = zeros(n1,1);

for idx = 1:n1
    im = files(idx).name;
    disp(strcat("working on: ",im))
    inImg = imread(fullfile(images,im));
    
    [~,inx] = ROI(inImg);
    inImg_3columns = reshape(inImg,[],3);
    inImg_3columns = inImg_3columns(inx,:);
    
%     over red
    in_red_over(idx) = is_red_over(inImg_3columns(:,1));
%     marked under
    in_marked_under(idx) = mean(inImg_3columns(:,1)) < 96;
%     weak green/strong red
    in_weak_green(idx) = (mean(inImg_3columns(:,2)) / mean(inImg_3columns(:,1))) < 0.40;
%     excessive blue
    in_excess_blue(idx) = (mean(inImg_3columns(:,3)) / mean(inImg_3columns(:,1))) > 0.25;
    
    im2 = out_file(idx).name;
    outImg = imread(fullfile(out_path,im2));
    [~,inx] = ROI(outImg);
    outImg_3columns = reshape(outImg,[],3);
    outImg_3columns = outImg_3columns(inx,:);
    
    %     over red
    out_red_over(idx) = is_red_over(outImg_3columns(:,1));
%     marked under
    out_marked_under(idx) = mean(outImg_3columns(:,1)) < 96;
%     weak green/strong red
    out_weak_green(idx) = (mean(outImg_3columns(:,2)) / mean(outImg_3columns(:,1))) < 0.40;
%     excessive blue
    out_excess_blue(idx) = (mean(outImg_3columns(:,3)) / mean(outImg_3columns(:,1))) > 0.25;
end

disp('DiaretDB0')
disp('before,after')
disp(strcat('over_red,',string(sum(in_red_over)/n1*100),',',string(sum(out_red_over)/n1*100)))
disp(strcat('marked under,',string(sum(in_marked_under)/n1*100),',',string(sum(out_marked_under)/n1*100)))
disp(strcat('weak green,',string(sum(in_weak_green)/n1*100),',',string(sum(out_weak_green)/n1*100)))
disp(strcat('excessive blue,',string(sum(in_excess_blue)/n1*100),',',string(sum(out_excess_blue)/n1*100)))

function R = is_red_over(red_band)
    number_over_240 = sum(red_band >= 240);
    all_pixel = numel(red_band);
    
    percent = number_over_240/all_pixel*100;
    if percent > 15
        R = 1;
    else
        R = 0;
    end
end
