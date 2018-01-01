% Fangyu Lin
% CS539 HW3 
% Mar/26/2017
% Regression Tree
%========================

clear ALL;
clc;

y1 = cell2mat(adult(:,5)); % train to education_num
y1 = y1(:);
x1 = [cell2mat(adult(:,1)) cell2mat(adult(:,3)) cell2mat(adult(:,11)) cell2mat(adult(:,12)) cell2mat(adult(:,13))]; 
vars = {'age','fnlwgt','capitalGain','capitalLoss','hours_per_week'}

tree = fitrtree(x1,y1,'PredictorNames',vars, ...
    'CategoricalPredictors',{'age', 'hours_per_week'}, 'MaxNumSplits',12,'prune','off','SplitCriterion','mse');
% view(tree,'mode','graph');

y_hat1 = predict(tree, x1);
cm1 = confusionmat(y1,y_hat1);

rtree = prune(tree,'Level',1);
view(rtree, 'mode','graph');

kModel = crossval(tree, 'KFold', 4);
kLoss = kfoldLoss(kModel);
% v1= see(rtree);