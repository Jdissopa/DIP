for I = 1:18
    filename = strcat(string(I),suffix);
    filepath = strcat('./retinal_quality/',filename);

    im = imread(filepath);

    %do the ROI process
    [ROI,im_vector,inx] = roifind(im,10,255);

    %convert rgb ROI to lab
    lab = rgb2lab(double(ROI)/255);
    %std of lab
    scale = std(lab);
    disp(scale);
end