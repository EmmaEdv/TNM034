function [ strout ] = TNM034( img )
%TNM034 
%   Detailed explanation goes here

%img = imread('Images_Training_1/Bygg_1c.png');
img1 = imread(img);

%Apply median filter to remove noise and normalize
img1 = medfilt2(img1,[3 3]);
img1_n = im2bw(img1, graythresh(img1));

%Find possible fiducial marks (1:1:1:3:1:1:1), both in horizontal and
%vertical direction
disp('looking for fiducial marks')
[sortedHorizontal, sortedVertical] = findFiducials(img1_n);
disp('done in function')

%Find the three fiducial marks
disp('check neighbours')
[sortedFiducial] = medianFilter(img1_n, sortedHorizontal, sortedVertical);
disp('done in function')

%Rotate the image by fiducials positions
disp('rotating')
rotatedImage = rotateImage(sortedFiducial, img1);
disp('done rotating')

disp('find fiducials again')
%Apply median filter and normalize the rotated image
rotatedImage = medfilt2(rotatedImage,[3 3]);
img2_n = im2bw(rotatedImage, graythresh(rotatedImage));

%Find FIPs in rotated image
[sortedHorizontal, sortedVertical] = findFiducials(img2_n);
disp('found again')

%Find centerpoints of fiducials
disp('median filter the fips')
[ centerPoints ] = medianFilter( img2_n, sortedHorizontal, sortedVertical);
disp('done')

nyAvgBit = (max(centerPoints(:,2))-min(centerPoints(:,2)))/34;
%Read QR-code
disp('read QRcode')
[text] = readQR2(img2_n, nyAvgBit, centerPoints);
strout = text;

end

