%%
%load all the adjusted images and then convert to oRGB to take a look on
%their statistical characteristics in oRGB color model, consists of 
%
%mean  
%      meanL meanYB meanRG
% pic1  x.xx x.xx  x.xx
% pic2  x.xx x.xx  x.xx
%
%min 
%       minL minYB  minRG
% pic1  x.xx x.xx  x.xx
% pic2  x.xx x.xx  x.xx
%
%max
%       maxL maxYB  maxRG
% pic1  x.xx x.xx  x.xx
% pic2  x.xx x.xx  x.xx
%

%%

imageFolder = './retinal_quality/2020-02-28_diaret_3/';

for I = 1:130

    if I < 10
        image = 'image00';
    elseif I < 100
        image = 'image0';
    else
        image = 'image';
    end
    
    filename = strcat(image,string(I));
    filepath = strcat(imageFolder,filename,'.png');

    im = imread(filepath);

    [~,inx] = ROI(im);
    
    im3column = reshape(im,[],3);
    roi = im3column(inx,:);
    
    lybrg = rgb2orgb(double(roi));
    
    Mean(I,:) = mean(lybrg);
    Min(I,:) = min(lybrg);
    Max(I,:) = max(lybrg);
    
    sd = std(lybrg);
    
    XMin(I,:) = -1.96 * sd + Mean(I,:);
    XMax(I,:) = 1.96 * sd + Mean(I,:);
    disp(string(I))
end

wr = [Mean Min(:,1) Max(:,1) Min(:,2) Max(:,2) Min(:,3) Max(:,3) XMin(:,1) XMax(:,1) XMin(:,2) XMax(:,2) XMin(:,3) XMax(:,3)];
writematrix(wr,'D:\Workspace\DIP\oRGB\analysis\orgb_stats2.csv');
disp('end')
%%