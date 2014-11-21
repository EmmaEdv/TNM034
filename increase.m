function [I,J] = increase(i,j,imgSize,verHor)
%increase:  increases the x and y positions
%   Detailed explanation goes here
% disp(i)
%   Vertical scanning
    if(verHor ==1 )
        if(i == imgSize(1) && j < imgSize(2))
    %         disp('ny kolonn')
            i = 1;
            j = j + 1;
        elseif i ~=imgSize(1)
    %         disp('ny rad')
            i = i + 1;
        end

        I = i;
        J = j;
    end
    %Horizontal scanning
    if(verHor == 0)
        if(j == imgSize(2) && j < imgSize(1))
    %         disp('ny rad')
            j = 1;
            i = i + 1;
        elseif j ~=imgSize(1)
    %         disp('ny kolonn')
            j = j + 1;
        end

        I = i;
        J = j;
    end
end

