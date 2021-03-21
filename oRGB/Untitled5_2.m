


im = cdata;

%%
%select only retina
[~,inx] = ROI(im);
roi = im3column(inx,:);

%%
%select only non vain nor macula
meanG = mean(double(roi(:,2)));
stdG = std(double(roi(:,2)));

roi2Inx = find((roi(:,2) >= meanG - stdG & roi(:,2) <= meanG + stdG));

X = roi(roi2Inx,:);

%%
%convert to LAB



