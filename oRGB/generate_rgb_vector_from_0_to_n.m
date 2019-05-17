max = 20
all = (max+1)^3;

r = floor([0:all-1] / (max+1)^2)';
g = mod(floor([0:all-1] / (max+1)),(max+1))';
b = mod(0:all-1,(max+1))';

rgb = [r g b];

