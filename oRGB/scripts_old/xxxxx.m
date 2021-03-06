

for I = 1:39
    fpath = strcat('./paleimages/pale',string(I),'.jpg');
    im = imread(fpath);
    %orgb = rgb2orgb(im);
    
    m3s = zeros(1,2);
    
    for k = 0.3:0.2:0.5
        %ICDDSed = ICDDSoRGB(orgb,k);
        ICDDSed = ICDDS(im,k);
        %newRGB = orgb2rgb(ICDDSed, size(im));   
        newRGB = uint8(rescale(ICDDSed) * 255);
        m3 = m3colorfulness(newRGB);
        m3s(uint8(ceil(3*k))) = m3;
    end
    
    [g,idx] = max(m3s);
    if idx == 1
        idx = 0.3;
    elseif idx == 2
        idx = 0.5;
    else
        idx = 0.7;
    end
    originalM3 = m3colorfulness(im);
    fprintf('pale%d.jpg, original M3 = %.2f, new M3 = %.2f, k = %.2f\n', I, originalM3, g, idx);
    %fprintf('pjik.jpg, original M3 = %.2f, new M3 = %.2f, k = %.2f\n', originalM3, g, idx);
    
    ICDDSed = ICDDS(im,idx);
    %newRGB = orgb2rgb(ICDDSed, size(im));   
    newRGB = uint8(rescale(ICDDSed) * 255);
    outFPath = strcat('./nopaleimages/RGB/nopale',string(I),'.jpg');
    imwrite(newRGB, outFPath);
end