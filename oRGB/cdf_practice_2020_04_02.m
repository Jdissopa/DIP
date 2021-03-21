h = l(:,2);

p = h / numel(lab(:,1));

cdf = cumsum(p);

for I = size(lab,1)
    inx = find(l(:,1) == lab(I,1));
    l3(I,1) = cdf(inx) * 100;
end

lab2 = lab;
lab2(:,1) = l3;

[~, rgb] = orgb2rgb(lab2,0);
im3column(inx,:) = uint8(rgb);
dis = reshape(im3column,size(im));

