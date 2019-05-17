
rgb = generateRGBinRanges([0 255], [0 255], [0 255]);
rgb = double(rgb)/255;

%plot 0,0,0 first
lcc = rgb2d2lcc(rgb);

%lcc = lcc(lcc(:,1) == 0.5,:);
lcc2 = lcc(lcc(:,1) >= 0.5 & lcc(:,1) <= 0.5001,:);
rgb = rgb(lcc(:,1) >= 0.5 & lcc(:,1) <= 0.5001,:);
clear lcc

%size(lcc2)
%size(rgb)


figure
scatter3(lcc2(1,2), lcc2(1,3), lcc2(1,1), 10, rgb(1,:), 'filled');
hold on

%lcc = rgb2d2lcc(rgb(2:end,:));
scatter3(lcc2(2:end,2), lcc2(2:end,3), lcc2(2:end,1),10,rgb(2:end,:), 'filled');

