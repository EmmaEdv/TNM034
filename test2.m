close all
clear all

%img1 = imread('D:\Skola\TNM034\Images_Training_1\Bygg_1.png');%
%img1 = imread('Images_Training_1/Bygg_1.png');
%img1 = imread('Images_Training_1/Bygg_1a.png');
img1 = imread('Images_Training_1/roterad.png');
%img1 = imread('Images_Training_2/Hus_1a.png');
%img1 = imread('Images_Training_5/Husannons_full.png');

%Normalize
img1_n = im2bw(img1, graythresh(img1));

%Find possible fiducial marks (1:1:1:3:1:1:1)
[horizontal, vertical, avgBit] = findFiducials(img1_n);

%sort horizontal by start Y pos, vertical by start X pos
sortedHorizontal = sortrows(horizontal, [2 1]);
sortedVertical = sortrows(vertical, [1 2]);

%Find the three fiducial marks
[fiducial] = checkNeighbours2(sortedVertical, sortedHorizontal);
sortedFiducial = sortrows(fiducial, [1 2]);

figure
imshow(img1_n)
 hold on
 plot(sortedFiducial(:,1), sortedFiducial(:,2), 'g*');
sizeF = size(sortedFiducial,1);

% %Drawing lines between the three fiducials to get the angle
% line([sortedFiducial(1,1), sortedFiducial(2,1)], [sortedFiducial(1,2), sortedFiducial(2,2)], 'color', [0.0,0.5,0.0]);
% line([sortedFiducial(1,1), sortedFiducial(3,1)], [sortedFiducial(1,2), sortedFiducial(3,2)], 'color', [0.0,0.5,0.0]);
% line([sortedFiducial(3,1), sortedFiducial(2,1)], [sortedFiducial(3,2), sortedFiducial(2,2)], 'color', [0.0,0.5,0.0]);
% figure
% imshow(img1_n)
%Calculate angle for horizontal line
%counterClock = -1 counter clockwise rotation, = 1 clockwise rot.

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
rotatedImage = imrotate(img1_n, hAngle);
figure
imshow(rotatedImage);

% imgSize = size(img1_n);
% a = [1,0,imgSize(1)/2; 0,1,imgSize(2)/2; 0,0,1];
% b = [radtodeg(cos(hAngle)),radtodeg(-counterClock*sin(hAngle)),0; 
%     radtodeg(counterClock*sin(hAngle)),radtodeg(cos(hAngle)),0; 0,0,1];
% c = [1,0,-imgSize(1)/2; 1,1,-imgSize(2)/2; 0,0,1];
% 
% M = c'*b*a';
% sortedFiducial = M*sortedFiducial;
% 
% 
% rotacioni = [radtodeg(cos(hAngle)) radtodeg(-counterClock*sin(hAngle)); radtodeg(counterClock*sin(hAngle)) radtodeg(cos(hAngle))];
% 
% xx = fiducial(:,1)*rotacioni(1,1) + fiducial(:,2)*rotacioni(1,2);
% yy = fiducial(:,1)*rotacioni(2,1) + fiducial(:,2)*rotacioni(2,2);

%Read QR-code
[text] = readQR(rotatedImage, avgBit, sortedFiducial);
disp(text);
