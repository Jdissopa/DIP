
rgb = generateRGBinRanges([200 255], [0 255], [0 255]);
rgb = double(rgb)/255;

%plot 0,0,0 first
x = rgb(1,:);
lcc = rgb2d2lcc(x);
figure
scatter3(lcc(:,2), lcc(:,3), lcc(:,1),10, x, 'filled');
hold on

lcc = rgb2d2lcc(rgb(2:end,:));
scatter3(lcc(:,2), lcc(:,3), lcc(:,1),10,rgb(2:end,:), 'filled');

