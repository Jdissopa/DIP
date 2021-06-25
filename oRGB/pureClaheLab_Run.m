%% STARE
images ='D:\workspace\DIP\oRGB\dataset\stare-photos';  
dest_path = 'D:\workspace\DIP\oRGB\experiment\CLAHE\STARE';
files=dir(fullfile(images,'\*.ppm*'))

%% DIARET DB0
% images ='D:\workspace\DIP\oRGB\dataset\diaretdb0_v_1_1\resources\images\diaretdb0_fundus_images';  
% dest_path = 'D:\workspace\DIP\oRGB\experiment\CLAHE\DiaretDB0';
% files=dir(fullfile(images,'\*.png*'))

%%

n1=numel(files);                                       
 
for idx = 1:n1
    im = files(idx).name;
    disp(strcat("working on: ",im))
    inImg = imread(fullfile(images,im)); 
  
    Z = pureClaheLab(inImg);
    
    Z = uint8(Z*255);
    
    save_to_file(Z, dest_path, im, "png")
    
%% save to file
%     im = split(im,".");
%     im = strcat(dest_path,"\",im(1),".png");
%     imwrite(Z,im);
       
end

%% 
