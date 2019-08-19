function scatter3RGB(RGB)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
r = reshape(RGB(:,:,1),[],1);
g = reshape(RGB(:,:,2),[],1);
b = reshape(RGB(:,:,3),[],1);
scatter3(r,g,b,'.')
end

