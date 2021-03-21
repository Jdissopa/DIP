

imageFolder = './dataset/diaretdb0_v_1_1/resources/images/diaretdb0_fundus_images/';
filepath = strcat(imageFolder,'image001.png');

im = imread(filepath);

[~,inx] = ROI(im);

im3column = reshape(im,[],3);
roi = im3column(inx,:);

lab = rgb2lab(double(roi)/255);

figure, histogram(lab(:,1))
title('L')
figure, histogram(lab(:,2))
title('A')
figure, histogram(lab(:,3))
title('B')


all = size(lab,1);

[NL,edgesL] = histcounts(lab(:,1));
CDFL = [];
CDFL(1,1) = double(NL(1))/all;
for I = 2:size(NL,2)
    CDFL(1,I) = CDFL(1,I-1) + double(NL(I))/all;
end
CDFLPercent = CDFL * 100;

[NA,edgesA] = histcounts(lab(:,2));
CDFA = [];
CDFA(1,1) = double(NA(1))/all;
for I = 2:size(NA,2)
    CDFA(1,I) = CDFA(1,I-1) + double(NA(I))/all;
end
CDFAPercent = CDFA * 100;


[NB,edgesB] = histcounts(lab(:,3));
CDFB = [];
CDFB(1,1) = double(NB(1))/all;
for I = 2:size(NB,2)
    CDFB(1,I) = CDFB(1,I-1) + double(NB(I))/all;
end
CDFBPercent = CDFB * 100;

% I = 1;
% X = [];
% Y = [];
% start = 3.5;
% stop = 62.9;
% while start ~= 62.9
%     
% end



