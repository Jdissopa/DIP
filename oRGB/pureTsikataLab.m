function [RGB, LABp] = pureTsikataLab(LABp, inx, scale)
    
    arguments
        LABp (:,:,:) {mustBeNumeric}
        inx (:,1) {mustBeNumeric}
        scale (1,1) double = 6.5
    end
    
    %BrightRange = [68.19, 132.81, 92.37];
    BrightRange = [32.3438, 65.8206, 10.0466];
    Brightness = [51.4732   34.5079   51.0550];
    [R, C, nBands] = size(LABp);
    npixels = R * C;
    A = reshape(LABp,[npixels nBands]);
    B = A(inx,:);
    muVec = mean(B,1);        % Vector of mean in each band
    sdx = std(B,0,1);
    scaleA = BrightRange./(scale*sdx);
    offset = Brightness - scaleA.*muVec;
    B = bsxfun(@plus, B*diag(scaleA), offset);
    A(inx, :) = B;  
    LABp = reshape(A, [R C nBands]);
    
    RGB = lab2rgb(LABp);

end