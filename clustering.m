function [centerPoints] = clustering( img, vertical )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
imshow(img);

clusterArray = vertical(:,4:5);
nrOfClusters = 5;

    opts = statset('Display','final');
    [idx,C, sumd] = kmeans(clusterArray, nrOfClusters,'Distance','sqeuclidean', 'Replicates', 5, 'Options', opts);

    
    plot(clusterArray(idx==1,1), clusterArray(idx==1,2), 'r.','MarkerSize',12)
    hold on
    plot(clusterArray (idx==2,1), clusterArray(idx==2,2), 'b.','MarkerSize',12)
    plot(clusterArray (idx==3,1), clusterArray(idx==3,2), 'g.','MarkerSize',12)
    plot(clusterArray (idx==4,1), clusterArray(idx==4,2), 'y.','MarkerSize',12)
    plot(clusterArray (idx==5,1), clusterArray(idx==5,2), 'y.','MarkerSize',12)
    plot(C(:,1),C(:,2),'yx', 'MarkerSize',15,'LineWidth',3)
    legend('Cluster 1','Cluster 2','Cluster 3', 'Centroids', 'Location','NW')
    title 'Cluster Assignments and Centroids'
    hold off

centerPoints = zeros(3,2);
felMarg = 300;
temp = max(sumd);
%centerPoints(1,:) = sumd(1);
n = 0;
for i = 1:nrOfClusters
    if sumd(i) < (temp + felMarg) && sumd(i) > (temp - felMarg)
        n = n+1;
        centerPoints(n,:) = C(i,:);
    end
end

centerPoints = sortrows(centerPoints, [2,1]);
    
end

