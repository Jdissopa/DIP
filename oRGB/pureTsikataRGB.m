function RGB = pureTsikataRGB(im, inx)
    
    arguments
        im (:,:,:) {mustBeNumeric}
        inx (:,1) {mustBeNumeric}
    end
    
    im = double(im);
    BrightRange = [128 128 32];
    Brightness = [192 96 32];
    [R, C, nBands] = size(im);
    npixels = R * C;
    A = reshape(im,[npixels nBands]);
    B = A(inx,:);
    muVec = mean(B,1);        % Vector of mean in each band
    sdx = std(B,0,1);
    
    scaleA = BrightRange./(4*sdx);
    offset = Brightness - scaleA.*muVec;
    B = bsxfun(@plus, B*diag(scaleA), offset);
    A(inx, :) = B;  
    RGB = reshape(A, R, C, nBands);
    
%     scaleA = BrightRange./(scale*sdx);
%     offset = Brightness - scaleA.*muVec;
%     B = bsxfun(@plus, B*diag(scaleA), offset);
%     A(inx, :) = B;  
%     LABp = reshape(A, [R C nBands]);
%     
%     RGB = lab2rgb(LABp);

end