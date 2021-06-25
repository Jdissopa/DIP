datasets = ["STARE" "DiaretDB0"];
images = ["D:\workspace\DIP\oRGB\dataset\stare-photos" "D:\workspace\DIP\oRGB\dataset\diaretdb0_v_1_1\resources\images\diaretdb0_fundus_images"];
wildcard = ["\*.ppm" "\*.png*"];
min_max_size = {[1 398 53],[1 131 17]};
resize_size = [0.05 0.025];
result_files = ["07_quaternian_score_STARE_2021_06_20.xlsx" "07_quaternian_score_DiaretDB0_2021_06_20.xlsx"];

% datasets = ["DiaretDB0"];
% images = ["D:\workspace\DIP\oRGB\dataset\diaretdb0_v_1_1\resources\images\diaretdb0_fundus_images"];
% wildcard = ["\*.png*"];

% output_des = "D:\workspace\DIP\oRGB\experiment\proposed\exp_2021_05_31\";

result_path = "D:\workspace\DIP\oRGB\experiment\adjustpara";
% result_file_whole = "quaternian_score_2021_06_13.csv";

header = ["file_name","tile_L","tile_A","tile_B","clip_L","clip_A","clip_B","q_score_clahe"];
% 
% wholefile = fullfile(result_path, result_file_whole);
% writematrix(header, wholefile);

scale = 5.5;
% tileL = 18;
% tileA = 15;
% tileB = 3;
tiles = [3,6,9,12,15,18];
tile_len = size(tiles,2);

% clipLimitL = 0.005;
% clipLimitA = 0.01;
% clipLimitB = 0.001;
clips = [0.001,0.003,0.005,0.01];
clip_len = size(clips, 2);

distribution = 'rayleigh';

% to_write = cell(70,8);

for original_index = 1:numel(datasets)
    files=dir(fullfile(images(original_index),wildcard(original_index)));
    n1=numel(files);
    
    wholefile = fullfile(result_path, result_files(original_index));
    writematrix(header, wholefile);
    
    minn = min_max_size{original_index}(1);
    maxx = min_max_size{original_index}(2);
    numb_files = min_max_size{original_index}(3);
    rand_files = randperm(maxx-minn,numb_files)+minn;
    
    rand_files = sort(rand_files);
    
    for idx = 1:numel(rand_files)
        im = files(rand_files(idx)).name;
        disp(strcat("working on: ",im))
        inImg = imread(fullfile(images(original_index),im));
        
%         resize image
        inImg = imresize(inImg,resize_size(original_index));

        [X, inx] = ROI(inImg);
        
        [R,C,~] = size(inImg);
        inx_bool = zeros(R*C,1);
        inx_bool(inx) = 1;
        
        to_write_row = 1;
        
        previou_distance = Inf;
        
        for I = 1:tile_len
            tileL = [tiles(I) tiles(I)];
            
            for J = 1:tile_len
                tileA = [tiles(J) tiles(J)];
                
                for K = 1:tile_len
                    tileB = [tiles(K) tiles(K)];
                    
                    for L = 1:3
                        clipLimitL = clips(L);
                        
                        for M = 3:clip_len
                            clipLimitA = clips(M);
                            
                            for N = 1:3
                                clipLimitB = clips(N);
                                
                                Z = claheLab2(X, inx,scale,tileL, tileA, tileB, [clipLimitL clipLimitA clipLimitB],distribution);
                                
                                Z = uint8(Z*255);
                                Z3 = reshape(Z,[],3);
                                Z3(~inx_bool,:) = 0;
                                rgb = reshape(Z3,size(X));
                                q_score_clahe = qssim(X,rgb);
                                
                                distance = abs(0.45 - q_score_clahe);
                                if distance <= previou_distance && q_score_clahe >= 0.4
%                                     to_write{I,1} = im;
%                                     to_write{I,2} = tileL(1);
%                                     to_write{I,3} = tileA(1);
%                                     to_write{I,4} = tileB(1);
%                                     to_write{I,5} = clipLimitL;
%                                     to_write{I,6} = clipLimitA;
%                                     to_write{I,7} = clipLimitB;
%                                     to_write{I,8} = q_score_clahe;
                                    to_write = {im,tileL(1),tileA(1),tileB(1),clipLimitL,clipLimitA,clipLimitB,q_score_clahe};
                                    previou_distance = distance;
                                end
                                
%                                 to_write = {im_name,tileL(1),tileA(1),tileB(1),clipLimitL,clipLimitA,clipLimitB,q_score_clahe,q_score_whole};
%                                 write_to_scrren_file(im, X, inx_bool, Z, claheImg, tileL, tileA, tileB, clipLimitL,clipLimitA,clipLimitB, wholefile)
                            end
                        end
                    end
                end
            end
        end
        
        writecell(to_write, wholefile, 'WriteMode', 'append');
    end
end

disp("END!!")
