function [ centerPoints ] = medianFilter( img, horizontal, vertical)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
imgSize = size(img);
blackImg = zeros(imgSize(1), imgSize(2));

%blackImg(horizontal(:,3),horizontal(:,5)) = 1;
%blackImg(vertical(:,5),vertical(:,4)) = 1;

hsize = size(horizontal);
vsize = size(vertical);

for i = 1:hsize(1)
    blackImg(horizontal(i,3), horizontal(i,5)) = 1;
end
for i = 1:vsize(1)
    blackImg(vertical(i,5), vertical(i,4)) = 1;
end

se = strel('diamond', 1);
blackImg = imclose(blackImg, se);

median = medfilt2(blackImg);
label = bwlabel(median, 8);
img = regionprops(label, 'all');
centroids = cat(1, img.Centroid);
area = cat(1, img.Area)
centerAreas = [centroids, area];
centerAreas = sortrowscenterAreaslabels,-3)

% imshow(median);
% hold on
% plot(centroids(:,1), centroids(:,2), '*r');

centerPoints = sortrows([centerAreas(1:3,1),centerAreas(1:3,2)],[2,1]);


end

