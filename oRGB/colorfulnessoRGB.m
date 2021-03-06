bf = imread('desat_rabbit.jpg');

orgb = rgb2orgb(double(bf));

rg2 = orgb(:,3);
yb2 = orgb(:,2);

rhorg = std(rg);
rhoyb = std(yb);

rhorgyb = sqrt(rhorg^2 + rhoyb^2);

murg = mean(rg);
muyb = mean(yb);

murgyb = sqrt(murg^2 + muyb^2);

m3 = rhorgyb + 0.3*murgyb;