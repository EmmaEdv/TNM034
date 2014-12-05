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

median = medfilt2(blackImg);
%figure
%imshow(median)

se = strel('diamond', 1);
eroded = imerode(median,se);
[y,x] = find(eroded);
%%Figure showing the centerpoints
% figure
% imshow(eroded);

centerPoints = sortrows([x,y],[2,1]);


end

