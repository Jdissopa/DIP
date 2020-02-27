
idealMean = [192 96 32];
brightRange = [128 128 16];

im = imread('./retinal_quality/6_good.JPG');

[X, inx] = ROI(im);
im3column = reshape(X,[],3);
roi = im3column(inx,:);

covs = cov(double(roi));
[V,D] = svd(covs);
[x,newData] = dstretchLAB_version6_2(double(roi),idealMean,brightRange,V,4.8);

%x(:,3) = roi(:,3) - mean(x(:,3)) + 32;

im_vector = reshape(im,[],3);
im_vector(inx,:) = uint8(x);
dis = reshape(im_vector,size(im));

min(x)
max(x)
mean(uint8(x))

cr = sum(x(:,1) >= 112 & x(:,1) <= 240);
cg = sum(x(:,2) >= 16 & x(:,2) <= 144);
cb = sum(x(:,3) >= 16 & x(:,3) <= 32);
all = size(x,1);

redCover = cr /all
greenCover = cg /all
blueCover = cb /all

Ls = sum(x,2)/3;
L = sum(Ls >= 48 & Ls <= 144) / all

figure, imshow(dis)
figure, histogramRGB(x,256)