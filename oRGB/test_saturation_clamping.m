pf = x3_bad;

lcc = rgb2lcc(double(pf)/255);

[theta, r] = cart2pol(lcc(:,2), lcc(:,3));

rt = r * ((100+50)/100);
[c1, c2] = pol2cart(theta, rt);
lcc(:, 2:3) = [c1 c2];
rgb = lcc2rgb(lcc);
rgb = reshape(rgb, size(pf));

figure, imshow(rgb)

%for I = 20:10:100
 %   rt = r * ((100+I)/100);
    %clamping
  %  rt(rt > 1) = 1;
   % [c1, c2] = pol2cart(theta, rt);
   % lcc(:, 2:3) = [c1 c2];
   % rgb = lcc2rgb(lcc);
   % rgb = reshape(rgb, size(pf));
   % imwrite(rgb, strcat('rabbit_clamping_inc_sat_by_',num2str(I),'percent.jpg'))
%end