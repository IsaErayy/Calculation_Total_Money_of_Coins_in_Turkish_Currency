img = imread('img5_coin.jpeg');
gray_img = im2double(rgb2gray(img));
figure;
subplot(3,3,1), imshow(img), title("Original Image");
subplot(3,3,2);imshow(gray_img);
title("The grayscale image of the given image");

F2=[-1 -2 -1; 0 0 0; 1 2 1];%X gradient mask for sobel operator
F1=[-1 0 1; -2 0 2; -1 0 1];%Y gradient mask for sobel operator
%Adjusting the gradient magnitude

%We applied the “Sobel operator” with X and Y  gradient masks to accentuate coin edges in images. The operator is adept at highlighting intensity changes, aiding in effective edge detection. 
%The resulting gradient magnitude map, obtained by combining X and Y gradients, served as a representation of edge strength.
Gx=conv2(gray_img,F1,'same');
Gy=conv2(gray_img,F2,'same');
grad_magnitude=sqrt(Gx.^2+Gy.^2);

%Adjusting threshold value
threshold_value = 0.2;
binary_edges = grad_magnitude>threshold_value;

subplot(3, 3, 3), imshow(grad_magnitude, []), title('Gradient Magnitude with Sobel Operator');
subplot(3, 3, 4), imshow(binary_edges), title('Binary Edges of the Image');

img_Bw=imbinarize(double(binary_edges),graythresh(double(binary_edges)));
subplot(3,3,5), imshow(img_Bw), title("Binarized Image");

se3=strel('disk',12);
img_filled=imfill(img_Bw,'holes');
img_erode=imerode(img_filled,se3);
subplot(3,3,6), imshow(img_filled), title("Binarized Image with filled");
subplot(3,3,[7 8 9])

imshow(img_erode);title("Final result of morphological operations");
[centers, radii]=imfindcircles(img_erode, [10, 150]);

%Taking the coins with circles
figure;
imshow(img_erode);
title("Taking coins with circle");
hold on 
viscircles(centers,radii,'EdgeColor','g');
hold off;

% Calculating and displaying the area of each circle
circle_areas = pi * radii.^2;
fprintf('Radius of detected circles (in square pixels):\n');
disp(sort(radii,'descend'));
radii_sorted = sort(radii,'descend');

% Sorting circles by area in descending order
[sorted_areas, sorted_indices] = sort(circle_areas, 'descend');
sorted_centers = centers(sorted_indices, :);
sorted_radii = radii(sorted_indices);

% Displaying sorted areas
fprintf('Sorted areas of circles (in square pixels):\n');
disp(sorted_areas);

% Converting areas to square meters (1 pixel is assumed to be 1 square meter)
areas_square_meters = sorted_areas;
fprintf('Sorted areas of circles (in square meters):\n');
disp(areas_square_meters);
total_money=0;

% Finding the largest circle (reference circle)
% I take a reference coin which is '1TL'. We selected 1TL as reference because it has the largest area compared to other coins.
% After that, we take scaled value by taking the ratio of sorted areas/largest area(reference coin area) with sqrt.
largest_radius = sorted_radii(1);
largest_area = sorted_areas(1);

% Dividing areas by the area of the reference circle
scaled_factors = sqrt(sorted_areas / largest_area);

% Creating ranges based on the scaled values
for i=1:length(scaled_factors)
    if ( scaled_factors(i) == 1) || (scaled_factors(i) > 0.91)
        total_money=total_money + 1;
    elseif (( 0.77 <scaled_factors(i)) && (scaled_factors(i) <= 0.91))
        total_money= total_money + 0.5;
    elseif ((0.67 < scaled_factors(i)) && (scaled_factors(i) <= 0.77))
        total_money= total_money + 0.25;
    elseif ((0.5951 < scaled_factors(i)) && (scaled_factors(i) <= 0.67))
        total_money= total_money + 0.10;
    elseif ((0 < scaled_factors(i)) && (scaled_factors(i) <= 0.5951))
        total_money= total_money + 0.05;
    end
end
fprintf('Scaled factors:\n');
disp(scaled_factors);
fprintf('Total value: %.2f TL\n', total_money);%Calculating total money

% Creating a figure for the annotated image
figure;
imshow(img_erode);
title(sprintf('Coin Detection - Total Value: %.2f TL', total_money));
hold on;

% Iterating over each circle and annotate with its value
for i = 1:length(sorted_areas)
    centerX = sorted_centers(i, 1);
    centerY = sorted_centers(i, 2);
    radius = sorted_radii(i);
    coin_value = 0;
    if (scaled_factors(i) == 1)||(scaled_factors(i) > 0.91)
        coin_value = 1;
    elseif ((0.77 < scaled_factors(i)) && (scaled_factors(i) <= 0.91))
        coin_value = 0.5;
    elseif ((0.67 < scaled_factors(i)) && (scaled_factors(i) <= 0.77))
        coin_value = 0.25;
    elseif ((0.5951 < scaled_factors(i)) && (scaled_factors(i) <= 0.67))
        coin_value = 0.10;
    elseif ((0<scaled_factors(i)) && (scaled_factors(i) <= 0.5951))
        coin_value = 0.05;
    end
    % Annotate the value on the image
    text(centerX, centerY, sprintf('%.2f TL', coin_value), ...
        'Color', 'r', 'FontSize', 5, 'HorizontalAlignment', 'center');
        
    % Draw the circle for visualization
    theta = linspace(0, 2*pi, 100);
    x = centerX + radius * cos(theta);
    y = centerY + radius * sin(theta);
    plot(x, y, 'g', 'LineWidth', 1); 
end
hold off;
