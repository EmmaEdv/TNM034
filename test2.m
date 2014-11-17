close all
clear all
nrOfCols = 41;

%img1 = imread('D:\Skola\TNM034\Images_Training_1\Bygg_1.png');
img1 = imread('Images_Training_1/Bygg_1.png');
%img1 = imread('Images_Training_5/Husannons_full.png');

%Normalize
img1_n = im2bw(img1, graythresh(img1));

imSize = size(img1_n);

imshow(img1_n)

% status
% 0: White border around QR-code
% 1: Outer black border of fiducial mark
% 2: Outer white border of fiducial mark
% 3: Black square of fiducial mark
% 4: Same as 2
% 5: Same as 1
% 6: extra case.. 
vertical = zeros(1000, 4);
n = 1;
status = 0;
blackCounter = 0;
whiteCounter = 0;
centerCounter = 0;
startX = 0;
startY = 0;
%svart = 0
%vit = 1
%Vertical scanning
%Loop through image to enter repetitions of colors...
for j = 1:1:imSize(2)
    for i = 1:1:imSize(1)
        switch status
            case 0
                if(img1_n(i,j) == 1)
                    whiteCounter = whiteCounter + 1;
                else
                    blackCounter = 1;
                    status = 1;
                    startX = i;
                    startY = j;
                end
            case 1 
                if(img1_n(i,j) == 0)
                    blackCounter = blackCounter + 1;
                else
                    whiteCounter = 1;
                    status = 2;
                end
            case 2
                if(img1_n(i,j) == 1)
                    whiteCounter = whiteCounter + 1;
                else
                    if(whiteCounter >= 0.5*blackCounter && whiteCounter <= 1.5*blackCounter)
                        centerCounter = 1;
                        status = 3;
                    else
                        blackCounter = 1;
                        whiteCounter = 0;
                        status = 0;
                        
                    end
                end
            case 3
                if(img1_n(i,j) == 0)
                    centerCounter = centerCounter + 1;
                else
                    if(centerCounter >= 2.5*blackCounter && centerCounter <= 3.5*blackCounter)
                        whiteCounter = 1;
                        status = 4;
                    else
                        blackCounter = 0;
                        whiteCounter = 1;
                        status = 0;
                    end
                end
            case 4
                if(img1_n(i,j) == 1)
                    whiteCounter = whiteCounter + 1;
                else
                    if(whiteCounter >= 0.5*blackCounter && whiteCounter <= 1.5*blackCounter)
                    %if(whiteCounter == blackCounter)
                        blackCounter = 1;
                        status = 5;
                    else
                        blackCounter = 1;
                        whiteCounter = 0;
                        status = 0;
                    end
                end
            case 5
                if(img1_n(i,j) == 0)
                    blackCounter = blackCounter + 1;
                else
                    if(blackCounter >= 0.5*whiteCounter && blackCounter <= 1.5*whiteCounter)
                    %if(blackCounter == whiteCounter)
                        whiteCounter = 1;
                        status = 6;
                    else
                        blackCounter = 0;
                        whiteCounter = 1;
                        status = 0;
                    end
                end
            case 6
                if(img1_n(i,j) == 1)
                    whiteCounter = whiteCounter + 1;
                
                else
                    if(whiteCounter >= 0.5*blackCounter && whiteCounter <= 1.5*blackCounter)
                        status = 7;
                    else
                        blackCounter = 1;
                        whiteCounter = 0;
                        status = 0;
                    end
                end
            case 7
                status = 0;
                hold on
                vertical(n,:) = [startX, startY, i, j];
                line([vertical(n,2), vertical(n,4)], [vertical(n,1), vertical(n,3)], 'color', [0.0,0.5,0.0]);
                n = n+1;
                plot(startY, startX, '*g')
                plot(j, i, '+r')
        end
    end
end




horizontal = zeros(1000, 4);
m=1;
%Horizontal scanning
for i = 1:1:imSize(1)
    for j = 1:1:imSize(2)
        switch status
            case 0
                if(img1_n(i,j) == 0)
                    blackCounter = 1;
                    status = 1;
                    startX = i;
                    startY = j;
                end
            case 1 
                if(img1_n(i,j) == 0)
                    blackCounter = blackCounter + 1;
                else
                    whiteCounter = 1;
                    status = 2;
                end
                
            case 2
                if(img1_n(i,j) == 1)
                    whiteCounter = whiteCounter + 1;
                else
                    if(whiteCounter >= 0.5*blackCounter && whiteCounter <= 1.5*blackCounter)
                        centerCounter = 1;
                        status = 3;
                    else
                        blackCounter = 0;
                        status = 0;
                        
                    end
                end
            case 3
                if(img1_n(i,j) == 0)
                    centerCounter = centerCounter + 1;
                else
                    if(centerCounter >= 2.5*blackCounter && centerCounter <= 3.5*blackCounter)
                        whiteCounter = 1;
                        status = 4;
                    else
                        blackCounter = 0;
                        status = 0;
                    end
                end
            case 4
                if(img1_n(i,j) == 1)
                    whiteCounter = whiteCounter + 1;
                else
                    if(whiteCounter >= 0.5*blackCounter && whiteCounter <= 1.5*blackCounter)
                    %if(whiteCounter == blackCounter)
                        blackCounter = 1;
                        status = 5;
                    else
                        blackCounter = 0;
                        status = 0;
                    end
                end
            case 5
                if(img1_n(i,j) == 0)
                    blackCounter = blackCounter + 1;
                else
                    if(blackCounter >= 0.5*whiteCounter && blackCounter <= 1.5*whiteCounter)
                    %if(blackCounter == whiteCounter)
                        whiteCounter = 1;
                        status = 6;
                    else
                        status = 0;
                    end
                end
            case 6
                if(img1_n(i,j) == 1)
                    whiteCounter = whiteCounter + 1;
                else
                    if(whiteCounter >= 0.5*blackCounter && whiteCounter <= 1.5*blackCounter)
                        blackCounter = 0;
                        status = 7;
                    else
                        blackCounter = 0;
                        status = 1;
                    end
                end
            case 7
                status = 0;
                hold on
                horizontal(m,:) = [startX, startY, i, j];
                line([horizontal(m,2), horizontal(m,4)], [horizontal(m,1), horizontal(m,3)]);
                m = m+1;
                plot(startY, startX, '*b')
                plot(j, i, '+y')
                
        end
    end
end
