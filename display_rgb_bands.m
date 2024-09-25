rgbImage = imread ('Image File_Watertfall.jpg', 'jpg');

Red = rgbImage(:,:,1);
Green = rgbImage(:,:,2);
Blue = rgbImage(:,:,3);
 
zeroMatrix = zeros(480, 640, 'uint8'); 

redImage = cat(3, Red, zeroMatrix, zeroMatrix);
greenImage = cat(3, zeroMatrix, Green, zeroMatrix);
blueImage = cat(3, zeroMatrix, zeroMatrix, Blue);

figure;
imshow(redImage);
 
figure;
imshow(greenImage);

figure;
imshow(blueImage);