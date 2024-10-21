
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

% Extract two blocks from the 6th row
Y_block1 = Y(start_row:start_row+block_size-1, 1:block_size);
Y_block2 = Y(start_row:start_row+block_size-1, block_size+1:2*block_size);

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
num_blocks = 2; % We want only the first two blocks

dctY = zeros(size(Y));
dctCb = zeros(size(Cb));
dctCr = zeros(size(Cr));

for block_num = 0:num_blocks-1
    row_start = (6 - 1) * block_size; % Start at row 5 for block 6
    col_start = block_num * block_size; % Starting column for each block
    
    % DCT for Y
    dctY(row_start + 1:row_start + block_size, col_start + 1:col_start + block_size) = ...
        dct2(Y(row_start + 1:row_start + block_size, col_start + 1:col_start + block_size));
    
    % DCT for Cb
    dctCb(row_start + 1:row_start + block_size, col_start + 1:col_start + block_size) = ...
        dct2(Cb(row_start + 1:row_start + block_size, col_start + 1:col_start + block_size));
    
    % DCT for Cr
    dctCr(row_start + 1:row_start + block_size, col_start + 1:col_start + block_size) = ...
        dct2(Cr(row_start + 1:row_start + block_size, col_start + 1:col_start + block_size));
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

for block_num = 0:num_blocks-1
    row_start = (6 - 1) * block_size; 
    col_start = block_num * block_size; 
    
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
        round(block_Cr ./ QCb); % Use QCb for Cr
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
