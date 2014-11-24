function [ cleanHorizontal, cleanVertical ] = checkNeighbours( sortedVertical, sortedHorizontal )
    %Create 2 matrices which will keep the fiducial marks
% cleanHorizontal = zeros(1,7);
% cleanVertical = zeros(1,7);
    count = 1;
    sizeOfV = size(sortedVertical,1);
    disp(sizeOfV)
    while count <= sizeOfV
        %if count < sizeOfV
        
            %first row  
            %disp(['sortV count +1 - count', num2str(sortedVertical(count+1,2) - sortedVertical(count,2))])
            if count == 1
                if (sortedVertical(count+1,2) - sortedVertical(count,2)) > 1
                    sortedVertical(count,:) = [];
                    sizeOfV = sizeOfV-1;
                    disp('ta bort 1')
                end
            elseif count == sizeOfV
                if ((sortedVertical(count,2) - sortedVertical(count-1,2)) > 1)
                    %Remove the lonely lines
                    %disp(['tar bort rad: ', num2str(sortedVertical(count,:))])
                    sortedVertical(count,:) = [];
                    sizeOfV = sizeOfV-1;
                    disp('ta bort 3')
                end
            %all rows in between 1st and last
            elseif count > 1 && count < sizeOfV
                disp(count)
                if ((sortedVertical(count+1,2) - sortedVertical(count,2)) > 1) && (sortedVertical(count,2) - sortedVertical(count-1,2)) > 1
                    %Remove the lonely lines
                    %disp(['tar bort rad: ', num2str(sortedVertical(count,:))])
                    sortedVertical(count,:) = [];
                    sizeOfV = sizeOfV-1;
                    disp('ta bort 2')
                end
            %last row
            end
            count = count+1;
           % disp(count)
        %end
    end
    
    count = 1;
    sizeOfH = size(sortedHorizontal,1);
    disp(sizeOfH)
    while count <= sizeOfH
        %if count < sizeOfV
        
            %first row  
            %disp(['sortV count +1 - count', num2str(sortedVertical(count+1,2) - sortedVertical(count,2))])
            if count == 1
                if (sortedHorizontal(count+1,1) - sortedHorizontal(count,1)) > 1
                    sortedHorizontal(count,:) = [];
                    sizeOfH = sizeOfH-1;
                    disp('ta bort 1')
                end
            elseif count == sizeOfH
                if ((sortedHorizontal(count,1) - sortedHorizontal(count-1,1)) > 1)
                    %Remove the lonely lines
                    %disp(['tar bort rad: ', num2str(sortedVertical(count,:))])
                    sortedHorizontal(count,:) = [];
                    sizeOfH = sizeOfH-1;
                    disp('ta bort 3')
                end
            %all rows in between 1st and last
            elseif count > 1 && count < sizeOfH
                disp(count)
                if ((sortedHorizontal(count+1,1) - sortedHorizontal(count,1)) > 1) && (sortedHorizontal(count,1) - sortedHorizontal(count-1,1)) > 1
                    %Remove the lonely lines
                    %disp(['tar bort rad: ', num2str(sortedVertical(count,:))])
                    sortedHorizontal(count,:) = [];
                    sizeOfH = sizeOfH-1;
                    disp('ta bort 2')
                end
            %last row
            end
            count = count+1;
           % disp(count)
        %end
    end
    
    
    disp('klar')
    %cleanHorizontal = zeros(size(sortedVertical,1), 7);
    cleanHorizontal = sortedHorizontal;
    cleanVertical = sortedVertical;
%   else
%   cleanVertical = [cleanVertical, zeros(1,7)];
%   cleanVertical(count) = sortedVertical(count,2);
    %cleanVertical = repmat(sortedVertical,1);
%   disp(count)

end