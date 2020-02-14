bf = imread('butterfly.jpg');

bf3Columns = reshape(double(bf), [], 3);
rg = bf3Columns(:,1) - bf3Columns(:,2);
yb = 1/2*(bf3Columns(:,1) + bf3Columns(:,2)) - bf3Columns(:,3);

orgb = rgb2orgb(double(bf));
rg2 = orgb(:,3);
yb2 = orgb(:,2);

diff = rg ~= rg2;
rgdiff = rg(diff);
rg2diff = rg2(diff);

diff = yb ~= yb2;
ybdiff = yb(diff);
yb2diff = yb2(diff);

x = (1:1:size(rgdiff,1))';
x2 = (1:1:size(ybdiff,1))';
sz = 40;

figure
scatter(x,rgdiff,sz,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5)
hold on
scatter(x,rg2diff,sz,'MarkerEdgeColor',[0.5 0 0],'MarkerFaceColor',[0.7 0 0],'LineWidth',1.5)
title('butterfly RG comparison between the equation and the oRGB')
xlabel('pixels') 
ylabel('intensity values')
legend({'RG from the equation','RG from the oRGB'},'Location','northeast')

figure
scatter(x2,ybdiff,sz,'MarkerEdgeColor',[0 .5 .5],'MarkerFaceColor',[0 .7 .7],'LineWidth',1.5)
hold on
scatter(x2,yb2diff,sz,'MarkerEdgeColor',[0.5 0 0],'MarkerFaceColor',[0.7 0 0],'LineWidth',1.5)
title('butterfly YB comparison between the equation and the oRGB')
xlabel('pixels') 
ylabel('intensity values')
legend({'YB from the equation','YB from the oRGB'},'Location','northeast')
