c = zeros(3,4,3);

color = red;

for I = 0:3
    c(1,I+1,:) = rotateColor(color, I*30);
end

for I = 4:7
    c(2,I-3,:) = rotateColor(color, I*30);
end

for I = 8:11
    c(3,I-7,:) = rotateColor(color, I*30);
end

figure, image(c)