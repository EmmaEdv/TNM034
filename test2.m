close all
clear all
nrOfCols = 41;

%img1 = imread('D:\Skola\TNM034\Images_Training_1\Bygg_1.png');
img1 = imread('Images_Training_1/Bygg_1.png');
%img1 = imread('Images_Training_3/Hus_2a.png');
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

%y=kx + m function
slope = @(line) (line(2) - line(1))/(line(4) - line(3));

intercept = @(line,m) line(1) - m*line(3);

%1000 ?R KANSKE INTE J?TTEBRA V?RDE EGENTLIGEN...
vertical = zeros(1, 7);
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
                if(img1_n(i,j) == 0)
%                     whiteCounter = whiteCounter + 1;
%                 else
                    blackCounter = 1;
                    status = 1;
                    startY = i;
                    startX = j;
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
                        status = 0;
                    end
                end
            case 3
                if(img1_n(i,j) == 0)
                    centerCounter = centerCounter + 1;
                    if(j==100)
                        disp('start test')
                        disp(i)
                        disp(centerCounter)
                        disp(blackCounter)
                        disp('slut test')
                    end
                else
                    if(centerCounter >= 2.5*blackCounter && centerCounter <= 4*blackCounter)
                        whiteCounter = 1;
                        status = 4;
                    else
                        status = 0;
                    end
                end
            case 4
                if(img1_n(i,j) == 1)
                    whiteCounter = whiteCounter + 1;
                else
                    if(whiteCounter >= 0.5*blackCounter && whiteCounter <= 1.5*blackCounter)
                        blackCounter = 1;
                        status = 5;
                    else
                        status = 0;
                    end
                end
            case 5
                if(img1_n(i,j) == 0)
                    blackCounter = blackCounter + 1;
                    stopY = i;
                    stopX = j;
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
                status = 0;
                hold on
                vertical = [vertical; zeros(1,7)];
                vertical(n,1:4) = [startY, startX, stopY, stopX];
                %Draw lines:
                line([vertical(n,2), vertical(n,4)], [vertical(n,1), vertical(n,3)], 'color', [0.0,0.5,0.0]);
                %Calculate k and b of equation y=kx+b
                k = slope(vertical(n,1:4));
                b = intercept(vertical(n, 1:4), k);
                vertical(n,6) = k;
                vertical(n,7) = b;
                
                midY = startY + (stopY-startY)/2;
                vertical(n,5) = midY;
                plot(startX, midY, '+w');
                n = n+1;
                plot(startX, startY, '+g')
                plot(stopX, stopY, '+r')
        end
    end
end



blackCounter = 0;
whiteCounter = 0;
blackCounter2 = 0;
whiteCounter2 = 0;


horizontal = zeros(1, 7);
m=1;
%Horizontal scanning
for i = 1:1:imSize(1)
    for j = 1:1:imSize(2)
        switch status
            case 0
                if(img1_n(i,j) == 0)
                    blackCounter = 1;
                    status = 1;
                    startY = i;
                    startX = j;
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
                        status = 0;
                    end
                end
            case 5
                if(img1_n(i,j) == 0)
                    blackCounter = blackCounter + 1;
                    stopY = i;
                    stopX = j;
                else
                    if(blackCounter >= 0.5*whiteCounter && blackCounter <= 1.5*whiteCounter)
                        whiteCounter = 1;
                        status = 6;
                    else
                        status = 0;
                    end
                end
            case 6
                status = 0;
                hold on
                horizontal = [horizontal; zeros(1,7)];
                horizontal(m,1:4) = [startY, startX, stopY, stopX];
                %Draw line
                line([horizontal(m,2), horizontal(m,4)], [horizontal(m,1), horizontal(m,3)]);
%               %Calculate k and b of equation y=kx+b
%               k = slope(horizontal(m,1:4));
%               b = intercept(horizontal(m, 1:4), k);
                horizontal(m,6) = k;
                horizontal(m,7) = b;
                
                midX = startX + (stopX-startX)/2;
                horizontal(n,5) = midX;
                
                m = m+1;
                plot(midX, startY, '+w');
                plot(startX, startY, '*b')
                plot(stopX, stopY, '*y')
        end
    end
end



sortedVertical = sortrows(vertical , [5 4]); 

length = size(sortedVertical);
tempX = sortedVertical(2,2);
tempY = sortedVertical(2,5);
tolX = 12;
tolY = 20;

calcCX = 0;
calcCY = 0;
nrOfCP = 0;
row = 1;
centerPoint = zeros(1,2);
centerPoint2 = zeros(1,2);
centerPoint3 = zeros(1,2);

for k = 1:length(1)
    if (sortedVertical(k,2) >= (tempX+1) && sortedVertical(k,2) <= (tempX+tolX) && sortedVertical(k,5) >= (tempY-tolY) && sortedVertical(k,5) <= (tempY+tolY))
        line([tempX, sortedVertical(k,2)], [tempY, sortedVertical(k,5)], 'color', [1.0,0.25,0.80]);
        tempX = sortedVertical(k,2);
        tempY = sortedVertical(k,5);
        nrOfCP = nrOfCP + 1;
        centerPoint(row,1) = centerPoint(row,1) + tempX;
        centerPoint(row,2) = centerPoint(row,2) + tempY;
    else
        %centerPoint(row,1) = centerPoint(row, 1)/nrOfCP;
        %centerPoint(row,2) = centerPoint(row, 2)/nrOfCP;
        tempX = sortedVertical(k,2);
        tempY = sortedVertical(k,5);
        nrOfCP = 0;
        row = row+1;
        %N?r ska detta ske?
        centerPoint = [centerPoint; zeros(1,2)];
    end
    
end
