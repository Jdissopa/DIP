
keys = zeros(size(X,1),1);

for I = 1:size(X,1)
    for J = 1:size(lookup,1)
        if isequal(X(I,:),lookup(J,2:end))
            keys(I) = lookup(J,1);
            break;
        end
    end
end

yfit = trainedModel.predictFcn(T)