rgbImage = imread ('Image File_Watertfall.jpg', 'jpg');

ycbcr = rgb2ycbcr(rgbImage);

Y = ycbcr(:,:,1);
Cb = ycbcr(:,:,2);
Cr = ycbcr(:,:,3);

figure;
imshow(Y);
 
figure;
imshow(Cb);

figure;
imshow(Cr);