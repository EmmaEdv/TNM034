function [ sortedVertical ] = removeFalsies( sortedVertical, sortedHorizontal )

%Loop through vertical & horizontal...
%om det ligger en bredvid, l?gg till
sizeOfV = size(sortedVertical,1);
%1:Y, 2:X, 3:Y, 4:X
firstY = sortedVertical(1,5);
firstX = sortedVertical(1,2);
prevY = sortedVertical(1,5);
prevX = sortedVertical(1,2);
nextY = sortedVertical(2,5);
nextX = sortedVertical(2,2);

nrFiducials = 0;

nrInRow = 1;
spann = 5;
i = 2;

    while i < sizeOfV
        %save next to last as long as there is a next at a disctance < spann to prev
        %else count (last-start)/nrInRow
        %increase next
        hej = nextX - firstX;
        
        %If next point is at distance < spann to prev
        %if  nextX - prevX < spann && nextY - prevY < spann && i ~= sizeOfV-1
        if nextY - prevY < spann && i ~= sizeOfV-1
            if nextX - prevX < spann && nextX - prevX > 0
%                 disp([num2str(nrInRow), ', firstY: ', num2str(firstY), ', nextY: ', num2str(nextY), ', prevY: ', num2str(prevY)])
%                 disp([num2str(nrInRow), ', firstX: ', num2str(firstX), ', nextX: ', num2str(nextX), ', prevX: ', num2str(prevX)])
%                 disp(' ')
                prevX = nextX;
                prevY = nextY;
                %cleanVertical = [cleanVertical, zeros(1,7)];
                nrInRow = nrInRow + 1;
            elseif  nrInRow > 10
                nrFiducials = nrFiducials + 1

                nrInRow = 0;
                firstX = sortedVertical(i,2);
                firstY = sortedVertical(i,5);
            else
%                 sortedVertical(i,:) = 0;
%                 
%                 disp(['removing shit'])
%                 disp(['i: ', num2str(i), ', xpos: ', num2str(sortedVertical(i,4)), ', midYpos: ', num2str(sortedVertical(i,5))]);
                %firstY = sortedVertical(i,5);
            end
            
            
        %If next is at distance > spann to prev and there are more than 10
        %points in a row
        elseif (nextX - prevX > spann || nextY - prevY > spann || i == sizeOfV-1) && nrInRow > 10
            nrFiducials = nrFiducials + 1;
            
%             disp([num2str(nrFiducials)]);    
%             disp([num2str(nrInRow), ', firstY: ', num2str(firstY), ', nextY: ', num2str(nextY), ', prevY: ', num2str(prevY)])
%             disp([num2str(nrInRow), ', firstX: ', num2str(firstX), ', nextX: ', num2str(nextX), ', prevX: ', num2str(prevX)])
%             disp(' ');

            firstX = sortedVertical(i,2);
            firstY = sortedVertical(i,5);
        %If the distance > spann and there are no points in a row
        else
            disp(['removing shit'])
            disp(['i: ', num2str(i), ', xpos: ', num2str(sortedVertical(i,4)), ', midYpos: ', num2str(sortedVertical(i,5))]);
            sortedVertical(i,:) = 0;
            %firstX = sortedVertical(i,2);
            %firstY = sortedVertical(i,5);
        end
        i=i+1;
        prevX = nextX;
        prevY = nextY;
        nextX = sortedVertical(i,2);
        nextY = sortedVertical(i,5);
        
    end
    %remove the empty rows in sortedVertical
    sortedVertical(all(sortedVertical==0,2),:)=[];
%     disp(['nr of fiducials: ', num2str(nrFiducials)]);
    
end