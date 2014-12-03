%function [ str ] = readQR( img, centerPoints, bitSize )
function [ wholeText ] = readQR( img, bitSize, sortedFiducial )
%close all

se = strel('rectangle',[round(bitSize/2) round(bitSize/2)]);
img = imopen(img, se);
img = imclose(img, se);
img = imclose(img, se);
%img = imopen(img, se);

figure
imshow(img)
topLeft = [sortedFiducial(1,1)-3.5*bitSize, sortedFiducial(1,2)-3.5*bitSize];
%crop the image so that only the qr code is shown
xmin = (sortedFiducial(2,1)-3.5*bitSize);
ymin = (sortedFiducial(2,2)-3.5*bitSize);
width = 41*bitSize;
height = 41*bitSize;

 %   cropImg = imcrop(img, [xmin ymin width height]);
% figure
%     imshow(cropImg);

% img(1:bitSize:end,:) = 0;       %# Change every tenth row to black
% img(:,1:bitSize:end) = 0;       %# Change every tenth column to black
% imshow(img);                  %# Display the image
% 

% % figure
% % imshow(img)
% % hold on
% % M = size(img,1);
% % N = size(img,2);
% % 
% % for k = ymin:bitSize:M
% %     x = [1 N];
% %     y = [k k];
% %     plot(x,y,'Color','w','LineStyle','-');
% %     plot(x,y,'Color','k','LineStyle',':');
% % end
% % 
% % for k = xmin:bitSize:N
% %     x = [k k];
% %     y = [1 M];
% %     plot(x,y,'Color','w','LineStyle','-');
% %     plot(x,y,'Color','k','LineStyle',':');
% % end

hold off

    
    wholeText = 'hej';
    
        %?vers?tt till 
%     disp(['BOTTOM LEFT FIDUCIAL', num2str(botLeft)]);
% 	  disp(['TOP LEFT FIDUCIAL', num2str(topLeft)]);
%     disp(['TOP RIGHT FIDUCIAL', num2str(topRight)]);

end