function [orgb] = rotateColor(orgb,deg)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    %extract Cyb, Crg
    Cyb = orgb(:,2);
    Crg = orgb(:,3);
    
    %calculate angle for Cybrg
    %theta = atan2(Crg, Cyb);
    [theta, rho] = cart2pol(Cyb,Crg);
    
    %add offset deg to the theta
    theta = theta + deg2rad(deg);
    
    %wrapToPi the angles
    theta = wrapToPi(theta);
    
    %new Cyb, new Crg
    [nCyb, nCrg] = pol2cart(theta, rho);
    
    orgb(:,2) = nCyb;
    orgb(:,3) = nCrg;

end

