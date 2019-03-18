function image = rgb2orgb(input)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    %reshape the rgb into 2D matrix 3 x N
    rgb2D = double(reshape(input, [], 3)');
    
    %tranform matrix to transform rgb to L,C1,C2
    tran_rgb2lcc = [0.299 0.587 0.114;
                    0.5 0.5 -1.0;
                    0.866 -0.866 0.0];
    %get L,C1,C2
    lcc = tran_rgb2lcc * rgb2D;
    
    %find thetas
    c1 = lcc(2,:);
    c2 = lcc(3,:);
    thetas = atan2(c2, c1);
    
    %find thetaOs
    thetaOs = thetas;
    thetaOs(thetas >= 0 & thetas < pi/3) = (3/2)*thetas(thetas >= 0 & thetas < pi/3);
    thetaOs(thetas >= pi/3 & thetas <= pi) = (pi/2)+(3/4)*(thetas(thetas >= pi/3 & thetas <= pi) - (pi/3));
    thetaOs(thetas > -pi & thetas <= -pi/3) = -pi + (3/4)*(thetas(thetas > -pi & thetas <= -pi/3) + pi);
    thetaOs(thetas > -pi/3 & thetas < 0) = (-pi/2) + (3/2)*(thetas(thetas > -pi/3 & thetas < 0)+(pi/3));
    
    %calculate theta diff
    theta_diff = thetaOs - thetas;
    
    %loop for convert C1, C2 to Cyb, Crg
    Cybrg = zeros(2, size(theta_diff, 2));
    for I = 1:size(theta_diff, 2)
        Cybrg(:, I) = [cos(theta_diff(I)) sin(theta_diff(I)); 
                        -sin(theta_diff(I)) cos(theta_diff(I))] * [c1(I); c2(I)];
    end
    
    lcc(2:3,:) = Cybrg;
    image = lcc;
end

