matrix = double([1 0 0; 0 1 0; 0 0 1]);

degree = 0;

cosA = cosd(degree);
sinA = sind(degree);

matrix(1,1) = cosA + (1.0 - cosA) / 3.0;
matrix(1,2) = 1.0/3.0 * (1.0 - cosA) - sqrt(1.0/3.0) * sinA;
matrix(1,3) = 1.0/3.0 * (1.0 - cosA) + sqrt(1.0/3.0) * sinA;
matrix(2,1) = 1.0/3.0 * (1.0 - cosA) + sqrt(1.0/3.0) * sinA;
matrix(2,2) = cosA + 1.0/3.0*(1.0 - cosA);
matrix(2,3) = 1.0/3.0 * (1.0 - cosA) - sqrt(1.0/3.0) * sinA;
matrix(3,1) = 1.0/3.0 * (1.0 - cosA) - sqrt(1.0/3.0) * sinA;
matrix(3,2) = 1.0/3.0 * (1.0 - cosA) + sqrt(1.0/3.0) * sinA;
matrix(3,3) = cosA + 1.0/3.0 * (1.0 - cosA);

%r = colorful_flowers(:,:,1);
%r = r(:);
%g = colorful_flowers(:,:,2);
%g = g(:);
%b = colorful_flowers(:,:,3);
%b = b(:);
%rgb = [r g b];
rgb = [1 0 0];

rgbx = double(rgb) * matrix;

rgbx(rgbx>255.0) = 255.0;

rgbPic = uint8(reshape(rgbx, [1 1 3]));

figure, image(rgbPic)