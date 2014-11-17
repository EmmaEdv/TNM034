function [x,y] = nextPixel(i,j, size, dir)
%?ka p? i eller s?tt i=1 och ?ka p? j
%dir = 0: horizontal
%dir = 1: vertical


% if(dir == 0)
%     if(i == size(1))
%         j = j+1;
%         i = 1;
%     else
%         i = i+1;
%     end
% else
%     if(j == size(2))
%         i = i+1;
%         j = 1;
%     else
%         j = j+1;
%     end
% end
x=i;
y=j;