function [ centerPoints ] = medianFilter( img, horizontal, vertical)
%medianFilter: Find centerpoints of found fiducial marks
%   
%Create a black image with the same size as original image.
imgSize = size(img);
blackImg = zeros(imgSize(1), imgSize(2));

hsize = size(horizontal);
vsize = size(vertical);

%Draw all found centerpoints in white on the black image
for i = 1:hsize(1)
    blackImg(horizontal(i,3), horizontal(i,5)) = 1;
end
for i = 1:vsize(1)
    blackImg(vertical(i,5), vertical(i,4)) = 1;
end

%Apply closing on the centerpoints to remove small gaps
se = strel('diamond', 1);
blackImg = imclose(blackImg, se);

%Apply median filtering to get a uniform shape of the centerpoints
median = medfilt2(blackImg);
%Label the points
label = bwlabel(median, 8);
%Apply regionprops to save properties of the regions
img = regionprops(label, 'all');
%Save the area and centerpoints from regions
centroids = cat(1, img.Centroid);
area = cat(1, img.Area);
%The centerpoints are stored in labels, sorted decreasingly by area
labels = [centroids, area];
labels = sortrows(labels,-3);
%The three largest points are assumed to be the centerpoints of the
%fiducial marks
centerPoints = sortrows([labels(1:3,1),labels(1:3,2)],[1,2]);
end

