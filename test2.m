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

vertical = zeros(1000, 6);
n = 1;
status = 0;
blackCounter = 0;
whiteCounter = 0;
blackCounter2 = 0;
whiteCounter2 = 0;

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
                        whiteCounter2 = 1;
                        status = 4;
                    else
                        blackCounter = 0;
                        whiteCounter = 1;
                        status = 0;
                    end
                end
            case 4
                if(img1_n(i,j) == 1)
                    whiteCounter2 = whiteCounter2 + 1;
                else
                    if(whiteCounter2 >= 0.5*whiteCounter && whiteCounter2 <= 1.5*whiteCounter)
                    %if(whiteCounter == blackCounter)
                        blackCounter2 = 1;
                        status = 5;
                    else
                        blackCounter = 1;
                        whiteCounter2 = 0;
                        status = 0;
                    end
                end
            case 5
                if(img1_n(i,j) == 0)
                    blackCounter2 = blackCounter2 + 1;
                    stopY = i;
                    stopX = j;
                else
                    if(blackCounter2 >= 0.5*blackCounter && blackCounter2 <= 1.5*blackCounter)
                    %if(blackCounter == whiteCounter)
                        whiteCounter2 = 1;
                        status = 6;
                    else
                        blackCounter2 = 0;
                        whiteCounter2 = 1;
                        status = 0;
                    end
                end
            case 6
%                 if(img1_n(i,j) == 1)
%                     whiteCounter2 = whiteCounter2 + 1;
%                 
%                 else
%                     if(whiteCounter2 >= 0.5*whiteCounter && whiteCounter2 <= 1.5*whiteCounter)
%                         status = 7;
%                     else
%                         blackCounter2 = 1;
%                         whiteCounter2 = 0;
%                         status = 0;
%                     end
%                 end
%             case 7
                status = 0;
                hold on
                vertical(n,1:4) = [startY, startX, i, j];
                %Draw lines:
                line([vertical(n,2), vertical(n,4)], [vertical(n,1), vertical(n,3)], 'color', [0.0,0.5,0.0]);
                %Calculate k and b of equation y=kx+b
                k = slope(vertical(n,1:4));
                b = intercept(vertical(n, 1:4), k);
                vertical(n,5) = k;
                vertical(n,6) = b;
                
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


horizontal = zeros(1000, 6);
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
%                 if(img1_n(i,j) == 1)
%                     whiteCounter = whiteCounter + 1;
%                 else
%                     if(whiteCounter >= 0.5*blackCounter && whiteCounter <= 1.5*blackCounter)
%                         blackCounter = 0;
%                         status = 7;
%                     else
%                         blackCounter = 0;
%                         status = 1;
%                     end
%                 end
%             case 7
                status = 0;
                hold on
                horizontal(m,1:4) = [startY, startX, i, j];
                %Draw line
                line([horizontal(m,2), horizontal(m,4)], [horizontal(m,1), horizontal(m,3)]);
                %Calculate k and b of equation y=kx+b
                k = slope(horizontal(m,1:4));
                b = intercept(horizontal(m, 1:4), k);
                horizontal(m,5) = k;
                horizontal(m,6) = b;
                
                m = m+1;
                plot(startX, startY, '*b')
                plot(stopX, stopY, '*y')
                
        end
    end
end

%TAKES LONG TIME AND IS WRONG
% vSize = size(vertical);
% hSize = size(horizontal);
% intersect = zeros(100, 3);
% for i = 1:vSize(1)
%     for j = 1:hSize(1)
%         xintersect = (vertical(i,6)-horizontal(j,6))/(horizontal(j,5)-vertical(i,5));
%         yintersect = horizontal(j,5)*xintersect + horizontal(j,6);
%         hold on
%         plot(xintersect, yintersect, '*y');
%     end
% end
        
% %FIX DIS!!!!!

% xintersect = (b2-b1)/(m1-m2)
% yintersect = m1*xintersect + b1
% 
% 
% plot(xintersect,yintersect,'m*','markersize',8)
% legend({'line1','line2','intersection'},'Location','West')
% hold off
