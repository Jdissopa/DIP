datasets = ["STARE" "DiaretDB0"];
images = ["D:\workspace\DIP\oRGB\dataset\stare-photos" "D:\workspace\DIP\oRGB\dataset\diaretdb0_v_1_1\resources\images\diaretdb0_fundus_images"];
wildcard = ["\*.ppm" "\*.png*"];
min_max_size = {[190 398 10],[46 131 5]};
result_files = ["quaternian_score_2021_06_12.csv" "quaternian_score_2021_06_13.csv"];

% datasets = ["DiaretDB0"];
% images = ["D:\workspace\DIP\oRGB\dataset\diaretdb0_v_1_1\resources\images\diaretdb0_fundus_images"];
% wildcard = ["\*.png*"];

% output_des = "D:\workspace\DIP\oRGB\experiment\proposed\exp_2021_05_31\";

result_path = "D:\workspace\DIP\oRGB\experiment\";
% result_file_whole = "quaternian_score_2021_06_13.csv";

% header = ["file_name","tile_L","tile_A","tile_B","clip_L","clip_A","clip_B","q_score_clahe","q_score_whole"];
% 
% wholefile = fullfile(result_path, result_file_whole);
% writematrix(header, wholefile);

scale = 5.5;
% tileL = 18;
% tileA = 15;
% tileB = 3;
tiles = [3,15,18];

% clipLimitL = 0.005;
% clipLimitA = 0.01;
% clipLimitB = 0.001;
clips = [0.001,0.005,0.01];

distribution = 'rayleigh';

for original_index = 1:numel(datasets)
    files=dir(fullfile(images(original_index),wildcard(original_index)));
    n1=numel(files);
    
    wholefile = fullfile(result_path, result_files(original_index));
    
    minn = min_max_size{original_index}(1);
    maxx = min_max_size{original_index}(2);
    numb_files = min_max_size{original_index}(3);
    rand_files = randperm(maxx-minn,numb_files)+minn;
    
    for idx = 1:numel(rand_files)
        im = files(rand_files(idx)).name;
        disp(strcat("working on: ",im))
        inImg = imread(fullfile(images(original_index),im));

        [X, inx] = ROI(inImg);
        
        [R,C,~] = size(inImg);
        inx_bool = zeros(R*C,1);
        inx_bool(inx) = 1;
        
        for I = 1:3
            tileL = [tiles(I) tiles(I)];
            
            for J = 1:3
                tileA = [tiles(J) tiles(J)];
                
                for K = 1:3
                    tileB = [tiles(K) tiles(K)];
                    
                    for L = 1:3
                        clipLimitL = clips(L);
                        
                        for M = 1:3
                            clipLimitA = clips(M);
                            
                            for N = 1:3
                                clipLimitB = clips(N);
                                
                                [Z,~,~, ~, ~,claheImg] = claheLab(X, inx,scale,tileL, tileA, tileB, [clipLimitL clipLimitA clipLimitB],distribution);

                                write_to_scrren_file(im, X, inx_bool, Z, claheImg, tileL, tileA, tileB, clipLimitL,clipLimitA,clipLimitB, wholefile)
                            end
                        end
                    end
                end
            end
        end
    end
end

disp("END!!")

function write_to_scrren_file(im_name, X, inx_bool, image, claheImg, tileL, tileA, tileB, clipLimitL,clipLimitA,clipLimitB, file_path)
    Z = uint8(claheImg*255);
    Z3 = reshape(Z,[],3);
    Z3(~inx_bool,:) = 0;
    rgb = reshape(Z3,size(X));
    q_score_clahe = qssim(X,rgb);

    Z = uint8(image*255);
    Z3 = reshape(Z,[],3);
    Z3(~inx_bool,:) = 0;
    rgb = reshape(Z3,size(X));
    q_score_whole = qssim(X,rgb);

    fprintf('\ttile = [%i %i %i], cliplimit = [%.3f %.3f %.3f], q_score_clahe = %.2f, q_score_whole = %.2f\n', tileL(1), tileA(1), tileB(1),clipLimitL, clipLimitA, clipLimitB, q_score_clahe,q_score_whole)

    to_write = {im_name,tileL(1),tileA(1),tileB(1),clipLimitL,clipLimitA,clipLimitB,q_score_clahe,q_score_whole};

    writecell(to_write, file_path, 'WriteMode', 'append');
end

