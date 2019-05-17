minb = 150;
maxb = 200;
ranB = minb:maxb;
bSize = size(ranB,2);

ming = 150;
maxg = 200;
ranG = ming:maxg;
gSize = size(ranG,2);

minr = 198;
maxr = 200;
ranR = minr:maxr;
rSize = size(ranR,2);


b = repmat(ranB',rSize*gSize, 1);

g = repmat(ranG, bSize, 1); 
g = g(:);
g = repmat(g,size(b,1)/size(g,1), 1);

r = repmat(ranR, size(b,1)/rSize, 1);
r = r(:);

rgb = [r g b]

