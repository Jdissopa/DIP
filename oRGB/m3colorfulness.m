function [m3] = m3colorfulness(image)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    rgb = reshape(double(image), [], 3);

    rg = rgb(:,1) - rgb(:,2);
    yb = 1/2*(rgb(:,1) + rgb(:,2)) - rgb(:,3);

    rhorg = std(rg);
    rhoyb = std(yb);

    rhorgyb = sqrt(rhorg^2 + rhoyb^2);

    murg = mean(rg);
    muyb = mean(yb);

    murgyb = sqrt(murg^2 + muyb^2);

    m3 = rhorgyb + 0.3*murgyb;
end

