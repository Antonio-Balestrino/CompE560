rgbImage = imread ('Image File_Watertfall.jpg', 'jpg');

Red = rgbImage(:,:,1);
Green = rgbImage(:,:,2);
Blue = rgbImage(:,:,3);
 
zeroMatrix = zeros(480, 640, 'uint8'); 

redImage = cat(3, Red, zeroMatrix, zeroMatrix);
greenImage = cat(3, zeroMatrix, Green, zeroMatrix);
blueImage = cat(3, zeroMatrix, zeroMatrix, Blue);

figure;
imshow(rgbImage);

figure;
imshow(redImage);
 
figure;
imshow(greenImage);

figure;
imshow(blueImage);

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

Cb_subsample = zeros(480, 640, 'uint8');  
Cr_subsample = zeros(480, 640, 'uint8');

for i = 1:2:480
    for j = 1:2:640
        Cb_subsample(ceil(i/2), ceil(j/2), :) = Cb(i, j, :);
        Cr_subsample(ceil(i/2), ceil(j/2), :) = Cr(i, j, :);
    end
end

figure;
imshow(Cb_subsample);

figure;
imshow(Cr_subsample);

Cb_upsample = zeros(480, 640, 'uint8');
Cr_upsample = zeros(480, 640, 'uint8');

for i = 1:240
    for j = 1:320
        Cb_upsample(2*i-1:2*i, 2*j-1:2*j, :) = Cb_subsample(i, j, :);
        Cr_upsample(2*i-1:2*i, 2*j-1:2*j, :) = Cr_subsample(i, j, :);
    end
end

figure;
imshow(Cb_upsample);

figure;
imshow(Cr_upsample);