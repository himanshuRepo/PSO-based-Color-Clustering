%% Color-Based Segmentation Using PSO Clustering
% Edited code. Original Code taken from MATLAB examples.

clear all
clc
close all
%% Step 1: Read Image

he = imread('hestain.png');
figure,
imshow(he), title('H&E image');
text(size(he,2),size(he,1)+15,...
     'Image courtesy of Alan Partin, Johns Hopkins University', ...
     'FontSize',7,'HorizontalAlignment','right');


%% Step 2: Convert Image from RGB Color Space to L*a*b* Color Space

cform = makecform('srgb2lab');
lab_he = applycform(he,cform);

%% Step 3: Classify the Colors in 'a*b*' Space Using K-Means Clustering

ab = double(lab_he(:,:,2:3));
nrows = size(ab,1);
ncols = size(ab,2);
ab = reshape(ab,nrows*ncols,2);

nColors = 3;
[cluster_idx, cluster_center] = pso(ab,nColors);

%% Step 4: Label Every Pixel in the Image Using the Results from KMEANS

pixel_labels = reshape(cluster_idx,nrows,ncols);
figure,
imshow(pixel_labels,[]), title('image labeled by cluster index');

%% Step 5: Create Images that Segment the H&E Image by Color.

segmented_images = cell(1,3);
rgb_label = repmat(pixel_labels,[1 1 3]);

for k = 1:nColors
    color = he;
    color(rgb_label ~= k) = 0;
    segmented_images{k} = color;
end
figure,
imshow(segmented_images{1}), title('objects in cluster 1');

%% 
figure,
imshow(segmented_images{2}), title('objects in cluster 2');

%% 
figure,
imshow(segmented_images{3}), title('objects in cluster 3');


