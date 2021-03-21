path = 'D:\workspace\DIP\oRGB\dataset\DRIMDB\011.jpg';
% path = 'D:\workspace\DIP\oRGB\dataset\005-02.jpg';

im = imread(path);

[X,inx] = ROI(im);

% im3 = reshape(im,[],3);
% 
% ext = im3(inx,:);
% 
% lab = rgb2lab(ext);
% 
% lab(:,2) = lab(:,2)* 0.5;
% lab(:,3) = lab(:,3)* 0.5;
% 
% ext = uint8(lab2rgb(lab)*255);
% 
% im3(inx,:) = ext;
% 
% X = reshape(im3,size(X));

Z = claheLab(X,inx,6.5);
    
Z = uint8(Z * 255);


% gcfImGray = getGlobalContrastFactor(rgb2gray(im))
gcfImGreen = getGlobalContrastFactor(im(:,:,2))
% 
% gcfZGray = getGlobalContrastFactor(rgb2gray(Z))
% gcfZGreen = getGlobalContrastFactor(Z(:,:,2))


% lab = rgb2lab(im3(inx,:));
% 
% lab(:,2) = lab(:,2)* 0.7;
% lab(:,3) = lab(:,3)* 0.7;
% 
% rgb = uint8(lab2rgb(lab)*255);
% im3(inx,:) = rgb;

% m3 = m3colorfulness(im3(inx,:))
% 
% im3 = reshape(im3,size(im));
% 
% Z = claheLab(X,inx,6.5);
% Zx = reshape(uint8(Z*255),[],3);
% m3colorfulness(Zx(inx,:))

% figure, imshow(im3)
% figure, imshow(im)
% figure, imshow(Z)


