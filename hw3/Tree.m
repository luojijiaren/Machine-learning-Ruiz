filename=fullfile('adult.txt')
T=readtable(filename,'Delimiter',' ','ReadVariableNames',false);
X=T(:,1:14);
y=T(:,15);
y=table2array(y);
cvp=cvpartition(32561,'holdout',0.25);
xtr=X(training(cvp),:);
ytr=y(training(cvp));
xt=X(test(cvp),:);
yt=y(test(cvp));
rng(1);

rtree=fitctree(xtr,ytr,'MaxNumSplits',7,'MinLeafSize',40);
%rtree=fitctree(X,y);
%cvtree=crossval(rtree,'kFold',4);
[Yfit,yscore] = predict(rtree,xt);
accuracy=sum(strcmp(Yfit,yt))/numel(yt);
cfm = confusionmat(yt,Yfit); % !problem here. confusion matrix
%cvAccuracy = sum(cfm(logical(eye(2))))/length(Yfit); 
%rtree=fitctree(X,y,'MaxNumSplits',7,'CrossVal','on');
%view(rtree.Trained{1},'Mode','Graph');
view(rtree,'Mode','Graph');
%cvrtree = crossval(rtree,'KFold',4);
%cvloss = kfoldLoss(cvrtree);
[~,~,~,bestlevel]=cvLoss(rtree,'SubTrees','All','TreeSize','min');
view(rtree,'Mode','Graph','Prune',31);
tree=prune(rtree,'Level',31);
view(tree,'Mode','Graph');

Ynew = predict(rtree,X(testing(cvp),:))

%bagging tree and random forest
leaf=[10 20 50]
num=[40 20 5]
col='rbc'
figure;
for i = 1:length(leaf)
    b=TreeBagger(50,X(training(cvp),:),y(training(cvp),:),'Method','C','OOBPred','on',...
        'NumPredictorsToSample',num(i),'MinLeafSize',leaf(i));
    plot(oobError(b),col(i));
    hold on;
end
xlabel'Number of Grown Trees'
ylabel 'Mean Squared Error'
legend({'10' '20' '50'},'Location','NorthEast')
hold off

    