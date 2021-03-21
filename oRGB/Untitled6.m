im = cdata;

im3column = reshape(im,[],3);

%find ROI
[~,inx] = ROI(im);
roi = im3column(inx,:);

% lab = rgb2lab(double(roi)/255);

S = decorrstretch(reshape(roi,[],1,3),'tol',0.01,'targetMean',[192.0;96.0;32.0]);

% rgb = lab2rgb(S) * 255;

im3column(inx,:) = uint8(reshape(S,[],3));
figure, imshow(reshape(im3column,size(im)))
