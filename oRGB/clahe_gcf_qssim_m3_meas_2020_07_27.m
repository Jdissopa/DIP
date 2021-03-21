folder = 'D:\workspace\DIP\oRGB\dataset\DRIMDB\';

% scale = [4,5.5,6.5,7.5,8.5,9.5,10.5,11.5,12.5];
scale = [1,2,3]

[~,col] = size(scale);

mqssim = zeros(125,col);
gcf = zeros(125,col);
m3 = zeros(125,col);

for  I = 1:126

    if I < 10
        file = strcat('00',string(I),'.jpg');
    elseif I < 100
        file = strcat('0',string(I),'.jpg');
    else
        file = strcat(string(I),'.jpg');
    end
    
    path = strcat(folder,file);
    
    if ~isfile(path)
        continue;
    end
    
    if I > 96
        row = I - 1;
    else
        row = I;
    end
        
    im = imread(path);

    [X,inx] = ROI(im);
    
    for c = 1:col
        Z = claheLab(X,inx,scale(c));
        Z = uint8(Z * 255);
        Zx = reshape(Z,[],3);
        
        mqssim(row,c) = qssim(im,Z);
        gcf(row,c) = getGlobalContrastFactor(Z);
        m3(row,c) = m3colorfulness(Zx(inx,:));
    end
    
    if mod(I,10) == 0
        disp(strcat('finished ',string(I)));
    end
    
end

disp('finished all')