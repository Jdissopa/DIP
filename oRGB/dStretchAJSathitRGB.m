function [output] = dStretchAJSathitRGB(input,C,Q)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    x = double(reshape(input,[],3));
    %mu = mean(x);
    %V = (x'*x-3*(mu')*mu)/2;

    [U,~,D] = pca(x);

    D = diag(D);

    %V2 = U * D * U';

    E = eye(3);
    E(9) = 0;
    DE = D * E;
    DE(DE ~= 0) = DE(DE ~= 0).^(-1/2);
    
    T = U * DE * U' * diag(Q);

    %C = [192 96 32]/255;

    output = x * T + C;
    
    output = reshape(output,size(input));
end

