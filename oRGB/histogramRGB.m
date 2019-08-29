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
end

function red = only_red(RGB)
red = RGB(RGB(:,2) == 0 & RGB(:,3) == 0,1);
end
function green = only_green(RGB)
green = RGB(RGB(:,1) == 0 & RGB(:,3) == 0,2);
end
function blue = only_blue(RGB)
blue = RGB(RGB(:,1) == 0 & RGB(:,2) == 0,3);
end



