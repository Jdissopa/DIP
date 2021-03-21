%read data
im = cdata;

%reshape
im3column = reshape(im,[],3);

%find ROI
[~,inx] = ROI(im);
roi = im3column(inx,:)

%get the area not include vain and mecula
meanG = mean(double(roi(:,2)));
stdG = std(double(roi(:,2)));
meanSubStd = meanG - stdG;
meanAddStd = meanG + stdG;

roi2Inx = find((roi(:,2) >= meanSubStd & roi(:,2) <= meanAddStd));

X = roi(roi2Inx,:);



%Normalize X so X in range [0,1]
Xnew = double(X) / 255;

%calculate variable Q or SIGMA_target
Q = std(Xnew);
Q(2) = Q(1);
Q = diag(Q);

%calculate eigenvector and eigenvalue
covs = cov(Xnew);
[U,D] = svd(covs);

%calculate scale to stretch
E = diag([1 1 0]);
sc = (D * E).^(-1/2);
sc(isinf(sc) | isnan(sc)) = 0;

%calculate T transformation function
T = U * sc * U' * Q;

%set m(ean)_target
C = (double([192 96 32]) / 255);

%improve quality of input something
roi = medfilt3(roi,[3,3,3]);

%Normalize the whole roi area
B = double(roi)/255;

%calculate the roi mean
meanB = mean(B);

%resemble all together to get the output
G = (B - meanB) * T;

%
rgb = G * 255;

%check mean of G
meanRGB = mean(rgb);
stdRGB = std(rgb);
MaxRGB = max(rgb);
MinRGB = min(rgb);

%display part
im3column(inx,:) = uint8(rgb);
dis = reshape(im3column,size(im));
imshow(dis);

%add m_target
G = G + C;

%back to range 0-255
rgb = G*255;

%check mean of G
meanRGB = mean(rgb);
stdRGB = std(rgb);
MaxRGB = max(rgb);
MinRGB = min(rgb);

%display part
im3column(inx,:) = uint8(rgb);
dis = reshape(im3column,size(im));
imshow(dis)
