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
        switch n
            case 1
                %Counting black pixels in a row
            case 2
                %Counting white pixels in a row. If != nr of black pixels
                %go back to case 1 and count new black pixels
                %(egentligen 0.5-1.5 * nr of black pixels)
            case 3
                %Counting black pixels in a row, if != 3*nr of black/white
                %pixels from case 1 & 2, go back to case 1
                %(egentligen 2.5-3.5 * nr of black/white pixels
            case 4
                %Counting white pixels in a row, if != nr of pixels from
                %case 1/2
                %(egentligen 0.5-1.5 * nr of black pixels)
            case 5
                %Counting black pixels in a row, if != nr of pixels from
                %case 1/2/4
                %(egentligen 0.5-1.5 * nr of black pixels)
        end
    end
end