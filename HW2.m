
rgbImage = imread ('Waterfall.jpg', 'jpg');


%%%
%%% PROBLEM (A)
%%%

ycbcr = rgb2ycbcr(rgbImage);
Y = ycbcr(:,:,1);
Cb = ycbcr(:,:,2);
Cr = ycbcr(:,:,3);

Cb_subsample = Cb(1:2:end, 1:2:end);
Cr_subsample = Cr(1:2:end, 1:2:end);

block_size = 8;             % 8x8 blocks
block_row = 6;              % We are analyzing the 6th row
start_row = (block_row - 1) * block_size + 1;

% Convert Y to double and apply DC shift
Y_shifted = double(Y) - 128;

% Extract two blocks from the 6th row using shifted Y
Y_block1 = Y_shifted(start_row:start_row+block_size-1, 1:block_size);
Y_block2 = Y_shifted(start_row:start_row+block_size-1, block_size+1:2*block_size);

% Apply 2D DCT to these blocks
DCT_block1 = dct2(Y_block1);
DCT_block2 = dct2(Y_block2);

% Display the DCT coefficients for both blocks
disp('DCT Coefficients for Block 1, Row 6:');
disp(DCT_block1);

disp('DCT Coefficients for Block 2, Row 6:');
disp(DCT_block2);

% Plot DCT-transformed image blocks
figure;
subplot(1, 2, 1);
imshow(log(abs(DCT_block1) + 1), []);  % Enhance visibility using log scale
title('DCT of 1st block, 6th row');

subplot(1, 2, 2);
imshow(log(abs(DCT_block2) + 1), []);  % Enhance visibility using log scale
title('DCT of 2nd block, 6th row');


%%%
%%% PROBLEM (B)
%%%

block_size = 8;

[num_block_rows, num_block_cols] = size(Y);
num_block_rows = num_block_rows / block_size;
num_block_cols = num_block_cols / block_size;

dctY = zeros(size(Y));
dctCb = zeros(size(Cb));
dctCr = zeros(size(Cr));

for block_row = 0:num_block_rows-1
    for block_col = 0:num_block_cols-1
        row_start = block_row * block_size;
        col_start = block_col * block_size;
        
        % DCT for Y_shifted
        dctY(row_start + 1:row_start + block_size, col_start + 1:col_start + block_size) = ...
            dct2(Y_shifted(row_start + 1:row_start + block_size, col_start + 1:col_start + block_size));
        
        % DCT for Cb
        dctCb(row_start + 1:row_start + block_size, col_start + 1:col_start + block_size) = ...
            dct2(Cb(row_start + 1:row_start + block_size, col_start + 1:col_start + block_size));
        
        % DCT for Cr
        dctCr(row_start + 1:row_start + block_size, col_start + 1:col_start + block_size) = ...
            dct2(Cr(row_start + 1:row_start + block_size, col_start + 1:col_start + block_size));
    end
end

%  Quantization matrices
QY = [
    16  11  10  16  24  40  51  61;
    12  12  14  19  26  58  60  55;
    14  13  16  24  40  57  69  56;
    14  17  22  29  51  87  80  62;
    18  22  37  56  68 109 103  77;
    24  35  55  64  81 104 113  92;
    49  64  78  87 103 121 120 101;
    72  92  95  98 112 100 103  99
];

QCb = [
    17  18  24  47  99  99  99  99;
    18  21  26  66  99  99  99  99;
    24  26  56  99  99  99  99  99;
    47  66  99  99  99  99  99  99;
    99  99  99  99  99  99  99  99;
    99  99  99  99  99  99  99  99;
    99  99  99  99  99  99  99  99;
    99  99  99  99  99  99  99  99
];

% Quantize the DCT coefficients
Quantized_Y = zeros(size(Y));
Quantized_Cb = zeros(size(Cb));
Quantized_Cr = zeros(size(Cr));

for block_row = 0:num_block_rows-1
    for block_col = 0:num_block_cols-1
        row_start = block_row * block_size;
        col_start = block_col * block_size;
        
        % Quantize Y
        block_Y = dctY(row_start + 1:row_start + block_size, col_start + 1:col_start + block_size);
        Quantized_Y(row_start + 1:row_start + block_size, col_start + 1:col_start + block_size) = ...
            round(block_Y ./ QY);
        
        % Quantize Cb
        block_Cb = dctCb(row_start + 1:row_start + block_size, col_start + 1:col_start + block_size);
        Quantized_Cb(row_start + 1:row_start + block_size, col_start + 1:col_start + block_size) = ...
            round(block_Cb ./ QCb);
        
        % Quantize Cr
        block_Cr = dctCr(row_start + 1:row_start + block_size, col_start + 1:col_start + block_size);
        Quantized_Cr(row_start + 1:row_start + block_size, col_start + 1:col_start + block_size) = ...
            round(block_Cr ./ QCb); % Using QCb for Cr as in original code
    end
end


%  Get DC coefficients for both blocks in row 6
DC_Y_1 = Quantized_Y((6 - 1) * block_size + 1, 1); % DC for Block 1
DC_Y_2 = Quantized_Y((6 - 1) * block_size + 1, block_size + 1); % DC for Block 2

fprintf('DC DCT coefficient for Y Block 1 (6th row): %d\n', DC_Y_1);
fprintf('DC DCT coefficient for Y Block 2 (6th row): %d\n\n', DC_Y_2);

%  Zigzag scan for AC coefficients for both blocks
zigzag_order = [
    1,  2,  6,  7, 15, 16, 28, 29;
    3,  5,  8, 14, 17, 27, 30, 43;
    4,  9, 13, 18, 26, 31, 42, 44;
    10, 12, 19, 25, 32, 41, 45, 54;
    11, 20, 24, 33, 40, 46, 53, 55;
    21, 23, 34, 39, 47, 52, 56, 61;
    22, 35, 38, 48, 51, 57, 60, 62;
    36, 37, 49, 50, 58, 59, 63, 64
];

AC_Y_1 = zeros(1, 63);  % AC coefficients for Block 1
AC_Y_2 = zeros(1, 63);  % AC coefficients for Block 2

% Zigzag scan for Block 1
block_Y_1 = Quantized_Y((6 - 1) * block_size + 1:6 * block_size, 1:8);
for i = 1:8
    for j = 1:8
        idx = zigzag_order(i, j);
        if idx == 1
            continue; % Skip the DC coefficient
        end
        AC_Y_1(idx - 1) = block_Y_1(i, j); % Store AC coefficients
    end
end

% Zigzag scan for Block 2
block_Y_2 = Quantized_Y((6 - 1) * block_size + 1:6 * block_size, block_size + 1:2 * block_size);
for i = 1:8
    for j = 1:8
        idx = zigzag_order(i, j);
        if idx == 1
            continue; % Skip the DC coefficient
        end
        AC_Y_2(idx - 1) = block_Y_2(i, j); % Store AC coefficients
    end
end

% Display the AC coefficients
disp('AC DCT coefficients for Y Block 1 (6th row):');
disp(AC_Y_1);

disp('AC DCT coefficients for Y Block 2 (6th row):');
disp(AC_Y_2);


%%%
%%% PROBLEM (C)
%%%

InvQuantized_Y = zeros(size(Y));
InvQuantized_Cb = zeros(size(Cb));
InvQuantized_Cr = zeros(size(Cr));

for block_row = 0:num_block_rows-1
    for block_col = 0:num_block_cols-1
        row_start = block_row * block_size;
        col_start = block_col * block_size;
        
        % Inverse Quantize Y
        InvQuantized_Y(row_start + 1:row_start + block_size, col_start + 1:col_start + block_size) = ...
            Quantized_Y(row_start + 1:row_start + block_size, col_start + 1:col_start + block_size) .* QY;
        
        % Inverse Quantize Cb
        InvQuantized_Cb(row_start + 1:row_start + block_size, col_start + 1:col_start + block_size) = ...
            Quantized_Cb(row_start + 1:row_start + block_size, col_start + 1:col_start + block_size) .* QCb;
        
        % Inverse Quantize Cr
        InvQuantized_Cr(row_start + 1:row_start + block_size, col_start + 1:col_start + block_size) = ...
            Quantized_Cr(row_start + 1:row_start + block_size, col_start + 1:col_start + block_size) .* QCb; % Using QCb for Cr as in original code
    end
end


%%%
%%% PROBLEM (D)
%%%

Reconstructed_Y = zeros(size(Y));
Reconstructed_Cb = zeros(size(Cb));
Reconstructed_Cr = zeros(size(Cr));

for block_row = 0:num_block_rows-1
    for block_col = 0:num_block_cols-1
        row_start = block_row * block_size;
        col_start = block_col * block_size;
        
        % Inverse DCT for Y and apply DC shift back
        Reconstructed_Y_block = idct2(InvQuantized_Y(row_start + 1:row_start + block_size, col_start + 1:col_start + block_size)) + 128;
        Reconstructed_Y(row_start + 1:row_start + block_size, col_start + 1:col_start + block_size) = Reconstructed_Y_block;
        
        % Inverse DCT for Cb
        Reconstructed_Cb_block = idct2(InvQuantized_Cb(row_start + 1:row_start + block_size, col_start + 1:col_start + block_size));
        Reconstructed_Cb(row_start + 1:row_start + block_size, col_start + 1:col_start + block_size) = Reconstructed_Cb_block;
        
        % Inverse DCT for Cr
        Reconstructed_Cr_block = idct2(InvQuantized_Cr(row_start + 1:row_start + block_size, col_start + 1:col_start + block_size));
        Reconstructed_Cr(row_start + 1:row_start + block_size, col_start + 1:col_start + block_size) = Reconstructed_Cr_block;
    end
end

Reconstructed_Y = max(min(Reconstructed_Y, 235), 16);
Reconstructed_Cb = max(min(Reconstructed_Cb, 240), 16);
Reconstructed_Cr = max(min(Reconstructed_Cr, 240), 16);

% Convert to uint8 for proper image representation
YCbCr_Reconstructed = cat(3, Reconstructed_Y, Reconstructed_Cb, Reconstructed_Cr);
YCbCr_Reconstructed_uint8 = uint8(YCbCr_Reconstructed);

RGB_Reconstructed = ycbcr2rgb(YCbCr_Reconstructed_uint8);

subplot(1, 2, 1); 
imshow(rgbImage);
title('Original RGB Image');

subplot(1, 2, 2);
imshow(RGB_Reconstructed);
title('Reconstructed RGB Image');

Y_original = double(Y); 

% Compute the Error Image
Error_Image_Y = Y_original - Reconstructed_Y;

figure;
abs_Error_Image_Y = abs(Error_Image_Y);
imshow(abs_Error_Image_Y, []);
title('Error Image for Luminance Component');

% Calculate PSNR for Luminance
MAX_I = 255;
MSE_Y = mean((double(Y_original(:)) - double(Reconstructed_Y(:))).^2);
PSNR_Y = 10 * log10((MAX_I^2) / MSE_Y);
fprintf('PSNR for Luminance (Y) Component: %.2f dB\n', PSNR_Y);