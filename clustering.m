function [centerPoints] = clustering( img, vertical )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

clusterArray = vertical(:,4:5);
Result = []; 

for nrOfClusters = 1:20  
    centroid = kmeans(clusterArray,nrOfClusters,'distance','sqeuclidean');  
    s = silhouette(clusterArray,centroid,'sqEuclidean'); 
    Result = [ Result; nrOfClusters mean(s)];  
end
Result
%% Figure showing the 'elbow diagram' of the silhouette
% figure    
% plot( Result(:,1),Result(:,2),'r*-.');
figure
[M, I] = max(Result(:,2));
nrOfClusters = Result(I,1)
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
imSize = size(img);
felMarg = imSize(1)*imSize(2)*0.000625
temp = max(sumd);
%centerPoints(1,:) = sumd(1);
n = 0;
for i = 1:nrOfClusters
    if sumd(i) < (temp + felMarg) && sumd(i) > (temp - felMarg) && i<nrOfClusters
        n = n+1;
        centerPoints(n,:) = C(i,:);
    end
end
sumd;
C;
%centerPoints(2:3, :) = sortrows(centerPoints(2:3, :), [2 1])
    
end

