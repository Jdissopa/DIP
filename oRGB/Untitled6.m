bf = imread('pale-flowers.jpg');

lab = rgb2lab(reshape(uint8(bf),[], 3));

rg = lab(:,2);
yb = lab(:,3);

rhorg = std(rg);
rhoyb = std(yb);

rhorgyb = sqrt(rhorg^2 + rhoyb^2);

murg = mean(rg);
muyb = mean(yb);

murgyb = sqrt(murg^2 + muyb^2);

m3 = rhorgyb + 0.3*murgyb;