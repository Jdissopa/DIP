bf = imread('butterfly.jpg');

bf3Columns = reshape(double(bf), [], 3);
rg = bf3Columns(:,1) - bf3Columns(:,2);
yb = 1/2*(bf3Columns(:,1) + bf3Columns(:,2)) - bf3Columns(:,3);

orgb = rgb2orgb(double(bf));
rg2 = orgb(:,3);
yb2 = orgb(:,2);

x = (1:1:size(rg,1))';

figure
plot(x,rg,x,rg2)
title('butterfly RG comparison between the equation and the oRGB')
xlabel('pixels') 
ylabel('intensity values')
legend({'RG from the equation','RG from the oRGB'},'Location','northeast')

figure
plot(x,yb,x,yb2)
title('butterfly YB comparison between the equation and the oRGB')
xlabel('pixels') 
ylabel('intensity values')
legend({'YB from the equation','YB from the oRGB'},'Location','northeast')
