path = 'D:\workspace\DIP\oRGB\dataset\DRIMDB\008.jpg';

im = imread(path);

[X,inx] = ROI(im);

A = rgb2lab(X);

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
A = t;
%end padding
%%
 
mn = min(min(A));
mx = max(max(A));
mx = mx(:); mn = mn(:);
LABp = A;
LABp(:,:,1) = (A(:,:,1)-mn(1))/(mx(1)-mn(1));
LABp(:,:,2) = (A(:,:,2)-mn(2))/(mx(2)-mn(2));
LABp(:,:,3) = (A(:,:,3)-mn(3))/(mx(3)-mn(3));

%% outter loop for 3 layers
dimTile = [72 96];
numTiles = [8 8];

for L = 1:3
    
    I = LABp(:,:,L);
    
    % load histogram of each layer
    if L == 1
        load('tileHistsL.mat');
    elseif L == 2
        load('tileHistsA.mat');
    else
        load('tileHistsB.mat');
    end

    % extract and process each tile
    imgCol = 1;
    for col=1:numTiles(2),
      imgRow = 1;
      for row=1:numTiles(1),

        tile = I(imgRow:imgRow+dimTile(1)-1,imgCol:imgCol+dimTile(2)-1);

        tile = histeq(tile,tileHists{row,col});
        
        I(imgRow:imgRow+dimTile(1)-1,imgCol:imgCol+dimTile(2)-1) = tile;

        imgRow = imgRow + dimTile(1);
      end
      imgCol = imgCol + dimTile(2); % move to the next column of tiles
    end
    
    LABp(:,:,L) = I;
    clear tileHists;
end

%% denormalize
LABp(:,:,1) = LABp(:,:,1)*(mx(1)-mn(1)) + mn(1);
LABp(:,:,2) = LABp(:,:,2)*(mx(2)-mn(2)) + mn(2);
LABp(:,:,3) = LABp(:,:,3)*(mx(3)-mn(3)) + mn(3);

%% reverse to rgb
Z = lab2rgb(LABp);
