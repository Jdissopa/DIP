function [X, inx] = ROI(f)
    G = f(:,:,1);
    [M,N] = size(G);
    gLT = graythresh(G);
    BW = im2bw(G,gLT*0.25);
    inx = find(BW>0.5);
    X = f;
end