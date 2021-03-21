path = 'D:\workspace\DIP\oRGB\dataset\DRIMDB\008.jpg';

A = imread(path);

% padding
padRowPre = 3;
padColPre = 4;
padRowPost = 3;
padColPost = 4;
%padding layer 1
tmp = A(:,:,1);
tmp = padarray(tmp,[padRowPre  padColPre ],'symmetric','pre');
tmp = padarray(tmp,[padRowPost padColPost],'symmetric','post');
t(:,:,1) = tmp;

%padding layer 2
tmp = A(:,:,2);
tmp = padarray(tmp,[padRowPre  padColPre ],'symmetric','pre');
tmp = padarray(tmp,[padRowPost padColPost],'symmetric','post');
t(:,:,2) = tmp;

%padding layer 3
tmp = A(:,:,3);
tmp = padarray(tmp,[padRowPre  padColPre ],'symmetric','pre');
tmp = padarray(tmp,[padRowPost padColPost],'symmetric','post');
t(:,:,3) = tmp;

%replace A
LABp = t;
%end padding

% outter loop for 3 layers
dimTile = [72 96];
% numTiles = [8 8];
numTiles = [1 1];

% figure
% [ha, pos] = tight_subplot(8,8,[.01 .01],[.1 .01],[.01 .01]);
    
I = LABp;
% extract and process each tile
p = 1;
imgRow = 1;
for row=1:numTiles(1),
  imgCol = 1;
  for col=1:numTiles(2),

    tile = I(imgRow:imgRow+dimTile(1)-1,imgCol:imgCol+dimTile(2)-1,:);
    
%     subplot(8,8,p)
%     axes(ha(p));
%     imshow(tile)
    figure
    imshow(tile)
    
    p = p + 1;
    
    imgCol = imgCol + dimTile(2);
  end
  imgRow = imgRow + dimTile(1); % move to the next column of tiles
end


