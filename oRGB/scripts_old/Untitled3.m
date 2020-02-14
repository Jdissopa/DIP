rgb = zeros(256^3,3);
I = 1.0;
for R = 0:255
    for G = 0:255
        for B = 0:255
            rgb(I,:) = [R G B];
            I = I + 1.0;
        end
    end
end