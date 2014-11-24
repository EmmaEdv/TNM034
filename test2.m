close all
clear all
nrOfCols = 41;

%img1 = imread('D:\Skola\TNM034\Images_Training_1\Bygg_1.png');%
img1 = imread('Images_Training_1/Bygg_1.png');
%img1 = imread('Images_Training_3/Hus_2a.png');
%img1 = imread('Images_Training_5/Husannons_full.png');

%Normalize
img1_n = im2bw(img1, graythresh(img1));

imSize = size(img1_n);

imshow(img1_n)

% status
% -1: White border around QR-code
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
status = -1;
blackCounter = 0;
whiteCounter = 0;

centerCounter = 0;
startX = 0;
startY = 0;
%Vertical scanning
%Loop through image to enter repetitions of colors...
i = 1;
j = 1;
prevStart = 1;
prevStartY = 1;
verHor = 1;
while j < imSize(2)
    while i <= imSize(1)
        switch status
            case -1
                prevStart = i;
                prevStartY = j;                                                                   
                if(img1_n(i,j) == 1)
                    status = 0;
                else
                    [i,j] = increase(prevStart,prevStartY,imSize,verHor);
                end
            case 0
                prevStart = i;
                prevStartY = j;
                [i,j] = increase(i,j,imSize,verHor);
                if(img1_n(i,j) == 0)
                    blackCounter = 1;
                    status = 1;
                    startY = i;
                    startX = j;
                end
                
            case 1 
                [i,j] = increase(i,j,imSize,verHor);
                if(img1_n(i,j) == 0)
                    blackCounter = blackCounter + 1;
                    
                else
                    whiteCounter = 1;
                    status = 2;
                end
            case 2
                [i,j] = increase(i,j,imSize,verHor);
                if(img1_n(i,j) == 1)
                    whiteCounter = whiteCounter + 1;
                    
                else
                    if(whiteCounter >= 0.5*blackCounter && whiteCounter <= 1.5*blackCounter)
                        centerCounter = 1;
                        status = 3;
                    else
                        [i,j] = increase(prevStart,prevStartY,imSize,verHor);
                        status = -1;
                    end
                end
            case 3
                [i,j] = increase(i,j,imSize,verHor);
                if(img1_n(i,j) == 0)
                    centerCounter = centerCounter + 1;
                else
                    if(centerCounter >= 2.5*blackCounter && centerCounter <= 4*blackCounter)
                        whiteCounter = 1;
                        status = 4;
                    else
                        [i,j] = increase(prevStart,prevStartY,imSize,verHor);
                        status = -1;
                    end
                end
            case 4
                [i,j] = increase(i,j,imSize,verHor);
                if(img1_n(i,j) == 1)
                    whiteCounter = whiteCounter + 1;
                else
                    if(whiteCounter >= 0.5*blackCounter && whiteCounter <= 1.5*blackCounter)
                        blackCounter = 1;
                        status = 5;
                    else
                        [i,j] = increase(prevStart,prevStartY,imSize,verHor);
                        status = -1;
                    end
                end
            case 5
                [i,j] = increase(i,j,imSize,verHor);
                if(img1_n(i,j) == 0)
                    blackCounter = blackCounter + 1;
                    stopY = i;
                    stopX = j;
                else
                    if(blackCounter >= 0.5*whiteCounter && blackCounter <= 1.5*whiteCounter)
                        whiteCounter = 1;
                        status = 6;
                    else
                        [i,j] = increase(prevStart,prevStartY,imSize,verHor);
                        status = -1;
                    end
                end
            case 6
                [i,j] = increase(i,j,imSize,verHor);
                status = -1;
                whiteCounter = 1;
                hold on
                vertical = [vertical; zeros(1,7)];
                vertical(n,1:4) = [startY, startX, stopY, stopX];
                %Draw lines:
              %  line([vertical(n,2), vertical(n,4)], [vertical(n,1), vertical(n,3)], 'color', [0.0,0.5,0.0]);
                %Calculate k and b of equation y=kx+b
                k = slope(vertical(n,1:4));
                b = intercept(vertical(n, 1:4), k);
                vertical(n,6) = k;
                vertical(n,7) = b;
                
                midY = startY + (stopY-startY)/2;
                vertical(n,5) = midY;
             %   plot(startX, midY, '+w');
                n = n+1;
                plot(startX, startY, '+g')
                plot(stopX, stopY, '+r')
        end
        if(i == imSize(1) && j == imSize(2))
            break;
        end
    end
    if(i == imSize(1) && j == imSize(2))
            break;
        end
    i = 0;
end



blackCounter = 0;
whiteCounter = 0;
status = 0;
startX = 0;
startY = 0;
i = 1;
j = 1;
prevStart = 1;
prevStartY = 1;  
horizontal = zeros(1, 7);
m=1;
verHor = 0;
%Horizontal scanning
while i < imSize(1)
    while j <= imSize(2)
        switch status
            case -1
                prevStart = i;
                prevStartY = j;                                                                   
                if(img1_n(i,j) == 1)
                    status = 0;
                else
                    [i,j] = increase(prevStart,prevStartY,imSize, verHor);
                end
            case 0
                prevStart = i;
                prevStartY = j;
                [i,j] = increase(i,j,imSize, verHor);
                if(img1_n(i,j) == 0)
                    blackCounter = 1;
                    status = 1;
                    startY = i;
                    startX = j;
                end
                
            case 1 
                [i,j] = increase(i,j,imSize, verHor);
                if(img1_n(i,j) == 0)
                    blackCounter = blackCounter + 1;
                    
                else
                    whiteCounter = 1;
                    status = 2;
                end
            case 2
                [i,j] = increase(i,j,imSize,verHor);
                if(img1_n(i,j) == 1)
                    whiteCounter = whiteCounter + 1;
                    
                else
                    if(whiteCounter >= 0.5*blackCounter && whiteCounter <= 1.5*blackCounter)
                        centerCounter = 1;
                        status = 3;
                    else
                        [i,j] = increase(prevStart,prevStartY,imSize, verHor);
                        status = -1;
                    end
                end
            case 3
                [i,j] = increase(i,j,imSize, verHor);
                if(img1_n(i,j) == 0)
                    centerCounter = centerCounter + 1;
                else
                    if(centerCounter >= 2.5*blackCounter && centerCounter <= 4*blackCounter)
                        whiteCounter = 1;
                        status = 4;
                    else
                        [i,j] = increase(prevStart,prevStartY,imSize, verHor);
                        status = -1;
                    end
                end
            case 4
                [i,j] = increase(i,j,imSize, verHor);
                
                if(i >= 115 && i<=132 && j >= 145 && j <= 230 && status>2)
                    disp(['status: ', num2str(status), ' i: ', num2str(i), ' j: ', num2str(j)])
                    disp(['blackCounter: ', num2str(blackCounter), ' whiteCounter: ', num2str(whiteCounter), ' color: ', num2str(img1_n(i,j))])
                end

                if(img1_n(i,j) == 1)
                    whiteCounter = whiteCounter + 1;
                else
                    if(whiteCounter >= 0.5*blackCounter && whiteCounter <= 1.5*blackCounter)
                        blackCounter = 1;
                        status = 5;
                    else
                        [i,j] = increase(prevStart,prevStartY,imSize, verHor);
                        status = -1;
                    end
                end
            case 5
                [i,j] = increase(i,j,imSize, verHor);
                if(img1_n(i,j) == 0)
                    blackCounter = blackCounter + 1;
                    stopY = i;
                    stopX = j;
                else
                    if(blackCounter >= 0.5*whiteCounter && blackCounter <= 1.5*whiteCounter)
                        whiteCounter = 1;
                        status = 6;
                    else
                        [i,j] = increase(prevStart,prevStartY,imSize, verHor);
                        status = -1;
                    end
                end
            case 6
                [i,j] = increase(i,j,imSize, verHor);
                status = -1;
                whiteCounter = 1;
                hold on
                horizontal = [horizontal; zeros(1,7)];
                horizontal(m,1:4) = [startY, startX, stopY, stopX];
                %Draw lines:
               % line([horizontal(m,2), horizontal(m,4)], [horizontal(m,1), horizontal(m,3)], 'color', [0.0,0.5,0.0]);
                %Calculate k and b of equation y=kx+b
                k = slope(horizontal(m,1:4));
                b = intercept(horizontal(m, 1:4), k);
                horizontal(m,6) = k;
                horizontal(m,7) = b;
                
                midX = startX + (stopX-startX)/2;
                horizontal(m,5) = midX;
               % plot(midX, startY, '+w');
                m = m+1;
                plot(startX, startY, '+g')
                plot(stopX, stopY, '+r')
        end
        if(i == imSize(1) && j == imSize(2))
            break;
        end
    end
    if(i == imSize(1) && j == imSize(2))
        break;
    end
    %i = 0;
end



%Tar bort alla tomma rader (2an betyder att den kollar radvis)
vertical(all(vertical==0,2),:)=[];
horizontal(all(horizontal==0,2),:)=[];

%sort horizontal by start Y pos, vertical by start X pos
sortedHorizontal = sortrows(horizontal, [1 2]);
sortedVertical = sortrows(vertical, [2 1]);

[cleanHorizontal, cleanVertical] = checkNeighbours(sortedVertical, sortedHorizontal);
figure
imshow(img1_n)
hold on

plot(cleanHorizontal(:,4), cleanHorizontal(:,3), 'g*')
plot(cleanHorizontal(:,2), cleanHorizontal(:,1), 'r*')

plot(cleanVertical(:,4), cleanVertical(:,3), 'b+')
plot(cleanVertical(:,2), cleanVertical(:,1), 'y+')





% % % % % 
% % % % % % Ritar ut centerpunkter.. kollar p? 1 pixel t h?ger och 1 t v?nster
% % % % % vl = size(vertical);
% % % % % xVert = [vertical(1,2),vertical(1,4), NaN];
% % % % % yVert = [(vertical(1,5)-1), (vertical(1,5)+1), NaN];
% % % % % %yVert = [(vertical(1,5)), (vertical(1,5)), NaN];
% % % % % for n = 2:vl(1)
% % % % %     xVert = [xVert, vertical(n,2), vertical(n,4), NaN];
% % % % %     yVert = [yVert, (vertical(n,5)-1), (vertical(n,5)+1), NaN];
% % % % %     %yVert = [yVert, (vertical(n,5)), (vertical(n,5)), NaN];
% % % % % end
% % % % % 
% % % % % hl = size(horizontal);
% % % % % xHor = [(horizontal(1,5)-1),(horizontal(1,5)+1), NaN];
% % % % % %xHor = [(horizontal(1,5)),(horizontal(1,5)), NaN];
% % % % % yHor = [horizontal(1,1), horizontal(1,3), NaN];
% % % % % for n = 2:hl(1)
% % % % %     xHor = [xHor, (horizontal(n,5)-1),(horizontal(n,5)+1), NaN];
% % % % %     %xHor = [xHor, (horizontal(n,5)),(horizontal(n,5)), NaN];
% % % % %     yHor = [yHor, horizontal(n,1), horizontal(n,3), NaN];
% % % % % end
% % % % % 
% % % % % [xi, yi] = polyxpoly(xVert, yVert, xHor, yHor);
% % % % % mapshow(xi,yi,'DisplayType','point','Marker','o')