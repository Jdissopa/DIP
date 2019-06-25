function output = BCET(in,Gmin,Gmax,Gmean)

    A = reshape(in,[],3);

    %Gmin = 0; %MINIMUM VALUE OF THE OUTPUT IMAGE
    %Gmax = 255; %MAXIMUM VALUE OF THE OUTPUT IMAGE
    %Gmean = 170; %MEAN VALUE OF THE OUTPUT IMAGE

    R = A(:,1); %RED CHANNEL
    G = A(:,2); %GREEN CHANNEL
    B = A(:,3); %BLUE CHANNEL

    %PARABOLIC FUNCTION
    R=BCETprocess(Gmin,Gmax,Gmean,R);
    G=BCETprocess(Gmin,Gmax,Gmean,G);
    B=BCETprocess(Gmin,Gmax,Gmean,B);

    output = reshape([R G B], size(in));

    output = uint8(output);

    %figure, imshow(pale_flowers)
    %figure, imshow(output)
end