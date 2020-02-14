function [X, inx,inxOriSize] = ROI2(f)
    G = f(:,:,1);
    [M,N] = size(G);
    gLT = graythresh(G);
    BW = im2bw(G,gLT*0.25);
    inx = (BW>0.5);
    inxOriSize = reshape(inx,M,N);
    X = f;
end