pf = imread('pale-flowers.jpg');

lcc = rgb2lcc(double(pf)/255);

[theta, r] = cart2pol(lcc(:,2), lcc(:,3));

for I = 20:10:100
    rt = r * ((100+I)/100);
    %rescale
    if(max(rt) > 1)
        rt = rescale(rt,'InputMin',min(rt),'InputMax',max(rt));
    end
    [c1, c2] = pol2cart(theta, rt);
    lcc(:, 2:3) = [c1 c2];
    rgb = lcc2rgb(lcc);
    rgb = reshape(rgb, size(pf));
    imwrite(rgb, strcat('rescaling_inc_sat_by_',num2str(I),'percent.jpg'))
end