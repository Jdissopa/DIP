
folder = 'D:\workspace\DIP\oRGB\dataset\DRIMDB\';

BrightRange = [32.3438, 65.8206, 10.0466];
Brightness = [51.4732   34.5079   51.0550];

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

    A = rgb2lab(X);
    
    A = reshape(A,[],3);
    B = A(inx,:);

    muVec = mean(B,1);        % Vector of mean in each band
    sdx = std(B,0,1);
    scaleA = BrightRange./(8.5*sdx);
    offset = Brightness - scaleA.*muVec;

    B = bsxfun(@plus, B*diag(scaleA), offset);
    A(inx, :) = B;  
    
    [R, C, nBands] = size(X);
    LABp = reshape(A, [R C nBands]);
    Z = lab2rgb(LABp);

    Z = uint8(Z * 255);
    
    Zx = reshape(Z,[],3);
    
    meanRGB = [meanRGB;mean(Zx(inx,:))];

    mqssim = [mqssim;qssim(im, Z)];
    
    if mod(I,10) == 0
        disp(strcat('finished ',string(I)));
    end
end

disp('finished all')