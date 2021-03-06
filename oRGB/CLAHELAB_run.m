%% STARE
% images ='D:\workspace\DIP\oRGB\dataset\stare-photos';  
% dest_path = 'D:\workspace\DIP\oRGB\experiment\proposed\STARE\scale85';
% files=dir(fullfile(images,'\*.ppm*'))

%% DIARET DB0
images ='D:\workspace\DIP\oRGB\dataset\diaretdb0_v_1_1\resources\images\diaretdb0_fundus_images';  
dest_path = 'D:\workspace\DIP\oRGB\experiment\proposed\DiaretDB0\scale65';
files=dir(fullfile(images,'\*.png*'))

%%

n1=numel(files);                                       
 
for idx = 20:20
    im = files(idx).name;
    disp(strcat("working on: ",im))
    inImg = imread(fullfile(images,im)); 
    
%     [J,rect] = imcrop(inImg);
    
    % ROI
    [X, inx] = ROI(inImg);
  
    [Z,LABp] = claheLab(X, inx,6.5,[8 8],0.02);
    
    tmp = uint8(Z*255);
    
    figure, imshow(tmp)
    
%% save to file
%     im = split(im,".");
%     im = strcat(dest_path,"\",im(1),".png");
%     imwrite(Z,im);
       
end

%% 
