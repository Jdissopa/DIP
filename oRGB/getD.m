function D = getD(eigenvalues)
%scaling matrix (Sc)
eigDataSigma = sqrt(eigenvalues);
D = diag(1.0./eigDataSigma);
%scale = diag(eigenvalues^(-1/2));
end