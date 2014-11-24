function [ cleanHorizontal, cleanVertical ] = checkNeighbours2( sortedVertical, sortedHorizontal )

%Loop through vertical & horizontal...
%om det ligger en bredvid, l?gg till
sizeOfV = size(sortedVertical,1);
%1:Y, 2:X, 3:Y, 4:X
firstX = sortedVertical(1,2);
firstY = sortedVertical(1,1);
nextX = sortedVertical(1,2);
nextY = sortedVertical(1,1);
cleanVertical = zeros(1,7);

nrInRow = 1;
spann = 5
i = 1
    while i < sizeOfV
        %om avst?ndet till n?sta ?r < 5
        %addera alla v?rden f?r att kunna hitta ett medelv?rde!
        i=i+1;
        if nextX - firstX < spann
            cleanVertical = [cleanVertical, zeros(1,7)];
            
        end
        nextY = sortedVertical(i,1);
        
    end

end