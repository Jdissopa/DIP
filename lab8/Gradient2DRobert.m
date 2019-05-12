function [Z]=Gradient2DRobert(f)
% f : array of digital data, size M?N
[M,N] = size(f);
for x = 2:M
for y=2:N
Z(x,y) = abs(f(x,y)-f(x-1,y-1))+abs(f(x,y-1)-f(x-1,y-1));
end
end
end
