function histogramLAB(LAB,bins)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    [~,~,B] = size(LAB);
    if (B == 3)
        LAB = reshape(LAB,[],3);
    end
    histogram(LAB(:,1),bins,'FaceColor','b','EdgeColor','none')
    hold on
    histogram(LAB(:,2),bins,'FaceColor','k','EdgeColor','none')
    histogram(LAB(:,3),bins,'FaceColor',[0.8314 0.6863 0.2157],'EdgeColor','none')  
end


