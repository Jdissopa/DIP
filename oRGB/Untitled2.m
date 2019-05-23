%convert rgb to orgb
orgb = rgb2orgb(double(pf)/255);

%convert to polar system r, theta
[theta, r] = cart2pol(orgb(:,2), orgb(:,3));

%adjust r
r(theta >= wrapToPi(deg2rad(65)) & theta <= wrapToPi(deg2rad(150))) = r(theta >= wrapToPi(deg2rad(65)) & theta <= wrapToPi(deg2rad(150))) * ((100+200)/100);

%construct l with r
lr = [orgb(:,1) r];

%adjust r to 1 at l = 0.5
%lr(lr(:,1) == 0.5, 2) = 1.0;
%adjust r at l > 0.5
%lr(lr(:,1) > 0.5, 2) = (1 - lr(lr(:,1) > 0.5, 1))/0.5;
%adjust r at l < 0.5
%lr(lr(:,1) < 0.5, 2) = lr(lr(:,1) < 0.5, 1)/0.5;

[M,N] = size(lr);
for I = 1:M
    if(lr(I,1) == 0.5)
        if(lr(I,2) > 1)
            lr(I,2) = 1.0;
        end
    elseif(lr(I,1) > 0.5)
        if(lr(I,2) > (1 - lr(I,1))/0.5)
            lr(I,2) = (1 - lr(I,1))/0.5;
        end
    else
        if(lr(I,2) > lr(I,1)/0.5)
            lr(I,2) = lr(I,1)/0.5;
        end
    end
end

%convert polar back to cartesian
[Cyb, Crg] = pol2cart(theta, lr(:,2));
orgb(:,2:3) = [Cyb Crg];

%convert orgb to rgb
pfRgbBack = orgb2rgb(orgb, size(pf));

pfrgb2d = reshape(pfRgbBack,[],3);

%figure, imshow(pf)
figure, imshow(pfRgbBack)