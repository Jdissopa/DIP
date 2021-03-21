path = 'D:\workspace\DIP\oRGB\dataset\DRIMDB\008.jpg';

im = imread(path);

[X,inx] = ROI(im);

Z = claheLab(X,inx,6.5);

% X2d = reshape(X,[],3);
% a = round(mean(X2d(inx,:)));
% strX = strcat('average RGB value = [',string(a(1)),',',string(a(2)),',',string(a(3)),']');
% 
% Z2d = reshape(Z*255,[],3);
% b = round(mean(Z2d(inx,:)));
% strZ = strcat('average RGB value = [',string(b(1)),',',string(b(2)),',',string(b(3)),']');

% figure, imshowpair(X, Z, 'montage');

Zx = reshape(uint8(Z*255),[],3);
m3 = m3colorfulness(Zx(inx,:))
figure, imshow(Z)


% text(337,25,'Input','FontSize',18,'Color','blue')
% text(1133,25,'output','FontSize',18,'Color','blue')
% 
% text(225,529,strX,'FontSize',18,'Color','blue')
% text(1019,529,strZ,'FontSize',18,'Color','blue')