
writtenDir = './retinal_quality/for_slide_diaret_2020_04_16/';
imageFolder = './dataset/diaretdb0_v_1_1/resources/images/diaretdb0_fundus_images/';

fID = fopen('./retinal_quality/for_slide_diaret_2020_04_16/diaret_stats.csv', 'at');

fprintf(fID, strcat('file,',...
                    'mean_r,mean_g,mean_b,min_r,min_g,min_b,max_r,max_g,max_b,std_r,std_g,std_b,',...
                    'mean_r,mean_g,mean_b,min_r,min_g,min_b,max_r,max_g,max_b,std_r,std_g,std_b,',...
                    'mean_l,mean_a,mean_b,min_l,min_a,min_b,max_l,max_a,max_b,std_l,std_a,std_b,',...
                    'mean_l,mean_a,mean_b,min_l,min_a,min_b,max_l,max_a,max_b,std_l,std_a,std_b\n'));

for I = 1:130

    if I < 10
        image = 'image00';
    elseif I < 100
        image = 'image0';
    else
        image = 'image';
    end
    
    filename = strcat(image,string(I));
    filepath = strcat(imageFolder,filename,'.png');

    %read data
    im = imread(filepath);

    %reshape
    im3column = reshape(im,[],3);

    %find ROI
    [~,inx] = ROI(im);
    roi = im3column(inx,:);

    %get the area not include vain and mecula
    meanG = mean(double(roi(:,2)));
    stdG = std(double(roi(:,2)));
    meanSubStd = meanG - stdG;
    meanAddStd = meanG + stdG;

    roi2Inx = find((roi(:,2) >= meanSubStd & roi(:,2) <= meanAddStd));

    X = roi(roi2Inx,:);

    %Normalize X so X in range [0,1]
    Xnew = double(X) / 255;

    %convert Xnew to Lab
    lab = rgb2lab(Xnew);
    maxLab = max(lab);
    minLab = min(lab);
    meanLab = mean(lab);

    %Try to normalize lab
    labNorm = lab/255;
    maxLabNorm = max(labNorm);
    minLabNorm = min(labNorm);

    %calculate variable Q or SIGMA_target
    Q = std(labNorm);
    %Q(2) = Q(1)
    Q = diag(Q);

    %calculate eigenvector and eigenvalue
    covs = cov(labNorm);
    [U,D] = svd(covs);

    %calculate scale to stretch
    E = diag([1 1 0]);
    sc = (D * E).^(-1/2);
    sc(isinf(sc) | isnan(sc)) = 0;

    %calculate T transformation function
    T = U * sc * U' * Q;

    %set m(ean)_target
    C = rgb2lab(double([192 96 32]) / 255)/255;

    %improve quality of input something
    roi = medfilt3(roi,[3,3,3]);

    %Normalize the whole roi area
    B = double(roi)/255;

    %convert roi to lab ad normalize
    B = rgb2lab(B)/255;

    %calculate the roi mean
    meanB = mean(B);

    %resemble all together to get the output
    G = (B - meanB) * T + C;

    %denormalize output
    G = G * 255;

    %covert to rgb
    rgb = lab2rgb(G);

    %denormalize rgb to range 0-255
    rgb = rgb*255;

    %display part
%     im3column(inx,:) = uint8(rgb);
%     dis = reshape(im3column,size(im));
%     imshow(dis)
%     imshow([im dis])
%     imwrite(dis,strcat(writtenDir,filename,'.png'));

    fprintf(fID, strcat('%s,',... %filename
                        '%f,%f,%f,',... %meanRGB of the original image
                        '%f,%f,%f,',... %minRGB of the original image
                        '%f,%f,%f,',... %maxRGB of the original image
                        '%f,%f,%f,',... %stdRGB of the original image 
                        '%f,%f,%f,',... %meanRGB of the adjusted image
                        '%f,%f,%f,',... %minRGB of the adjusted image
                        '%f,%f,%f,',... %maxRGB of the adjusted image
                        '%f,%f,%f,',... %stdRGB of the adjusted image
                        '%f,%f,%f,',... %meanLab of the original image
                        '%f,%f,%f,',... %minLab of the original image
                        '%f,%f,%f,',... %maxLab of the original image
                        '%f,%f,%f,',... %stdLab of the original image
                        '%f,%f,%f,',... %MeanLab of the adjusted image
                        '%f,%f,%f,',...  %minLAB of the adjusted image
                        '%f,%f,%f,',... %maxLAB of the adjusted image
                        '%f,%f,%f',... %stdLab of the adjusted image
                        '\n'), ...
                               filename,...                 %filename
                               mean(roi),...                %meanRGB of the original image
                               min(roi),...                 %minRGB of the original image
                               max(roi),...                 %maxRGB of the original image
                               std(double(roi)),...         %stdRGB of the original image 
                               mean(uint8(rgb)),...         %meanRGB of the adjusted image
                               min(uint8(rgb)),...          %minRGB of the adjusted image
                               max(uint8(rgb)),...          %maxRGB of the adjusted image
                               std(double(uint8(rgb))),...  %stdRGB of the adjusted image
                               mean(B * 255),...            %meanLab of the original image
                               min(B * 255),...             %minLab of the original image
                               max(B * 255),...             %maxLab of the original image
                               std(B * 255),...             %stdLab of the original image
                               mean(G),...                  %meanLab of the adjusted image
                               min(G),...                   %minxLAB of the adjusted image
                               max(G),...                   %maxLAB of the adjusted image
                               std(G)...                    %stdLAB of the adjusted image
                         );
                     
%     fclose(fID);

end
fclose(fID);
disp('end')
