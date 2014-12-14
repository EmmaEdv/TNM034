function [ rotatedImage ] = rotateImage( sortedFiducial, img1 )
%rotateImage - rotates the image sent
%   Rotates an image depending on the positions of the fiducial marks
%   Input: matrix containing positions of three fiducials, binary image 
%   Output: rotated image

%Rotate image clockwise, center point in: [(1,1),(1,2)]
if sortedFiducial(1,2) < sortedFiducial(2,2)
    xH = sortedFiducial(3,1)- sortedFiducial(1,1);
    yH = sortedFiducial(1,2)- sortedFiducial(3,2);
    counterClock = -1;    
%Rotate image counter clockwise, center point in: [(2,1),(2,2)]
else
    xH = sortedFiducial(3,1)- sortedFiducial(2,1);
    yH = sortedFiducial(2,2)- sortedFiducial(3,2);
    counterClock = 1;
end
%h = hypotenuse 
h = sqrt( xH ^2 + yH^2);
hAngle = counterClock*radtodeg(acos(xH/h));

rotatedImage = imrotate(img1, hAngle, 'bicubic');

end

