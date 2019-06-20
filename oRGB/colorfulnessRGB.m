bf = imread('desat_rabbit.jpg');

bf3Columns = reshape(double(bf), [], 3);

rg = bf3Columns(:,1) - bf3Columns(:,2);
yb = 1/2*(bf3Columns(:,1) + bf3Columns(:,2)) - bf3Columns(:,3);

rhorg = std(rg);
rhoyb = std(yb);

rhorgyb = sqrt(rhorg^2 + rhoyb^2);

murg = mean(rg);
muyb = mean(yb);

murgyb = sqrt(murg^2 + muyb^2);

m3 = rhorgyb + 0.3*murgyb;