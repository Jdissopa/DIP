datasets = ["STARE" "DiaretDB0"];
images = ["D:\workspace\DIP\oRGB\dataset\stare-photos" "D:\workspace\DIP\oRGB\dataset\diaretdb0_v_1_1\resources\images\diaretdb0_fundus_images"];
wildcard = ["\*.ppm" "\*.png*"];


result_path = "D:\workspace\DIP\oRGB\experiment\adjustpara_pics\trial_01\";

distribution = 'rayleigh';


for original_index = 1:numel(datasets)
    files=dir(fullfile(images(original_index),wildcard(original_index)));
    n1=numel(files);
    
    for idx = 1:n1
        im = files(idx).name;
        
        loc = find(selected_name==im);
        if isempty(loc)
            continue;
        end
        
        disp(strcat("working on: ",im))
        inImg = imread(fullfile(images(original_index),im));

        [X, inx] = ROI(inImg);
        
        [R,C,~] = size(inImg);
        inx_bool = zeros(R*C,1);
        inx_bool(inx) = 1;
        
        p = parameter(loc,:);
        
        Z = claheLab(X, inx,5.5,p(1), p(2), p(3), p(4:6),distribution);
        
        Z = uint8(Z*255);
        Z3 = reshape(Z,[],3);
        Z3(~inx_bool,:) = 0;
        rgb = reshape(Z3,size(X));
        
        split_name = split(im,'.');
        imwrite(rgb, fullfile(result_path,(split_name(1)+".png")))
       
    end
end

disp("END!!")
