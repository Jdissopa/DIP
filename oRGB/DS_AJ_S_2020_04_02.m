% imageFolder = './dataset/diaretdb0_v_1_1/resources/images/diaretdb0_fundus_images/';

% maskFolder = './dataset/diaretdb0_v_1_1/resources/images/diaretdb0_binary_masks/';
imageFolder = './DS_AJ_S/';

write = 0;

for I = 1:1

    if I < 10
        image = 'image00';
    elseif I < 100
        image = 'image0';
    else
        image = 'image';
    end
    
    filename = strcat(image,string(I));
    filepath = strcat(imageFolder,filename,'.png');

    im = imread(filepath);

    [~,inx] = ROI(im);
    
    im3column = reshape(im,[],3);
    roi = im3column(inx,:);
    
    meanG = mean(double(roi(:,2)));
    stdG = std(double(roi(:,2)));
    
    for I = 1:size(roi,1)
%         if any(roi(I) >= meanG - stdG & roi(I) <= meanG + stdG, 'All')
        if ~(roi(I,2) >= meanG - stdG && roi(I,2) <= meanG + stdG)
            roi(I,:) = 0;
        end
    end
    
    
    
    im3column(inx,:) = roi;
    dis = reshape(im3column,size(im));
    
    figure, imshow(dis)
    
end