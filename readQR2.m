function [ qrcode ] = readQR2( img, bitSizeX, bitSizeY, sortedFiducial )
% 
% figure
% imshow(img)

topLeft = [(min(sortedFiducial(:,1))-3*bitSizeX), (min(sortedFiducial(:,2))-3*bitSizeY)];
qrSizeX = (bitSizeX*41);
qrSizeY = (bitSizeY*41);
bottomRight = [(topLeft(1)+qrSizeX), (topLeft(2)+qrSizeY)];

qrcode = '';
letterNr = 1;
temp = zeros(1,8);
counter = 0;
topLeftCounter=0;
botLeftCounter=0;
topRightCounter=0;
alignmentPattern = 0;
letterArray = zeros(1);
letterCounter = 0;
bitz = '';

    %i = x, j = y
    for i = topLeft(1):bitSizeX:(bottomRight(1)-bitSizeX)
        for j = topLeft(2):bitSizeY:(bottomRight(2)-bitSizeY)
            %Fiducials:
            if (j < (topLeft(2)+8*bitSizeY) && i < (topLeft(1)+8*bitSizeX))
                topLeftCounter = topLeftCounter +1;
            elseif(j >= (topLeft(2) + 33*bitSizeY) && i < (topLeft(1)+8*bitSizeX))
                botLeftCounter = botLeftCounter+1;
            elseif(j < (topLeft(2)+8*bitSizeY) && i >= (topLeft(1)+33*bitSizeX))
                topRightCounter = topRightCounter +1;
            elseif (j > (topLeft(2)+31*bitSizeY) && j <= (topLeft(2)+36*bitSizeY) && i > (topLeft(1)+31*bitSizeX) && i <= (topLeft(1)+36*bitSizeX))
                alignmentPattern = alignmentPattern +1;
            %No fiducials:    
            else
                counter = counter + 1;
                
                temp(1,counter) = img(abs(round(j)),abs(round(i)));
                bitz = strcat(bitz, num2str(img(abs(round(j)),abs(round(i)))));
%                 hold on
%                 plot(i, j, '+r');
                %Read 8 bits at a time
                if counter == 8
                    letterCounter = letterCounter + 1;
                    ascii = char(bi2de(fliplr(temp(1, :))));
                    qrcode = strcat(qrcode, ascii);
                    letterArray = [letterArray; zeros(1)];
                    
                    string = '';
                    decimal = 0;
                    ascii = 0;
                    
                    counter = 0;
                    bitz = '';
                end
            end
        end
    end
end