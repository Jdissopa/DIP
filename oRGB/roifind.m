function [ROI,im_vector,inx] = roifind(im,lowerbound,upperbound)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
bw = roicolor(im(:,:,1),lowerbound,upperbound);
inx = reshape(bw,[],1);
im_vector = reshape(im,[],3);
ROI = im_vector(inx,:);
end

