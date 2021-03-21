folder = 'D:\workspace\DIP\oRGB\dataset\diaretdb0_v_1_1\resources\images\diaretdb0_fundus_images\';

meanRGB = [];
minRGB = [];
maxRGB = [];
stdRGB = [];

m3 = [];

meanLAB = [];
minLAB = [];
maxLAB = [];
stdLAB = [];

for  I = 1:130
    
    if I < 10
        file = strcat('image00',string(I),'.png');
    elseif I < 100
        file = strcat('image0',string(I),'.png');
    else
        file = strcat('image',string(I),'.png');
    end
    
    path = strcat(folder,file);
    
    if ~isfile(path)
        continue;
    end
        
        
    im = imread(path);

    [X,inx] = ROI(im);

    A = rgb2lab(X);
    
    X = reshape(X,[],3);
    
    % mean RGB
    meanRGB = [meanRGB;mean(X(inx,:))];
    
    % min RGB
    minRGB = [minRGB;min(X(inx,:))];

    %maxRGB
    maxRGB = [maxRGB;max(X(inx,:))];
    
    %stdRGB
    stdRGB = [stdRGB;std(double(X(inx,:)))];
    
    %M3
    m3 = [m3;m3colorfulness(X(inx,:))];
    
    A = reshape(A,[],3);
    
    %mean LAB
    meanLAB = [meanLAB;mean(A(inx,:))];
    
    %min LAB
    minLAB = [minLAB;min(A(inx,:))];
    
    %max LAB
    maxLAB = [maxLAB;max(A(inx,:))];
    
    %std LAB
    stdLAB = [stdLAB;std(A(inx,:))];
    
end


disp('end')