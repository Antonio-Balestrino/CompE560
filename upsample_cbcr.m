rgbImage = imread ('Image File_Watertfall.jpg', 'jpg');

ycbcr = rgb2ycbcr(rgbImage);

Y = ycbcr(:,:,1);
Cb = ycbcr(:,:,2);
Cr = ycbcr(:,:,3);

Cb_subsample = zeros(240, 320, 'uint8');  
Cr_subsample = zeros(240, 320, 'uint8');

for i = 1:2:480
    for j = 1:2:640
        Cb_subsample(ceil(i/2), ceil(j/2), :) = Cb(i, j, :);
        Cr_subsample(ceil(i/2), ceil(j/2), :) = Cr(i, j, :);
    end
end

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