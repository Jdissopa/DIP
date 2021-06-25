datasets = ["STARE" "DiaretDB0"];
images = ["D:\workspace\DIP\oRGB\dataset\stare-photos" "D:\workspace\DIP\oRGB\dataset\diaretdb0_v_1_1\resources\images\diaretdb0_fundus_images"];
wildcard = ["\*.ppm" "\*.png*"];
result_files = ["stdSkewKurtos_STARE_2021_06_15.xlsx" "stdSkewKurtos_DiaretDB0_2021_06_15.xlsx"];


result_path = "D:\workspace\DIP\oRGB\experiment\";

header = ["file_name","std_L","std_A","std_B","skew_L","skew_A","skew_B","kurosis_L","kurosis_A","kurosis_B"];


for original_index = 1:numel(datasets)
    files=dir(fullfile(images(original_index),wildcard(original_index)));
    n1=numel(files);
    
    wholefile = fullfile(result_path, result_files(original_index));
    writematrix(header, wholefile);
    
    for idx = 1:n1
        im = files(idx).name;
        disp(strcat("working on: ",im))
        inImg = imread(fullfile(images(original_index),im));

        [X, inx] = ROI(inImg);
        
        A = rgb2lab(X);
        [R, C, nBands] = size(X);
        npixels = R * C;
        mn = min(min(A));
        mx = max(max(A));
        mx = mx(:); mn = mn(:);
        LABp = A;
        LABp(:,:,1) = (A(:,:,1)-mn(1))/(mx(1)-mn(1));
        LABp(:,:,2) = (A(:,:,2)-mn(2))/(mx(2)-mn(2));
        LABp(:,:,3) = (A(:,:,3)-mn(3))/(mx(3)-mn(3));
        A = reshape(LABp,[npixels nBands]);
        B = A(inx,:);
        stdDev = std(B);
        skew = skewness(B);
        kurt = kurtosis(B);
        
        to_write = {im,stdDev,skew,kurt};

        writecell(to_write, wholefile, 'WriteMode', 'append');
    end
end

disp("END!!")

