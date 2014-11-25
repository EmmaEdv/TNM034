function [ fiducial ] = checkNeighbours2( sortedVertical, sortedHorizontal )

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

fiducial = zeros(5,2);
nrFiducials = 0;

nrInRow = 1;
spann = 5;
i = 2;

    while i < sizeOfV
        %s? l?nge det finns en n?sta p? avst?nd < spann till denna, 
        %s? vill spara next till "sista"
        %annars s? vill vi r?kna (sista-start)/antal punkter
        %?ka p? n?sta
        hej = nextX - firstX;
       % disp(['first: ' , num2str(firstY), ', next: ' , num2str(nextY), ', i rad: ', num2str(nrInRow)])
       % disp(hej);
        %Om n?sta linje ligger bredvid %%%(nextX - prevX > 0 && nextY -
        %prevY > 0 && )
        if  nextX - prevX < spann && nextY - prevY < spann && i ~= sizeOfV-1
            disp(['I RAD!: first y: ' , num2str(firstY), ', next y: ' , num2str(nextY), ', prev y: ' , num2str(prevY)])
            disp([ 'first x: ' , num2str(firstX),  ', next x: ' , num2str(nextX), ', prev x: ' , num2str(prevX), ', i rad: ', num2str(nrInRow)])
            disp('  ')
            prevX = nextX;
            prevY = nextY;
            %cleanVertical = [cleanVertical, zeros(1,7)];
            nrInRow = nrInRow + 1;
        %Om n?sta linje har ett st?rre avst?nd fr?n f?reg?ende ?n spann    
        elseif (nextX - prevX > spann || nextY - prevY > spann || i == sizeOfV-1) && nrInRow > 10
            %R?kna ut medelv?rdet!!!
            disp(['SKIT!: first y: ' , num2str(firstY), ', next y: ' , num2str(nextY), ', prev y: ' , num2str(prevY)])
            disp([ 'first x: ' , num2str(firstX),  ', next x: ' , num2str(nextX), ', prev x: ' , num2str(prevX), ', i rad: ', num2str(nrInRow)])
            disp(' ')
            
            nrFiducials = nrFiducials + 1;
            
            disp(['prev x: ',num2str(prevX), ', first x: ',num2str(firstX), ', prev y: ',num2str(prevY), ', first y: ',num2str(firstY)]);
            disp(' ')
            %R?kna medelpunkten
            medX = (prevX + firstX)/2;
            medY = (prevY + firstY)/2;
            
            fiducial(nrFiducials, :) = [medX, medY];
            
            nrInRow = 0;
            firstX = sortedVertical(i,2);
            firstY = sortedVertical(i,5);
        else
            %disp(['ANNARS!: first y: ' , num2str(firstY), ', next y: ' , num2str(nextY), ', prev y: ' , num2str(prevY)])
            %disp([ 'first x: ' , num2str(firstX),  ', next x: ' , num2str(nextX), ', prev x: ' , num2str(prevX), ', i rad: ', num2str(nrInRow)])
            %disp(' ')
            firstX = sortedVertical(i,2);
            firstY = sortedVertical(i,5);
        end
        i=i+1;
        prevX = nextX;
        prevY = nextY;
        nextX = sortedVertical(i,2);
        nextY = sortedVertical(i,5);
        
    end
    
    disp(['nr of fiducials: ', num2str(nrFiducials)]);
    
end