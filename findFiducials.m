function [ sortedHorizontal, sortedVertical ] = findFiducials( img )
% findFiducials: Find areas in image that has the characteristics of a
%fiducial mark: w:b:w:b:b:b:w:b:w.
%   input argument: img is a black/white image
%   output: sortedHorizontal: array holding the possible fiducials in horizontal
%   direction, sortedVertical: array holding the possible fiducials in vertical
%   direction

imSize = size(img);

vertical = zeros(1, 5);
n = 1;
status = -1;
%Counters keep track of size of bit
blackCounter = 0;
whiteCounter = 0;
centerCounter = 0;
stopX = 0;
stopY = 0;
startX = 0;
startY = 0;
prevStart = 1;
prevStartY = 1;
i = 1;
j = 1;
verHor = 1;
%Vertical scanning
while j < imSize(2)
    while i <= imSize(1)
        switch status
            case -1
                % -1: If White border around QR-code move to next case,
                % otherwise increase row and column counter (i and j)
                prevStart = i;
                prevStartY = j;                                                                   
                if(img(i,j) == 1)
                    status = 0;
                else
                    [i,j] = increase(prevStart,prevStartY,imSize,verHor);
                end
            case 0
                % 0: Outer black border of fiducial mark
                % If the pixel is black, go to next case, otherwise
                % increase
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
                % 1: Outer white border of fiducial mark
                % If pixel is black increase black counter
                % If pixel is white, increase white counter and go to next
                % case
                [i,j] = increase(i,j,imSize,verHor);
                if(img(i,j) == 0)
                    blackCounter = blackCounter + 1;
                else
                    whiteCounter = 1;
                    status = 2;
                end
            case 2
                % 2: Black square of fiducial mark
                % If pixel is white increase white counter
                % If pixel is black, check if the counters are within the
                % range 50-150% - if so go to next case, 
                % else: No finders pattern, go to initial case                
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
                % 3: Center case of fiducial mark
                % If pixel is black, increase center counter, else check if
                % counter is within range: 250-400% of black counter (white
                % counter could also work). If so: go to next case, else go
                % to initial case.
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
                % 4: Black square of fiducial mark
                % If next pixel is white increase white counter
                % If next pixel is black, check if the counters are within the
                % range 50-150% - if so go to next case, 
                % else: No finders pattern, go to initial case 
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
                % 5: White square of fiducial mark
                % If pixel is black increase black counter
                % If pixel is white, check if the counters are within the
                % range 50-150% - if so go to next case, 
                % else: No finders pattern, go to initial case 
                [i,j] = increase(i,j,imSize,verHor);
                if(img(i,j) == 0)
                    blackCounter = blackCounter + 1;
                    stopY = i;
                    stopX = j;
                else
                    if(blackCounter >= 0.5*whiteCounter && blackCounter <= 1.5*whiteCounter && stopY ~= 0)
                        whiteCounter = 1;
                        status = 6;
                    else
                        [i,j] = increase(prevStart,prevStartY,imSize,verHor);
                        status = -1;
                    end
                end
            case 6
                % 6: Last case. Fiducial mark found!
                [i,j] = increase(i,j,imSize,verHor);
                status = -1;
                
                whiteCounter = 1;
                % Save start, end and center positions of fiducial marks
                vertical = [vertical; zeros(1,5)];
                vertical(n,1:4) = [startY, startX, stopY, stopX];

                midY = (stopY+startY)/2;
                vertical(n,5) = ceil(midY);                
                n = n+1;
        end
        %If last pixel of image, leave while loops
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
stopX = 0;
stopY = 0;
prevStart = 1;
prevStartY = 1;

i = 1;
j = 1;
horizontal = zeros(1, 5);
m = 1;
verHor = 0;
%Horizontal scanning, see status explanation in loop for Vertical scanning.
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
                    if(blackCounter >= 0.5*whiteCounter && blackCounter <= 1.5*whiteCounter && stopX ~= 0)
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
                
                horizontal = [horizontal; zeros(1,5)];
                horizontal(m,1:4) = [startY, startX, stopY, stopX];
                
                midX = (stopX+startX)/2;
                horizontal(m,5) = ceil(midX);
                m = m+1;
        end
        if(i == imSize(1) && j == imSize(2))
            break;
        end
    end
    if(i == imSize(1) && j == imSize(2))
        break;
    end
end

%Remove all rows of zeros
vertical(all(vertical==0,2),:) = [];
horizontal(all(horizontal==0,2),:) = [];
%Return matrices of horizontal sorted by startX and startY and vertical
%sorted by startY and startX
sortedHorizontal = sortrows(horizontal, [2 1]);
sortedVertical = sortrows(vertical, [1 2]);
end

