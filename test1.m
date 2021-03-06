close all
clear all
nrOfCols = 41;

%img1 = imread('D:\Skola\TNM034\Images_Training_1\Bygg_1.png');
img1 = imread('Images_Training_1/Bygg_1.png');
%figure
%imshow(img1(:,1))

%Normalize
img1_n = im2bw(img1, graythresh(img1));

%disk element, open close
% se = strel('disk', 5);
% se2 = strel('square', 5);
% img1_o = imopen(img1_n,se);
% img1_c = imclose(img1_o,se);
% 
% img1_o = imopen(img1_n,se2);



imSize = size(img1_n);

%bitW = round(imSize(1)/nrOfCols);
%bitH = round(imSize(2)/nrOfCols);

%figure
imshow(img1_n)

array = zeros(8, 180);
pos = 1;
fmark = 0;
row = 1;
col = 1;



%[Gmag, Gdir] = imgradient(img1_n,'prewitt');

%imshow(Gmag);
%C=corner(Gmag, 'MinimumEigenvalue', 600)

hold on
%plot(C(:,1),C(:,2), 'r*');

%title('Gradient Magnitude, Gmag (left), and Gradient Direction, Gdir (right), using Prewitt method')
%axis off;

%array(n,1) = colors
%array(n,2) = start pos
%array(n,3) = end pos
%array(n,4) = nr in a row
arraySize = imSize(1);
array = zeros(arraySize, 4);
previousColor = -1;
arrayRow = 0;
%Loop through image to enter repetitions of colors...
for j = 1:1:imSize(2)
    for i = 1:1:imSize(1)
        %Same color as previous:
        if(previousColor == img1_n(i,j))
            array(arrayRow, 3) = i;
            array(arrayRow, 4) = array(arrayRow,4)+1;
        %New color:
        else
            arrayRow = arrayRow+1;
            array(arrayRow, 1) = img1_n(i,j);
            array(arrayRow, 2) = i;
            array(arrayRow, 3) = i;
            array(arrayRow, 4) = array(arrayRow,4)+1;
            previousColor = img1_n(i,j);
        end
    end
end

%find the 1:1:3:1:1 relationship
%%Loop through and compare array(n, 4)..
nr = 0;
n = 0;nPrev = 0;
pattern = zeros(5);
compare = [1;1;3;1;1];

pos = 1;
for k = 1:1:arraySize
    temp = array([(0+k):(4+k)],3);
    %C = intersect(temp, compare);
    
end
