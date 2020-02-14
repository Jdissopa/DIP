rgb = double(reshape(pale_flowers, [], 3));

iv1v2 = rgb * [1/3 1/3 1/3;-1/sqrt(6) -1/sqrt(6) 2/sqrt(6); 1/sqrt(6) -2/sqrt(6) 0]';
v1 = iv1v2(:,2);
v2 = iv1v2(:,3);
H = atan(v2./v1);

Sprime = sqrt(v1.^2 + v2.^2);

k = 0.3

newV1 = (k*Sprime) .* cos(2*pi*H);
newV2 = (k*Sprime) .* sin(2*pi*H);

newIv1v2 = [iv1v2(:,1) newV1 newV2];

newRGB = newIv1v2 * [1 -1/2*sqrt(6) 3/2*sqrt(6);1 -1/2*sqrt(6) -3/2*sqrt(6);1 1/sqrt(6) 0]';

newRGB = uint8(rescale(newRGB, 0, 255));

newRGB = reshape(newRGB, size(output));

figure, imshow(newRGB,[])