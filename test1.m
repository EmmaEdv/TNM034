%close all
%clear all
nrOfCols = 41;

img1 = imread('qr_six.png');
%figure
%imshow(img1(:,1))

%Normalize
img1_n = im2bw(img1, graythresh(img1));

imSize = size(img1_n)

bitW = round(imSize(1)/nrOfCols);
bitH = round(imSize(2)/nrOfCols);

%figure
%imshow(img1_n)

array = zeros(8, 180);
pos = 1;
fmark = 0;
row = 1;
col = 1;
%B?rjar p? bitH/2 & bitW/2 f?r att hamna i mitten av en bit..
for j = (bitH/2):bitH:imSize(2)
    for i = (bitW/2):bitW:imSize(1)

        %Skip top left fiducial mark
        if (((bitW/2)<=i && (bitW/2)+8*bitW) && (((bitH/2)<=j<=(bitH/2)+8*bitH))) 
            fmark = fmark+1
            fprintf('Top left fiducial mark \n' )
        %Skip bottom left fiducial mark
        elseif (((bitW/2)+34*bitW)<=i<=((bitW/2)+41*bitW) && (((bitH/2)<=j<=(bitH/2)+8*bitH)))
            fmark = fmark+1
            fprintf('Bottom left fiducial mark \n' )
        %Skip top right fiducial mark
        elseif (((bitW/2)<=i<=(bitW/2)+8*bitW) && ((bitH/2)+34*bitH)<=i<=((bitH/2)+41*bitH))
            fmark = fmark+1
            fprintf('Top right fiducial mark \n' )
        %Skip the small fiducial mark
        elseif (((bitW/2)+33*bitW)<=i<=((bitW/2)+37*bitW) && ((bitH/2)+33*bitH)<=i<=((bitH/2)+37*bitH))
            fmark = fmark+1
            fprintf('Small fiducial mark \n' )
        else
            fprintf('Inte fiducial mark \n')
            value = img1_n(i,j,1);
            array(pos, j) = value;
            if pos == 8 
                pos = 1;
            else
                pos = pos + 1;
            end
        end
        row = row + 1;
    end
    row = 1;
    col = col + 1;
end
array(:,j)
