function histogramRGB(RGB,bins)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    [~,~,B] = size(RGB);
    if (B == 3)
        RGB = reshape(RGB,[],3);
    end
    histogram(RGB(:,1),bins,'FaceColor','r','EdgeColor','none')
    hold on
    histogram(RGB(:,2),bins,'FaceColor','g','EdgeColor','none')
    histogram(RGB(:,3),bins,'FaceColor','b','EdgeColor','none') 
    %histogram(yellow(RGB(:,1),RGB(:,2)),bins,'FaceColor','y','EdgeColor','none')
end

function hist = yellow(r,g)
histR = histogram(r,256);
valR = histR.Values;
histG = histogram(g,256);
valG = histG.Values;
hist = valR;

boolEq = valR == valG;
boolGLessThanR = valG < valR;
hist(~boolEq & boolGLessThanR) = valG(~boolEq & boolGLessThanR);

end


