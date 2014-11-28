%function [ str ] = readQR( img, centerPoints, bitSize )
function [ wholeText ] = readQR( img, bitSize, sortedFiducial )
%close all

se = strel('rectangle',[round(bitSize/2) round(bitSize/2)]);
img = imopen(img, se);
img = imclose(img, se);
img = imclose(img, se);
%img = imopen(img, se);

%figure
%imshow(img)

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

 

%     
%     %den r?ta exmepelbilden ([TL[x,y]; TR[x,y]; BL[x,y]]): centerPoints = [106,197;494,197;106,585];
%     %centerPoints = [106,197;494,197;106,585];
%     
%     imgSize = size(cropImg);
%     %1a) b?rja kolla p? x(i) n?r den ?r TL-centerpt:x + 3 (f?r att hamna i mitten av biten,
%     %f?r v?nsterkant: 3,5)
%     %startX = floor(centerPoints(1,1)-3*bitSize);
%     startX = floor(bitSize/2);
%     %1b) b?rja kolla p? y(j) n?r den ?r TL-centerpt:y + 5 (f?r att hamna i mitten av biten,
%     %f?r ?verkant: 4,5)
%     %startY = floor(centerPoints(1,2)-5*bitSize);
%     startY = floor(bitSize/2);
%     %i ?r x-led
%     
%     binary = zeros(1,8);
%     counter = 0;
%     n = 1;
%     topLeft=0;
%     botLeft=0;
%     topRight=0;
%     bitSize = floor(bitSize);
%     temp = zeros(1,8);
%     wholeText = '';
%     for i = startX:bitSize:imgSize(2)
%         %j ?r y-led
%         for j = startY:bitSize:imgSize(1)
%             
%             %TOP LEFT Fiducial:
%             if (j < 8*bitSize && i < 8*bitSize)
%                 topLeft = topLeft +1;
%             elseif(j > (imgSize(1) - 8*bitSize) && i < 8*bitSize)
%                 botLeft = botLeft+1;
%             elseif(j < 8*bitSize && i > (imgSize(2) - 8*bitSize))
%                 topRight = topRight +1;
%             else
%                 counter = counter + 1;
%                 
%                 %string = strcat(string, num2str(cropImg(i,j)));
%                 temp(1,counter) = cropImg(i,j);
%                 %L?gger in bin?ra siffrorna i array, 8 st/rad 
%                 %binary(n, counter) = cropImg(i,j);
%                 %L?s 8 bitar ?t g?ngen
%                 if counter == 8
%                     %?vers?tt till ascii
%                     
%                     %decimal = bin2dec(string);
%                     %ascii = char(decimal)
%                     ascii = char(bi2de(fliplr(temp(1, :))));
%                     wholeText = strcat(wholeText, ascii);
%                     
%                     string = '';
%                     decimal = 0;
%                     ascii = 0;
%                     n = n+1;
%                     %binary = [binary; zeros(1,8)];
%                     counter = 0;
%                 end
%             
%             
%             %2)l?s ned till BL-centerpunkt - 5 (egentligen 4,5)
%             
%             %L?s p? det viset tills i (x-led) ?r p? TL-centerpunkt (&BR) +
%             %5 (egentligen 4,5)... d? ?r den utanf?r fiducial mark:et. Den
%             %ska d? l?sa fr?n TL-centepunkt - 5 (top) till BL-centerpunkt
%             %+ 5 (bottom)
%             
%             %3)OBS: KOM IH?G LILLA FIDUCIAL-MARK:ET MED CENTERPUNKT I
%             %X: TR-CENTER - 4 OCH Y: BL-CENTER-4
%             
%             %4) L?s p? det viset tills i (x-led) ?r p? TR-centerpunkt - 5
%             %(egentligen 4,5). D? ska den l?sa i y-led TR-centerpunkt + 5
%             %och ned till botten.
%             
%             
%             
%             if j == imgSize(1)
%                 j = 1;
%             else
%                 j = j+1;
%             end
%         end
%         if i==imgSize(2) && j == imgSize(1)
%             break;
%         end
%     end
%     
%     %L?s 8 bitar ?t g?ngen (svart = 0, vit = 1)
%    
%     end
%     wholeText
    
    wholeText = 'hej';
    
        %?vers?tt till 
%     disp(['BOTTOM LEFT FIDUCIAL', num2str(botLeft)]);
% 	  disp(['TOP LEFT FIDUCIAL', num2str(topLeft)]);
%     disp(['TOP RIGHT FIDUCIAL', num2str(topRight)]);

end