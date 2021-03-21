function [lab] = rgb2labOCV(rgb)
%rgb2labOCV convert image RGB space to lab space
%openCV lab range style

    [~,~,O] = size(rgb);
    
    lab = rgb2lab(double(rgb)./255);

    if O == 3
        lab(:,:,1) = lab(:,:,1) * 255 / 100;
        lab(:,:,2:3) = lab(:,:,2:3) + 128;
    else
        lab(:,1) = lab(:,1) * 255 / 100;
        lab(:,2:3) = lab(:,2:3) + 128;
    end
    
end

