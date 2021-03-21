function [Z,LABp] = claheLab(X, inx, scale)
    
    arguments
        X (:,:,:) {mustBeNumeric}
        inx (:,1) {mustBeNumeric}
        scale (1,1) double = 6.5
    end

    A = rgb2lab(X);
    mn = min(min(A));
    mx = max(max(A));
    mx = mx(:); mn = mn(:);
    LABp = A;
    LABp(:,:,1) = (A(:,:,1)-mn(1))/(mx(1)-mn(1));
    LABp(:,:,2) = (A(:,:,2)-mn(2))/(mx(2)-mn(2));
    LABp(:,:,3) = (A(:,:,3)-mn(3))/(mx(3)-mn(3));
    
    Z = LABp;
    Z(:,:,1) = adapthisteq(LABp(:,:,1),'NumTiles',[8 8],'ClipLimit',0.005);
    Z(:,:,2) = adapthisteq(LABp(:,:,2),'NumTiles',[8 8],'ClipLimit',0.005);
    Z(:,:,3) = adapthisteq(LABp(:,:,3),'NumTiles',[8 8],'ClipLimit',0.005);
    
    LABp(:,:,1) = Z(:,:,1)*(mx(1)-mn(1)) + mn(1);
    LABp(:,:,2) = Z(:,:,2)*(mx(2)-mn(2)) + mn(2);
    LABp(:,:,3) = Z(:,:,3)*(mx(3)-mn(3)) + mn(3);
    
    %BrightRange = [68.19, 132.81, 92.37];
    BrightRange = [32.3438, 65.8206, 10.0466];
    Brightness = [51.4732   34.5079   51.0550];
    [R, C, nBands] = size(X);
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
    
    Z = lab2rgb(LABp);
%     figure, imshowpair(X, Z, 'montage');
%     disp(scale)
end