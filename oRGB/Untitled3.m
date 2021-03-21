
im = cdata;

im3column = reshape(im,[],3);

%find ROI
[~,inx] = ROI(im);
roi = im3column(inx,:);
roiDS = roi;

meanG = mean(double(roi(:,2)));
stdG = std(double(roi(:,2)));

roi2Inx = find((roi(:,2) >= meanG - stdG & roi(:,2) <= meanG + stdG));

X = roi(roi2Inx,:);


%ormalize X so X in range [0,1]
Xnew = double(X) / 255;

mu = mean(Xnew);

k = size(Xnew,1);
V = (Xnew' * Xnew - k * mu' * mu) / (k - 1);

Q = std(Xnew);
Q(2) = Q(1);
Q = diag(Q);

covs = cov(Xnew);
[U,D] = svd(covs);
E = diag([1 1 0]);

sc = (D * E).^(-1/2);
sc(isinf(sc) | isnan(sc)) = 0;

T = U * sc * U' * Q;
C = (double([192 96 32]) / 255);

B = double(roi)/255;
meanB = mean(B);
G = (B - meanB) * T + C;

% Nr = normalize(G,'range');
im3column(inx,:) = uint8(G*255);
dis = reshape(im3column,size(im));
figure, imshow(dis)

