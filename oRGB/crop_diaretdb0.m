
filename = "image050.png";
tmp = split(filename, ".");
dest_path = strcat("D:\workspace\DIP\oRGB\experiment\cropped\02\", tmp(1), "\");

files = [strcat("D:\workspace\DIP\oRGB\dataset\diaretdb0_v_1_1\resources\images\diaretdb0_fundus_images\",filename) ...
        strcat("D:\workspace\DIP\oRGB\experiment\ETHE\DiaretDB0\",filename) ...
        strcat("D:\workspace\DIP\oRGB\experiment\iekt\DiaretDB0\sC+sX\sharpening\", filename,".png") ...
        strcat("D:\workspace\DIP\oRGB\experiment\proposed\DiaretDB0\scale65\",filename) ...
        strcat("D:\workspace\DIP\oRGB\experiment\CLAHE\DiaretDB0\", filename) ...
        strcat("D:\workspace\DIP\oRGB\experiment\Scale\DiaretDB0\", filename)];
    
method = ["original" "ETHE" "IETK" "proposed" "CLAHE" "scale"];

inImg = imread(files(1));
[J,rect] = imcrop(inImg);
save_to_file(J, dest_path, method(1), "png");
    
for idx = 2:6
    inImg = imread(files(idx));
    
    [J,~] = imcrop(inImg,rect);
    
    save_to_file(J, dest_path, method(idx), "png");
end
    