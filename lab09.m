%% LAB:09 Finding the edges 
% AIM: Task 1 
% Laplacian operator filter: •Apply Laplacian mask with +4 as center 
% coefficient [[0,-1,0],[-1,4,-1],[0,-1,0]] 
% •Apply Laplacian mask with -4 as center coefficient
% [[0,1,0],[1,-4,1],[0,1,0]]

% •Apply Laplacian mask with -8 as center coefficient 
% [[1,1,1],[1,8,1],[1,1,1]] 
% •Apply Laplacian mask with +8 as center coefficient  
% [[-1,-1,-1],[-1,8,-1],[-1,-1,- 1]]
 
% Task 2 
% Unsharping mask: •Blur original input image using LPF filter having 
% kernel size 3 X 3. •Generate mask image via subtracting it from original
% image •Add them asked image with the original one to get the final output 
% image •Repeat the same for different LPF kernel size and observe the effect 

% Task 3
% Highboost filtering: •Generalization of Unsharp masking operation 
% •Blur original input image using LPF filter having 3x3 kernel size
% •Generate mask image via subtracting it from original image 
 
% •Multiply them ask image with constant integervalue(>1) and then add 
% it with the original one to get the final output image. 


clc;
clear all;
close all;
datetime

% Read the image (grayscale)
image = imread('ckt_board.tif');
if size(image, 3) == 3
    image = rgb2gray(image);  % Convert to grayscale if necessary
end

% Define the Laplacian masks
laplacian1 = [0 -1 0; -1 4 1; 0 -1 0];
laplacian2 = [0 1 0; 1 4 1; 0 1 0];
laplacian3 = [1 1 1; 1 8 1; 1 1 1];
laplacian4 = [-1 -1 -1; -1 8 -1; -1 -1 -1];

% Apply the masks using convolution
result1 = conv2(double(image), laplacian1, 'same');
result2 = conv2(double(image), laplacian2, 'same');
result3 = conv2(double(image), laplacian3, 'same');
result4 = conv2(double(image), laplacian4, 'same');

% Display the results
figure;
subplot(2, 2, 1), imshow(result1, []), title('Laplacian +4');
subplot(2, 2, 2), imshow(result2, []), title('Laplacian -4');
subplot(2, 2, 3), imshow(result3, []), title('Laplacian -8');
subplot(2, 2, 4), imshow(result4, []), title('Laplacian +8');

% Apply Unsharp Masking
kernel_sizes = [3, 5, 7];  % Different LPF kernel sizes
figure;
for i = 1:length(kernel_sizes)
    % Apply Gaussian blur (Low-pass filter)
    blurred_image = imgaussfilt(image, kernel_sizes(i));
    
    % Generate the mask by subtracting the blurred image from the original
    mask = double(image) - double(blurred_image);
    
    % Add the mask back to the original image
    sharpened_image = double(image) + mask;
    
    % Display the result
    subplot(2, 2, i);
    imshow(uint8(sharpened_image)), title(['Kernel size ', num2str(kernel_sizes(i))]);
end

% Highboost Filtering
boost_factors = [1.5, 2, 3];  % Different boost factors
kernel_size = 3;  % Fixed kernel size for LPF

figure;
for i = 1:length(boost_factors)
    % Apply Gaussian blur (Low-pass filter)
    blurred_image = imgaussfilt(image, kernel_size);
    
    % Generate the mask by subtracting the blurred image from the original
    mask = double(image) - double(blurred_image);
    
    % Apply the highboost filter by multiplying the mask with a boost factor
    highboost_image = double(image) + boost_factors(i) * mask;
    
    % Display the result
    subplot(2, 2, i);
    imshow(uint8(highboost_image)), title(['Boost factor ', num2str(boost_factors(i))]);
end
