
BCETed = BCET(pf, 0, 255, 170);

orgb = rgb2orgb(pf);

ICDDSed = ICDDSoRGB(orgb,0.5);

newRGB = orgb2rgb(ICDDSed, size(pf));

newRGB = uint8(rescale(newRGB) * 255);

figure, subplot(1,3,1), imshow(pf)
title('INPUT IMAGE')
subplot(1,3,2), imshow(BCETed)
title('BCETed IMAGE')
subplot(1,3,3), imshow(newRGB)
title('ICDDSed IMAGE')

%plot histogram of the input
figure, subplot(3,1,1),stem([0:255],imhist(pf(:,:,1)),'r');hold on;
stem([0:255],imhist(pf(:,:,2)),'g');hold on;
stem([0:255],imhist(pf(:,:,3)),'b');
title('HISTOGRAM OF THE INPUT IMAGE');
legend RED GREEN BLUE

%plot histogram of the BCETed image
subplot(3,1,2), stem([0:255],imhist(BCETed(:,:,1)),'r');hold on;
stem([0:255],imhist(BCETed(:,:,2)),'g');hold on;
stem([0:255],imhist(BCETed(:,:,3)),'b');
title('HISTOGRAM OF THE BCETed IMAGE');
legend RED GREEN BLUE

%plot histogram of the output
subplot(3,1,3), stem([0:255],imhist(newRGB(:,:,1)),'r');hold on;
stem([0:255],imhist(newRGB(:,:,2)),'g');hold on;
stem([0:255],imhist(newRGB(:,:,3)),'b');
title('HISTOGRAM OF THE OUTPUT IMAGE');
legend RED GREEN BLUE

