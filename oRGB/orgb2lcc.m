function lcc = orgb2lcc(orgb)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    %extract Cyb, Crg
    Cyb = orgb(2,:);
    Crg = orgb(3,:);
    
    %calculate angle for Cybrg
    theta = atan2(Crg, Cyb);
    
    %calculate new theta
    thetaO = theta;
    thetaO(theta >= 0 & theta < pi/2) = (2/3)*theta(theta >= 0 & theta < pi/2);
    thetaO(theta >= pi/2 & theta <= pi) = (pi/3) + (4/3)*(theta(theta >= pi/2 & theta <= pi)-(pi/2));
    thetaO(theta > -pi & theta <= -pi/2) = -pi + (4/3)*(theta(theta > -pi & theta <= -pi/2)+pi);
    thetaO(theta > -pi/2 & theta < 0) = (-pi/3) + (2/3)*(theta(theta > -pi/2 & theta < 0)+(pi/2));
    
    %calculate theta_diff
    theta_diff = thetaO - theta;
    
    %loop to convert Cyb, Crg to C1, C2
    C1C2 = zeros(2, size(theta_diff, 2));
    for I = 1:size(theta_diff, 2)
        degree = rad2deg(theta_diff(I));
        
        C1C2(:, I) = [cosd(degree) -sind(degree); 
                        sind(degree) cosd(degree)] * [Cyb(I); Crg(I)];
    end
    
    orgb(2:3,:) = C1C2;
    lcc = orgb;
    
end

