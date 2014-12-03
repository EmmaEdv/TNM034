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
%bitSize = round(bitSize);

%disp(['TopLeft: ',num2str(topLeft), ', stepsize: ', num2str(stepSize), ', bottomRight: ',  num2str(bottomRight)]);
%disp(['f?rsta: ', num2str(img(topLeft(1),topLeft(2)))]);
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
                
                %string = strcat(string, num2str(cropImg(i,j)));
                temp(1,counter) = img(abs(round(j)),abs(round(i)));
                bitz = strcat(bitz, num2str(img(abs(round(j)),abs(round(i)))));
                hold on
                plot(i, j, '+r');
                %L?gger in bin?ra siffrorna i array, 8 st/rad 
                %binary(n, counter) = cropImg(i,j);
                %L?s 8 bitar ?t g?ngen
                if counter == 8
                    %?vers?tt till ascii
                    letterCounter = letterCounter + 1;
                    %decimal = bin2dec(string);
                    %ascii = char(decimal)
                    ascii = char(bi2de(fliplr(temp(1, :))));
                    qrcode = strcat(qrcode, ascii);
                    
                    letterArray = [letterArray; zeros(1)];
%                     disp(bitz)
%                     letterArray[letterCounter] = bitz;
                    
                    string = '';
                    decimal = 0;
                    ascii = 0;
                    %binary = [binary; zeros(1,8)];
                    counter = 0;
                    bitz = '';
                end
            
            
            %2)l?s ned till BL-centerpunkt - 5 (egentligen 4,5)
            
            %L?s p? det viset tills i (x-led) ?r p? TL-centerpunkt (&BR) +
            %5 (egentligen 4,5)... d? ?r den utanf?r fiducial mark:et. Den
            %ska d? l?sa fr?n TL-centepunkt - 5 (top) till BL-centerpunkt
            %+ 5 (bottom)
            
            %3)OBS: KOM IH?G LILLA FIDUCIAL-MARK:ET MED CENTERPUNKT I
            %X: TR-CENTER - 4 OCH Y: BL-CENTER-4
            
            %4) L?s p? det viset tills i (x-led) ?r p? TR-centerpunkt - 5
            %(egentligen 4,5). D? ska den l?sa i y-led TR-centerpunkt + 5
            %och ned till botten.
        end
    end
end


end