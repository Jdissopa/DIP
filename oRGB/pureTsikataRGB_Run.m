%% STARE
% images ='D:\workspace\DIP\oRGB\dataset\stare-photos';  
% dest_path = 'D:\workspace\DIP\oRGB\experiment\Scale\STARE';
% files=dir(fullfile(images,'\*.ppm*'));

%% DIARET DB0
images ='D:\workspace\DIP\oRGB\dataset\diaretdb0_v_1_1\resources\images\diaretdb0_fundus_images';  
dest_path = 'D:\workspace\DIP\oRGB\experiment\Scale\DiaretDB0';
files=dir(fullfile(images,'\*.png*'));

%%

n1=numel(files);                                       
 
for idx = 1:n1
    im = files(idx).name;
    disp(strcat("working on: ",im))
    inImg = imread(fullfile(images,im)); 
    
    [X, inx] = ROI(inImg);
  
    Z = pureTsikataRGB(X, inx);
    
    Z = uint8(Z);
    
    save_to_file(Z, dest_path, im, "png")
    
%% save to file
%     im = split(im,".");
%     im = strcat(dest_path,"\",im(1),".png");
%     imwrite(Z,im);
       
end

%% 
