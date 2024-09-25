rgbImage = imread ('Image File_Watertfall.jpg', 'jpg');

ycbcr = rgb2ycbcr(rgbImage);

imshow(ycbcr);