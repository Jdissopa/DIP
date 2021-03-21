%% STARE
images ='D:\workspace\DIP\oRGB\dataset\stare-photos';  
dest_path = 'D:\workspace\DIP\oRGB\experiment\ETHE\STARE';
files=dir(fullfile(images,'\*.ppm*'))

%% DIARET DB0
% images ='D:\workspace\DIP\oRGB\dataset\diaretdb0_v_1_1\resources\images\diaretdb0_fundus_images';  
% dest_path = 'D:\workspace\DIP\oRGB\experiment\ETHE\DiaretDB0';
% files=dir(fullfile(images,'\*.png*'))

%%

n1=numel(files);                                       
 
for idx = 1:n1
    im = files(idx).name
    inImg = imread(fullfile(images,im));                                         		       
    [m,n,k] = size(inImg);
    IQA(idx) = brisque(inImg);
    for i = 1:3
            x0 = inImg(:,:,i);
            inImg(:,:,i)=ETHE(x0,1);
    end
%% BRISQUE – Image Quality Evaluator
    IQA1(idx) = brisque(inImg);
    
%% save to file
    im = split(im,".");
    im = strcat(dest_path,"\",im(1),".png")
    imwrite(inImg,im);
       
end

%%
 
MeanIQA = mean(IQA)
MeanIQA1 = mean(IQA1)
percentagechange = [(MeanIQA-MeanIQA1)/MeanIQA]*100
 
figure;
plot(IQA,'b');
hold on;
plot(IQA1,'r');
title(['\fontsize{20}Image Quality Variations']);
legend(['\fontsize{12}Initial Image Quality'],['\fontsize{12}Image Quality after Enhancement']);
xlabel('Image Number','FontSize',12)
ylabel('Image Quality','FontSize',12)
