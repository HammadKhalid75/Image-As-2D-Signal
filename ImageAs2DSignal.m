%% Corrected MATLAB Code: Compare conv2 and imfilter (Convolution)

close all; clear; clc;

% --- Setup: Load Image and Define Filter ---
I = imread('cameraman.tif'); % Load a standard grayscale image
I = im2double(I);            % Convert to double for floating-point math

% Define a convolution kernel (e.g., a simple 3x3 sharpening filter)
H = [0 -1 0; -1 5 -1; 0 -1 0];

% --- 1. Convolution using conv2 ---
% We use 'same' to ensure the output size is the same as the input image.
Output_conv2 = conv2(I, H, 'same');

% --- 2. Convolution using imfilter ---
% imfilter performs correlation by default, so we must explicitly
% specify 'conv' to perform convolution. We use 'replicate' for boundary
% padding and 'same' for output size.
Output_imfilter = imfilter(I, H, 'replicate', 'same', 'conv');

% --- 3. Calculate Difference ---
% The difference is due to how conv2 handles boundaries (zero-padding)
% versus how imfilter handles boundaries (replicate padding by default).
% To compare, we must use the same image type (double) and boundary
% handling.

% For a more direct comparison, adjust imfilter to use the same zero-padding
% (which is the implicit behavior of conv2's 'same' size output)
Output_imfilter_zero = imfilter(I, H, 0, 'same', 'conv'); 

% Calculate the maximum absolute difference
Max_Diff = max(abs(Output_conv2(:) - Output_imfilter_zero(:)));

% --- 4. Display Results ---
fprintf('Maximum absolute difference (conv2 vs imfilter with zero-padding): %g\n', Max_Diff);

figure;
subplot(1, 3, 1); imshow(I, []); title('Original Image');
subplot(1, 3, 2); imshow(Output_conv2, []); title('Output (conv2)');
subplot(1, 3, 3); imshow(Output_imfilter_zero, []); title('Output (imfilter, ''conv'', 0)');

% Note: Max_Diff will be very close to zero (e.g., 1e-15), demonstrating 
% that the functions are mathematically equivalent when size and padding 
% are controlled.