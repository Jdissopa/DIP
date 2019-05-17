rgb = imread('colorful-flowers.jpg');

orgb = rgb2orgb(double(rgb)/255);

for I = 30:30:360
    rotated = rotateColor(orgb, I);
    figure, imshow(orgb2rgb(rotated, size(rgb)))
    title(strcat('Rotated ',num2str(I),' degrees counter-clockwise'))
end