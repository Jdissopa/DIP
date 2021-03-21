function [X, inx] = notROI(f)
    G = f(:,:,1);
    [M,N] = size(G);
    gLT = graythresh(G);
    BW = im2bw(G,gLT*0.25);
    inx = find(BW<=0.5);
    res = reshape(f,[],3);
    X = f;
end