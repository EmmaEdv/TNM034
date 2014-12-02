function [centerPoints] = clustering2( img, vertical )
imshow(img);

iLabel = logical(img);
stat = regionprops(iLabel, 'centroid')
centroids = cat(1,stat.Centroid)

plot(centroids, '+y')

end