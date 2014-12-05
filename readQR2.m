%function [ str ] = readQR( img, centerPoints, bitSize )
function [ qrcode ] = readQR2( img, bitSize, sortedFiducial )
%close all


figure
imshow(img)
topLeft = [(min(sortedFiducial(:,1))-3*bitSize), (min(sortedFiducial(:,2))-3*bitSize)]
qrSize = (bitSize*41);
bottomRight = [(topLeft(1)+qrSize), (topLeft(2)+qrSize)]
% disp([num2str(bottomRight(1)), ' ', num2str(bottomRight(2)), ' & ',  num2str(topLeft(1)), ' ', num2str(topLeft(2))]);
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
    for i = topLeft(1):bitSize:(bottomRight(1)-bitSize)
        for j = topLeft(2):bitSize:(bottomRight(2)-bitSize)
             %TOP LEFT Fiducial:
            if (j < (topLeft(2)+8*bitSize) && i < (topLeft(1)+8*bitSize))
                topLeftCounter = topLeftCounter +1;
            elseif(j >= (topLeft(2) + 33*bitSize) && i < (topLeft(1)+8*bitSize))
                botLeftCounter = botLeftCounter+1;
            elseif(j < (topLeft(2)+8*bitSize) && i >= (topLeft(1)+33*bitSize))
                topRightCounter = topRightCounter +1;
            elseif (j > (topLeft(2)+31*bitSize) && j <= (topLeft(2)+36*bitSize) && i > (topLeft(1)+31*bitSize) && i <= (topLeft(1)+36*bitSize))
                alignmentPattern = alignmentPattern +1;
            else
                counter = counter + 1;
                
                temp(1,counter) = img(abs(round(j)),abs(round(i)));
                bitz = strcat(bitz, num2str(img(abs(round(j)),abs(round(i)))));
                hold on
                plot(i, j, '+r');
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