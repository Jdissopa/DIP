%% STARE database

input_path ='D:\workspace\DIP\oRGB\dataset\stare-photos';
input_files=dir(fullfile(input_path,'\*.ppm*'));

enhanced_path = 'D:\workspace\DIP\oRGB\experiment\ETHE\STARE';
enhanced_files=dir(fullfile(enhanced_path,'\*.png*'));

%%
n1=numel(input_files);

%% stats variables
RGB_variables = zeros(n1,18);
LAB_variables = zeros(n1,12);

%%
for idx = 1:n1
    input_img_id = input_files(idx).name;
    enhanced_img_id = enhanced_files(idx).name;
    
    disp(strcat("working on: ",input_img_id))
    
    input_img = imread(fullfile(input_path,input_img_id));
    enhanced_img = imread(fullfile(enhanced_path,enhanced_img_id));
    
    input_img_3_columns = reshape(input_img,[],3);
    enhanced_img_3_columns = reshape(enhanced_img,[],3);
    
    %% roi
    [X,inx] = ROI(input_img);
    %%
    
    %% RGB
    % meanRGB
%     RGB_variables(idx,1:3) = mean(enhanced_img_3_columns(inx,:));
%     % G/R ratio and B/R ratio
%     RGB_variables(idx,4) = RGB_variables(idx,2)/RGB_variables(idx,1);
%     RGB_variables(idx,5) = RGB_variables(idx,3)/RGB_variables(idx,1);
%     % min rgb
%     RGB_variables(idx,6:8) = min(enhanced_img_3_columns(inx,:));
%     % max rgb
%     RGB_variables(idx,9:11) = max(enhanced_img_3_columns(inx,:));
%     % std RGB
%     RGB_variables(idx,12:14) = std(double(enhanced_img_3_columns(inx,:)));
%     % M3
%     RGB_variables(idx,15) = m3colorfulness(enhanced_img_3_columns(inx,:));
%     % QSSIM
%     RGB_variables(idx,16) = qssim(input_img, enhanced_img);
%     % GCF
%     RGB_variables(idx,17) = getGlobalContrastFactor(enhanced_img);
%     % LOE
%     RGB_variables(idx,18) = LOE(input_img,enhanced_img);
    %%
    
    %% LAB
    % convert enhanced image to CIELab
    enhanced_LAB = rgb2lab(enhanced_img_3_columns(inx,:));
    % mean LAB
    LAB_variables(idx,1:3) = mean(enhanced_LAB);
    % min LAB
    LAB_variables(idx,4:6) = min(enhanced_LAB);
    % max LAB
    LAB_variables(idx,7:9) = max(enhanced_LAB);
    %std LAB
    LAB_variables(idx,10:12) = std(enhanced_LAB);
    %%
end

disp("done")