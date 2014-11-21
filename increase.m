function [I,J] = increase(i,j,imgSize)
%increase:  increases the x and y positions
%   Detailed explanation goes here
% disp(i)
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

