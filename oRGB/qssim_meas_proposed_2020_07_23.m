folder = 'D:\workspace\DIP\oRGB\dataset\DRIMDB\';

mqssim = [];
meanRGB = [];

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
        
        
    im = imread(path);

    [X,inx] = ROI(im);

    Z = claheLab(X,inx,6.5);
    
    Z = uint8(Z * 255);
    
    Zx = reshape(Z,[],3);
    
    meanRGB = [meanRGB;mean(Zx(inx,:))];

    mqssim = [mqssim;qssim(im, Z)];
    
    if mod(I,10) == 0
        disp(strcat('finished ',string(I)));
    end
    
end

disp('finished all')