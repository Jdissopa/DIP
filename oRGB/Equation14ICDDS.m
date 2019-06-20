rgb = reshape(double(retinal)/255, [], 3);

matrixMulti = [1/3 1/3 1/3; -sqrt(2)/6 -sqrt(2)/6 2*sqrt(2)/6; 1/sqrt(2) -1/sqrt(2) 0]';
iv1v2 = rgb * matrixMulti;
I = iv1v2(:,1);

k = 1.0
a = min(rgb,[],2);

ka = k * a;
Iprime = I - ka;
l = I./Iprime;

RpGpBp = (rgb - ka) .* l;

newRGB = reshape(RpGpBp, size(retinal));

figure, imshow(newRGB)