function [RGB,LABp] = pureClaheLab(X)
    
    arguments
        X (:,:,:) {mustBeNumeric}
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
    
    RGB = lab2rgb(LABp);
    
end