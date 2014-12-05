close all
clear all

%img1 = imread('D:\Skola\TNM034\Images_Training_1\Bygg_1.png');%
img1 = imread('Images_Training_1/Bygg_1c.png');
%img1 = imread('Images_Training_1/Bygg_1a.png');
%img1 = imread('Images_Training_1/roterad.png');
%img1 = imread('Images_Training_2/Hus_1a.png');
%img1 = imread('Images_Training_5/Husannons_full.png');

%Normalize
img1 = medfilt2(img1,[3 3]);
img1_n = im2bw(img1, graythresh(img1));

figure
imshow(img1_n)

%Find possible fiducial marks (1:1:1:3:1:1:1)
disp('looking for fiducial marks')
[horizontal, vertical, avgBit] = findFiducials(img1_n);
disp('done in function')

%sort horizontal by start Y pos, vertical by start X pos
sortedHorizontal = sortrows(horizontal, [2 1]);
sortedVertical = sortrows(vertical, [1 2]);

%Find the three fiducial marks
disp('check neighbours')
[fiducial] = medianFilter(img1_n, sortedHorizontal, sortedVertical);
disp('done in function')
sortedFiducial = sortrows(fiducial, [1 2]);

%%Figure showing the bw image with FIPs 
% figure
% imshow(img1_n)
% hold on
% plot(sortedFiducial(:,1), sortedFiducial(:,2), 'g*');


sizeF = size(sortedFiducial,1);
% %Drawing lines between the three fiducials to get the angle
% line([sortedFiducial(1,1), sortedFiducial(2,1)], [sortedFiducial(1,2), sortedFiducial(2,2)], 'color', [0.0,0.5,0.0]);
% line([sortedFiducial(1,1), sortedFiducial(3,1)], [sortedFiducial(1,2), sortedFiducial(3,2)], 'color', [0.0,0.5,0.0]);
% line([sortedFiducial(3,1), sortedFiducial(2,1)], [sortedFiducial(3,2), sortedFiducial(2,2)], 'color', [0.0,0.5,0.0]);
% figure
% imshow(img1_n)
%Calculate angle for horizontal line
%counterClock = -1 counter clockwise rotation, = 1 clockwise rot.

disp('rotating')
%Rotate image counter clockwise
if sortedFiducial(1,2) < sortedFiducial(2,2)
    xH = sortedFiducial(3,1)- sortedFiducial(1,1);
    yH = sortedFiducial(1,2)- sortedFiducial(3,2);
    
    counterClock = -1;    
    h = sqrt( xH ^2 + yH^2);
    hAngle = counterClock*radtodeg(acos(xH/h));
%     disp(['i want to go clockwise: ', num2str(hAngle)])
    
%Rotate image clockwise, center point in: [(2,1),(2,2)]
else
    xH = sortedFiducial(3,1)- sortedFiducial(2,1);
    yH = sortedFiducial(2,2)- sortedFiducial(3,2);
    
    counterClock = 1;
    h = sqrt( xH ^2 + yH^2);
    hAngle = counterClock*radtodeg(acos(xH/h));
%     disp(['i want to go counterClockwise: ', hAngle])
end

nyAvgBit = h/32;
%//////////////////VERT
% y = fiducial(3,2)- fiducial(1,2);
% if fiducial(1,1) > fiducial(3,1)
%     x = fiducial(1,1)- fiducial(3,1);
% else
%     x = fiducial(3,1)- fiducial(1,1);
% end
% h = sqrt( x ^2 + y^2);
% vertAngle = radtodeg(acos(y/h));

% avgAngle = (vertAngle + hAngle)/2;  
rotatedImage = imrotate(img1, hAngle, 'bicubic');
disp('done rotating')

disp('find fiducials again')
img2_n = im2bw(rotatedImage, graythresh(rotatedImage));

figure 
imshow(img2_n)
%Hitta fippar igen
[horizontal, vertical, avgBit] = findFiducials(img2_n);
disp('found again')
%sort horizontal by start Y pos, vertical by start X pos
sortedHorizontal = sortrows(horizontal, [2 1]);
sortedVertical = sortrows(vertical, [1 2]);
%1) sortera p? y, begr?nsa, fr?n f?rsta punktens y-v?rde:(sista punktens
%y-v?rde)/2
yMin = sortedVertical(1,1);
yMid = sortedVertical(end,1)/2;

sortedVertical2 = zeros(1,5);
bottomVertical = zeros(1,5);
disp('remove falsies')
%[ sortedVertical ] = removeFalsies( sortedVertical, sortedHorizontal );
disp('done in function')
%sorting the centerpoints for FIPs such that the top 2 ?verst i arrayen och
%nedre sist i arrayen....
disp('sort the sortedVertical correctly')
for i = 1:size(sortedVertical,1)
    if (sortedVertical(i,1) > yMin) && (sortedVertical(i,1) < yMid)
        sortedVertical2 = [sortedVertical2; zeros(1,5)];
        sortedVertical2 = sortedVertical(i,:);
    elseif (sortedVertical(i,1) > yMid )
        bottomVertical = [bottomVertical, zeros(1,5)];
        bottomVertical = sortedVertical(i,:);
    end
end
sortedVertical2 = sortrows(sortedVertical, [5,2]);
bottomVertical = sortrows(sortedVertical, [2,5]);
sortedVertical2 = [sortedVertical2; bottomVertical];

%%Figure showing the rotated image with FIPs
% figure
% imshow(img2_n)
% hold on
% plot(sortedFiducial(:,1), sortedFiducial(:,2), 'g*');

%[centerPoints] = clustering( img2_n, sortedVertical );
disp('median filter the fips')
[ centerPoints ] = medianFilter( img2_n, sortedHorizontal, sortedVertical);
disp('done')
%nyAvgBit = (centerPoints(2,1)-centerPoints(1,1) + centerPoints(3,2)-centerPoints(2,2))/64;
nyAvgBit = (max(centerPoints(:,2))-min(centerPoints(:,2)))/34;
%Read QR-code
disp('read QRcode')
 [text] = readQR2(img2_n, nyAvgBit, centerPoints);
 text
% disp(text);
