% compE565 Homework 1 
% Sept. 25, 2024 
% Name: Blake Chanhmisay
% ID: 816106051
% email: bchanhmisay8682@sdsu.edu 
% Name: Antonio Balestrino
% ID: 825053639
% email: abalestrino0991@sdsu.edu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Problem 1: Read and display image
% Implementation 1: Reading and displaying image
% M-file name: read_display_image.m
% Usage: read and display image
% Location of output image: root directory
% Parameters: N/A
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
disp('Running "read_display_image"...'); 
read_display_image;  
disp('Done, "read_display_image" output figure is read_display_image');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Problem 2: Display each rgb band
% Implementation 1: Reading and displaying rgb bands
% M-file name: display_rgb_bands.m
% Usage: Separating rgb bands
% Location of output image: root directory
% Parameters: Red = rgbImage(:,:,1); Green = rgbImage(:,:,2); Blue = rgbImage(:,:,3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
disp('Running "display_rgb_bands"...'); 
display_rgb_bands;  
disp('Done, "display_rgb_bands" output figures is display_rgb_bands.m');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Problem 3: Convert image to YCbCr color space
% Implementation 1: Converting RGB image to YCbCr color space
% M-file name: convert_ycbcr.m
% Usage: Converting RGB image to YCbCr
% Location of output image: root directory
% Parameters: N/A
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
disp('Running "convert_ycbcr"...'); 
convert_ycbcr;  
disp('Done, "convert_ycbcr" output figure is convert_ycbcr.m');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Problem 4: Display each YCbCr separately
% Implementation 1: Separating and displaying each YCbCr band
% M-file name: display_ycbcr_bands.m
% Usage: Separating CbCr bands
% Location of output image: root directory
% Parameters: N/A
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
disp('Running "display_ycbcr_bands"...'); 
display_ycbcr_bands;  
disp('Done, "display_ycbcr_bands" output figures is display_ycbcr_bands.m');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Problem 5: Subsample Cb and Cr bands and display both bands
% Implementation 1: Subsampling both Cb and Cr bands, display both bands
% M-file name: subsample_cbcr.m
% Usage: Subsampling both Cb and Cr bands
% Location of output image: root directory
% Parameters: N/A
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
disp('Running "subsample_cbcr"...'); 
subsample_cbcr;  
disp('Done, "subsample_cbcr" output figures is subsample_cbcr.m');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
% Problem 6: Upsample Cb and Cr bands and display both bands
% Implementation 1: Upsample both Cb and Cr bands, display both bands
% M-file name: upsample_cbcr.m
% Usage: Upsample Cb and Cr bands
% Location of output image: root directory
% Parameters: N/A
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
disp('Running "upsample_cbcr"...'); 
upsample_cbcr;  
disp('Done, "upsample_cbcr" output figures is upsample_cbcr.m');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%