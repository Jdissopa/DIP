

idealMean = rgb2labOCV([192 96 32]);


im = image001;
%im = RGB2;

[~,inx] = ROI(im);
    
im3column = reshape(im,[],3);
roi = im3column(inx,:);

meanG = mean(double(roi(:,2)));
stdG = std(double(roi(:,2)));

% for I = 1:size(roi,1)
% %         if any(roi(I) >= meanG - stdG & roi(I) <= meanG + stdG, 'All')
%     if ~(roi(I,2) >= meanG - stdG && roi(I,2) <= meanG + stdG)
%         roi(I,:) = 0;
%     end
% end

%lab
lab = rgb2labOCV(roi);

dslab = dstretch(lab,idealMean,lab2rgbOCV([5 10 20]));

rgb = lab2rgbOCV(dslab) * 255;

figure, histogramRGB(rgb,256)

im3column(inx,:) = uint8(rgb);
dis = reshape(im3column,size(im));
figure, imshow(dis)

