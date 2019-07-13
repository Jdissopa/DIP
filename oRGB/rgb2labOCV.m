function [lab] = rgb2labOCV(rgb)
%rgb2labOCV convert image RGB space to lab space
%openCV lab range style

    lab = rgb2lab(double(rgb)./255);
    
    %lab = reshape(lab,[],3);
    
    lab(:,:,1) = lab(:,:,1) * 255 / 100;
    lab(:,:,2:3) = lab(:,:,2:3) + 128;
    
    %lab = reshape(lab,size(rgb));
    
end

