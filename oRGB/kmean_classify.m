klist=2:30;%the number of clusters you want to try
myfunc = @(X,K)(kmeans(X, K));
eva = evalclusters(X,myfunc,'CalinskiHarabasz','klist',klist);
classes=kmeans(X,eva.OptimalK);
max(classes)

[coeff,score,latent] = pca(X);

figure;
plot(score(classes==1,1),score(classes==1,2),'r.','MarkerSize',12)
hold on

% colors = {'#00FF00' ,'#0000FF' ,'#00FFFF' ,'#FF00FF', '#FFFF00' ,'#008080', '#800080', '#3abd64' ,'#5d020a', '#b17833' ,'#b2d987', '#3ae589', '#a6335c' ,'#ed1169', '#bfcb9d','#cc911b' ,'#0a5e6d'};
colors = {'red', 'green', 'blue', 'cyan', 'magenta', 'yellow', 'black'};

for c = 2:max(classes)
    plot(score(classes==c,1),score(classes==c,2),string(colors{c})+'.','MarkerSize',12)
end

% plot(C(:,1),C(:,2),'kx',...
%      'MarkerSize',15,'LineWidth',3) 
% legend('Cluster 1','Cluster 2','Centroids',...
%        'Location','NW')
% title 'Cluster Assignments and Centroids'
hold off