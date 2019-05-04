degree = 0

%convert red rgb to red orgb
redoRgb = rgb2orgb(red);

%rotate angle of the red by degree
r = sqrt(redoRgb(:,2).^2 + redoRgb(:,3).^2);
theta = atand(redoRgb(:,3)./redoRgb(:,2));
theta = theta + degree;

%convert polar back to cartesian
cyb = r .* cosd(theta);
crg = r .* sind(theta);

%replace the old one with new
redoRgb(:,2:3) = [cyb crg];

%convert back to rgb
rgbBack = orgb2rgb(redoRgb, [1 1 3]);

rgbBack(rgbBack>1.0) = 1.0;
rgbBack(rgbBack<0.0) = 0.0;
figure, image(rgbBack)
rgbBack
