%%% Problem 1
rgbImage = imread ('Waterfall.jpg', 'jpg');

Red = rgbImage(:,:,1);
Green = rgbImage(:,:,2);
Blue = rgbImage(:,:,3);
 
zeroMatrix = zeros(480, 640, 'uint8'); 

figure;
imshow(rgbImage);

%%% Probelem 2
redImage = cat(3, Red, zeroMatrix, zeroMatrix);
greenImage = cat(3, zeroMatrix, Green, zeroMatrix);
blueImage = cat(3, zeroMatrix, zeroMatrix, Blue);

figure;
imshow(redImage);
 
figure;
imshow(greenImage);

figure;
imshow(blueImage);

%%% Problem 3
ycbcr = rgb2ycbcr(rgbImage);

Y = ycbcr(:,:,1);
Cb = ycbcr(:,:,2);
Cr = ycbcr(:,:,3);

%%% Problem 4
figure;
imshow(Y);
 
figure;
imshow(Cb);

figure;
imshow(Cr);

%%% Problem 5
Cb_subsample = zeros(240, 320, 'uint8');  
Cr_subsample = zeros(240, 320, 'uint8');

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

%%% Problem 6
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

%%% Problem 7
ycbcr_new = cat(3, Y, Cb_upsample, Cr_upsample);
rgb_new = ycbcr2rgb(ycbcr_new);

figure;
imshow(rgb_new);

%%% Problem 8
figure;
subplot(1, 2, 1);
imshow(rgbImage);
title('Original Image');

subplot(1, 2, 2);  
imshow(rgb_new);   
title('Reconstructed Image');

%%% Problem 9
%   The two images look identical to the human eye and it is very hard to 
%   spot any differences between the two images
%
%%% Problem 10
original_image = double(rgbImage);
reconstructed_image = double(rgb_new);

[M, N, ~] = size(original_image);

mse_R = 0;
mse_G = 0;
mse_B = 0;

for y = 1:M
    for x = 1:N
        mse_R = mse_R + (original_image(y, x, 1) - reconstructed_image(y, x, 1))^2;
        mse_G = mse_G + (original_image(y, x, 2) - reconstructed_image(y, x, 2))^2;
        mse_B = mse_B + (original_image(y, x, 3) - reconstructed_image(y, x, 3))^2;
    end
end

mse_R = mse_R / (M * N);
mse_G = mse_G / (M * N);
mse_B = mse_B / (M * N);
mse_overall = (mse_R + mse_G + mse_B) / 3;

fprintf('Mean Squared Error (MSE) for Red channel: %.4f\n', mse_R);
fprintf('Mean Squared Error (MSE) for Green channel: %.4f\n', mse_G);
fprintf('Mean Squared Error (MSE) for Blue channel: %.4f\n', mse_B);
fprintf('Overall Mean Squared Error (MSE): %.4f\n\n', mse_overall);


%%% Problem 11
total_pixels = M * N;

Y_samples = total_pixels; 
Cb_samples = (M/2) * (N/2);
Cr_samples = (M/2) * (N/2); 

total_samples_subsampled = Y_samples + Cb_samples + Cr_samples;
original_total_samples = total_pixels * 3;

compression_ratio = original_total_samples / total_samples_subsampled;

fprintf('Original total samples: %d\n', original_total_samples);
fprintf('Total samples after subsampling: %d\n', total_samples_subsampled);
fprintf('Compression Ratio (4:2:0): %.2f:1\n', compression_ratio);


