function orgb = lcc2orgb(lcc)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

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
        degree = rad2deg(theta_diff(I));
        
        Cybrg(:, I) = [cosd(degree) -sind(degree); 
                        sind(degree) cosd(degree)] * [c1(I); c2(I)];
    end
    
    lcc(2:3,:) = Cybrg;
    orgb = lcc;
end

