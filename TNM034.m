function [ strout ] = TNM034( img )
%TNM034 
%   Detailed explanation goes here

%img = imread('Images_Training_1/Bygg_1c.png');
img1 = imread(img);

if (size(img1,3) == 3)
    img1 = rgb2gray(img1);
end
if (size(img1,2) > 1000)
    scaleFactor = 1000/size(img1,2);
    img1 = imresize(img1, scaleFactor, 'bicubic');
end
%imshow(img1)

%Apply median filter to remove noise and normalize
img1 = medfilt2(img1,[3 3]);
img1_n = im2bw(img1, graythresh(img1));

%Find possible fiducial marks (1:1:1:3:1:1:1), both in horizontal and
%vertical direction
disp('looking for fiducial marks')
[sortedHorizontal, sortedVertical] = findFiducials(img1_n);
disp('found fiducial marks')

%Find the three fiducial marks
disp('check neighbours')
[sortedFiducial] = medianFilter(img1_n, sortedHorizontal, sortedVertical);
disp('found neighbours')

%Rotate the image by fiducials positions
disp('rotating')
rotatedImage = rotateImage(sortedFiducial, img1);
disp('done rotating')

%Apply median filter and normalize the rotated image
rotatedImage = medfilt2(rotatedImage,[3 3]);
img2_n = im2bw(rotatedImage, graythresh(rotatedImage));

%Find FIPs in rotated image
disp('find fiducials again')
[sortedHorizontal, sortedVertical] = findFiducials(img2_n);
disp('found fiducial marks in rotated')

%Find centerpoints of fiducials
disp('median filter the fips')
[ centerPoints ] = medianFilter( img2_n, sortedHorizontal, sortedVertical);
disp('done')

avgBitX = (max(centerPoints(:,1))-min(centerPoints(:,1)))/34;
avgBitY = (max(centerPoints(:,2))-min(centerPoints(:,2)))/34;

%Read QR-code
disp('read QRcode')
[text] = readQR2(img2_n, avgBitX, avgBitY, centerPoints);
strout = text;

end