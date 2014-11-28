function [ horizontal, vertical, avgBit ] = findFiducials( img )
% findFiducials: Find areas in image that has the characteristics of a
%fiducial mark: w:b:w:b:b:b:w:b:w.
% input argument: img is a black/white image
% output: horizontal: array holding the possible fiducials in horizontal
% direction
% output: vertical: array holding the possible fiducials in vertical
% direction
% output: avgBit: average size of a bit

imSize = size(img);

% status explanation:
% -1: White border around QR-code
% 0: White border around QR-code
% 1: Outer black border of fiducial mark
% 2: Outer white border of fiducial mark
% 3: Black square of fiducial mark
% 4: Same as 2
% 5: Same as 1
% 6: extra case.. 

vertical = zeros(1, 5);
n = 1;
status = -1;
blackCounter = 0;
whiteCounter = 0;
%want to save the average bit length for readQR
avgBit = 0; 
%also divide by the number of times we add length
avgCounter = 0;
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
                if(img(i,j) == 1)
                    status = 0;
                else
                    [i,j] = increase(prevStart,prevStartY,imSize,verHor);
                end
            case 0
                prevStart = i;
                prevStartY = j;
                [i,j] = increase(i,j,imSize,verHor);
                if(img(i,j) == 0)
                    blackCounter = 1;
                    status = 1;
                    startY = i;
                    startX = j;
                end
                
            case 1 
                [i,j] = increase(i,j,imSize,verHor);
                if(img(i,j) == 0)
                    blackCounter = blackCounter + 1;
                    
                else
                    whiteCounter = 1;
                    status = 2;
                end
            case 2
                [i,j] = increase(i,j,imSize,verHor);
                if(img(i,j) == 1)
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
                if(img(i,j) == 0)
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
                if(img(i,j) == 1)
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
                if(img(i,j) == 0)
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
                avgBit = avgBit + blackCounter;
                avgCounter = avgCounter + 1;
                whiteCounter = 1;
                hold on
                vertical = [vertical; zeros(1,5)];
                vertical(n,1:4) = [startY, startX, stopY, stopX];
                %Draw lines:
              %  line([vertical(n,2), vertical(n,4)], [vertical(n,1), vertical(n,3)], 'color', [0.0,0.5,0.0]);
                
                midY = startY + (stopY-startY)/2;
                vertical(n,5) = midY;
                plot(startX, midY, '+w');
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
horizontal = zeros(1, 5);
m=1;
verHor = 0;
%Horizontal scanning
while i < imSize(1)
    while j <= imSize(2)
        switch status
            case -1
                prevStart = i;
                prevStartY = j;                                                                   
                if(img(i,j) == 1)
                    status = 0;
                else
                    [i,j] = increase(prevStart,prevStartY,imSize, verHor);
                end
            case 0
                prevStart = i;
                prevStartY = j;
                [i,j] = increase(i,j,imSize, verHor);
                if(img(i,j) == 0)
                    blackCounter = 1;
                    status = 1;
                    startY = i;
                    startX = j;
                end
                
            case 1 
                [i,j] = increase(i,j,imSize, verHor);
                if(img(i,j) == 0)
                    blackCounter = blackCounter + 1;
                    
                else
                    whiteCounter = 1;
                    status = 2;
                end
            case 2
                [i,j] = increase(i,j,imSize,verHor);
                if(img(i,j) == 1)
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
                if(img(i,j) == 0)
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

                if(img(i,j) == 1)
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
                if(img(i,j) == 0)
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
                avgBit = blackCounter + avgBit;
                avgCounter = avgCounter + 1;
                hold on
                horizontal = [horizontal; zeros(1,5)];
                horizontal(m,1:4) = [startY, startX, stopY, stopX];
                %Draw lines:
               % line([horizontal(m,2), horizontal(m,4)], [horizontal(m,1), horizontal(m,3)], 'color', [0.0,0.5,0.0]);
                
                midX = startX + (stopX-startX)/2;
                horizontal(m,5) = midX;
               plot(midX, startY, '+w');
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

%Average bitLength
avgBit = avgBit/avgCounter

%Tar bort alla tomma rader (2an betyder att den kollar radvis)
vertical(all(vertical==0,2),:) = [];
horizontal(all(horizontal==0,2),:) = [];


end

