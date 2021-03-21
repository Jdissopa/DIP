folder = 'D:\workspace\DIP\oRGB\dataset\diaretdb0_v_1_1\resources\images\diaretdb0_fundus_images\';


% Tsikata
TsikatameanRGB = [];
TsikataminRGB = [];
TsikatamaxRGB = [];
TsikatastdRGB = [];

Tsikatam3 = [];
Tsikatamqssim = [];

TsikatameanLAB = [];
TsikataminLAB = [];
TsikatamaxLAB = [];
TsikatastdLAB = [];
% end Tsikata

%CLAHE
% CLAHEmeanRGB = [];
% CLAHEminRGB = [];
% CLAHEmaxRGB = [];
% CLAHEstdRGB = [];
% 
% CLAHEm3 = [];
% CLAHEmqssim = [];
% 
% CLAHEmeanLAB = [];
% CLAHEminLAB = [];
% CLAHEmaxLAB = [];
% CLAHEstdLAB = [];
% % end CLAHE
% 
% % proposed
% ProposedmeanRGB = [];
% ProposedminRGB = [];
% ProposedmaxRGB = [];
% ProposedstdRGB = [];
% 
% Proposedm3 = [];
% Proposedmqssim = [];
% 
% ProposedmeanLAB = [];
% ProposedminLAB = [];
% ProposedmaxLAB = [];
% ProposedstdLAB = [];
%end proposed

for  I = 1:130
    
    if I < 10
        file = strcat('image00',string(I),'.png');
    elseif I < 100
        file = strcat('image0',string(I),'.png');
    else
        file = strcat('image',string(I),'.png');
    end
    
    path = strcat(folder,file);
    
    if ~isfile(path)
        continue;
    end
        
        
    im = imread(path);

    [X,inx] = ROI(im);

    A = rgb2lab(X);
    
    scale = 6.5;
    
    %% Tsikata
    RGB = pureTsikataRGB(X, inx);
    
    RGB = uint8(RGB);
    RGBEx = RGB;
    RGB = reshape(RGB,[],3);
    
    % mean RGB
    TsikatameanRGB = [TsikatameanRGB;mean(RGB(inx,:))];
    % min RGB
    TsikataminRGB = [TsikataminRGB;min(RGB(inx,:))];
    %maxRGB
    TsikatamaxRGB = [TsikatamaxRGB;max(RGB(inx,:))];
    %stdRGB
    TsikatastdRGB = [TsikatastdRGB;std(double(RGB(inx,:)))];
    %M3
    Tsikatam3 = [Tsikatam3;m3colorfulness(RGB(inx,:))];
    %QSSIM
    Tsikatamqssim = [Tsikatamqssim;qssim(im, RGBEx)];
   
    LABp = rgb2lab(RGB);
    %mean LAB
    TsikatameanLAB = [TsikatameanLAB;mean(LABp(inx,:))];
    %min LAB
    TsikataminLAB = [TsikataminLAB;min(LABp(inx,:))];
    %max LAB
    TsikatamaxLAB = [TsikatamaxLAB;max(LABp(inx,:))];
    %std LAB
    TsikatastdLAB = [TsikatastdLAB;std(LABp(inx,:))];
    
    
    %% CLAHE
%     [RGBClahe,LABpClahe] = pureClaheLab(X);
%     
%     RGBClahe = uint8(RGBClahe * 255);
%     RGBClaheEx = RGBClahe;
%     RGBClahe = reshape(RGBClahe,[],3);
%     
%     % mean RGB
%     CLAHEmeanRGB = [CLAHEmeanRGB;mean(RGBClahe(inx,:))];
%     % min RGB
%     CLAHEminRGB = [CLAHEminRGB;min(RGBClahe(inx,:))];
%     %maxRGB
%     CLAHEmaxRGB = [CLAHEmaxRGB;max(RGBClahe(inx,:))];
%     %stdRGB
%     CLAHEstdRGB = [CLAHEstdRGB;std(double(RGBClahe(inx,:)))];
%     %M3
%     CLAHEm3 = [CLAHEm3;m3colorfulness(RGBClahe(inx,:))];
%     %QSSIM
%     CLAHEmqssim = [CLAHEmqssim;qssim(im, RGBClaheEx)];
%    
%     LABpClahe = reshape(LABpClahe,[],3);
%     %mean LAB
%     CLAHEmeanLAB = [CLAHEmeanLAB;mean(LABpClahe(inx,:))];
%     %min LAB
%     CLAHEminLAB = [CLAHEminLAB;min(LABpClahe(inx,:))];
%     %max LAB
%     CLAHEmaxLAB = [CLAHEmaxLAB;max(LABpClahe(inx,:))];
%     %std LAB
%     CLAHEstdLAB = [CLAHEstdLAB;std(LABpClahe(inx,:))];
%     
%     %%
%     
%     %%proposed
%     [RGBpro,LABpro] = claheLab(X, inx, scale);
%     
%     RGBpro = uint8(RGBpro * 255);
%     RGBproEx = RGBpro;
%     RGBpro = reshape(RGBpro,[],3);
%     
%     % mean RGB
%     ProposedmeanRGB = [ProposedmeanRGB;mean(RGBpro(inx,:))];
%     % min RGB
%     ProposedminRGB = [ProposedminRGB;min(RGBpro(inx,:))];
%     %maxRGB
%     ProposedmaxRGB = [ProposedmaxRGB;max(RGBpro(inx,:))];
%     %stdRGB
%     ProposedstdRGB = [ProposedstdRGB;std(double(RGBpro(inx,:)))];
%     %M3
%     Proposedm3 = [Proposedm3;m3colorfulness(RGBpro(inx,:))];
%     %QSSIM
%     Proposedmqssim = [Proposedmqssim;qssim(im, RGBproEx)];
%    
%     LABpro = reshape(LABpro,[],3);
%     %mean LAB
%     ProposedmeanLAB = [ProposedmeanLAB;mean(LABpro(inx,:))];
%     %min LAB
%     ProposedminLAB = [ProposedminLAB;min(LABpro(inx,:))];
%     %max LAB
%     ProposedmaxLAB = [ProposedmaxLAB;max(LABpro(inx,:))];
%     %std LAB
%     ProposedstdLAB = [ProposedstdLAB;std(LABpro(inx,:))];
    %%
    
    if mod(I,10) == 0
        disp(strcat('pass ',string(I)))
    end
    
    %% mean RGB
%     meanRGB = [meanRGB;mean(X(inx,:))];
%     % min RGB
%     minRGB = [minRGB;min(X(inx,:))];
%     %maxRGB
%     maxRGB = [maxRGB;max(X(inx,:))];
%     %stdRGB
%     stdRGB = [stdRGB;std(double(X(inx,:)))];
%     %M3
%     m3 = [m3;m3colorfulness(X(inx,:))];
%     %QSSIM
%     mqssim = [mqssim;qssim(im, Z)];
%    
%     A = reshape(A,[],3);
%     %mean LAB
%     meanLAB = [meanLAB;mean(A(inx,:))];
%     %min LAB
%     minLAB = [minLAB;min(A(inx,:))];
%     %max LAB
%     maxLAB = [maxLAB;max(A(inx,:))];
%     %std LAB
%     stdLAB = [stdLAB;std(A(inx,:))];
    
end


disp('finished')