
dir = './dataset/stare-photos/';

for I = 200:202

    if I < 10
        image = 'im000';
    elseif I < 100
        image = 'im00';
    else
        image = 'im0';
    end
    
    filename = strcat(image,string(I))
    filepath = strcat(dir,filename,'.ppm');

    im = imread(filepath);
    
    figure, imshow(im)
end