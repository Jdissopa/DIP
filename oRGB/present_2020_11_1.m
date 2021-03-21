path = 'D:\workspace\DIP\oRGB\dataset\DRIMDB\008.jpg';

A = imread(path);

%% padding
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

%% outter loop for 3 layers
dimTile = [72 96];
numTiles = [8 8];

for L = 1:1
    
    I = LABp;
    tmp = I;
    % extract and process each tile
    imgCol = 1;
    for col=1:numTiles(2),
      imgRow = 1;
      for row=1:numTiles(1),

        tile = I(imgRow:imgRow+dimTile(1)-1,imgCol:imgCol+dimTile(2)-1,:);
        refTile = ref(imgRow:imgRow+dimTile(1)-1,imgCol:imgCol+dimTile(2)-1,:);
        
        tile = imhistmatch(tile,refTile);
        
        num = randi([1 20],1,1);
        r = randi([1 3],1,1);
%         
        if r == 1
            tile = tile + num;
        elseif r == 2
            tile = tile - num;
        end
        
        tile(tile > 255) = 255;
        tile(tile < 0) = 0;
        
        tmp(imgRow:imgRow+dimTile(1)-1,imgCol:imgCol+dimTile(2)-1,:) = tile;

        imgRow = imgRow + dimTile(1);
      end
      imgCol = imgCol + dimTile(2); % move to the next column of tiles
    end
    
    LABp = tmp;
end

%%
figure, imshow(LABp);