

x = double(reshape(RGB,[],3));
mu = mean(x);
V = (x'*x-3*(mu')*mu)/2;

[U,~,D] = pca(x);

D = diag(D);

V2 = U * D * U';

E = eye(3);
E(9) = 0;
DE = D * E;
DE(DE ~= 0) = DE(DE ~= 0).^(-1/2);
T = U * DE * U' * diag([50 50 50]);

C = [192 96 32]/255;

g = x * T + C;