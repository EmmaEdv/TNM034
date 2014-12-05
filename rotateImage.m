function [ rotatedImage ] = rotateImage( sortedFiducial, img1 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

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


end

