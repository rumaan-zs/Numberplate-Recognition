% Load the image
image = imread('Number Plate Images/image4.jpg');

% Convert the image to grayscale
grayImage = rgb2gray(image);

% Enhance the image contrast
enhancedImage = imadjust(grayImage);

% Perform edge detection
edgeImage = edge(enhancedImage, 'Canny');

% Perform morphological operations to close gaps and fill holes
se = strel('rectangle', [5, 5]);
closedImage = imclose(edgeImage, se);

% Find connected regions in the image
regions = regionprops(closedImage, 'BoundingBox');

% Filter the regions based on their aspect ratio
aspectRatioThreshold = 3;
filteredRegions = [];
for i = 1:length(regions)
    box = regions(i).BoundingBox;
    aspectRatio = box(3) / box(4);
    if aspectRatio < aspectRatioThreshold
        filteredRegions = [filteredRegions, regions(i)];
    end
end

% Display the original image with bounding boxes
imshow(image);
hold on;
for i = 1:length(filteredRegions)
    box = filteredRegions(i).BoundingBox;
    rectangle('Position', box, 'EdgeColor', 'r', 'LineWidth', 2);
end
hold off;
