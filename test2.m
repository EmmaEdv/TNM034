close all
clear all
nrOfCols = 41;

%img1 = imread('D:\Skola\TNM034\Images_Training_1\Bygg_1.png');
img1 = imread('Images_Training_1/Bygg_1.png');

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

status = 0;
blackCounter = 0;
whiteCounter = 0;
centerCounter = 0;
startX = 0;
startY = 0;

%Loop through image to enter repetitions of colors...
for j = 1:20:imSize(2)
    for i = 1:20:imSize(1)
        switch status
            case 0
                if(img1_n(i,j) == 1)
                    blackCounter = 0;
                    status = 1;
                end
            case 1 
                if(img1_n(i,j) == 1)
                    blackCounter = blackCounter + 1;
                else
                    startX = i;
                    startY = j;
                    whiteCounter = 0;
                    status = 2;
                end
                
            case 2
                if(img1_n(i,j) == 0)
                    whiteCounter = whiteCounter + 1;
                else
                    if(whiteCounter == blackCounter)
                        centerCounter = 0;
                        status = 3;
                    else
                        blackCounter = 0;
                        status = 0;
                        
                    end
                end
            case 3
                if(img1_n(i,j) == 1)
                    centerCounter = centerCounter + 1;
                else
                    if(centerCounter == 3*blackCounter)
                        whiteCounter = 0;
                        status = 4;
                    else
                        blackCounter = 0;
                        status = 0;
                    end
                end
            case 4
                if(img1_n(i,j) == 0)
                    whiteCounter = whiteCounter + 1;
                else
                    if(whiteCounter == blackCounter)
                        blackCounter = 0;
                        status = 5;
                    else
                        blackCounter = 0;
                        status = 0;
                    end
                end
            case 5
                if(img1_n(i,j) == 1)
                    blackCounter = blackCounter + 1;
                else
                    if(blackCounter == whiteCounter)
                        whiteCounter = 0;
                        status = 6;
                    else
                        status = 0;
                    end
                end
            case 6
%                 if(img1_n(i,j) == 0)
%                     whiteCounter = whiteCounter + 1;
%                 else
%                     if(whiteCounter == blackCounter)
%                         blackCounter = 0;
%                         status = 7;
%                     else
%                         blackCounter = 0;
%                         status = 1;
%                     end
%                 end
%             case 7
                disp('Fiducial!')
                disp(i)
                disp(j)
                disp(whiteCounter);
                disp(blackCounter);
                status = 0;
                figure
                imshow(img1_n((startX:i),(startY:j)));
        end
    end
end