% Fangyu Lin
% CS539 HW3 
% Mar/26/2017
% Decision Tree Model
%========================

clear ALL;
clc;

y1 = adult(:,15); % train the <=50 and >50
x1 = [cell2mat(adult(:,1)) cell2mat(adult(:,5)) cell2mat(adult(:,11)) cell2mat(adult(:,12)) cell2mat(adult(:,13))]; 
vars = {'age','educationNum','capitalGain','capitalLoss','hours_per_week'}

tree = fitctree(x1,y1,'PredictorNames',vars,'CategoricalPredictors',{'educationNum','hours_per_week'}, 'Prune','off');
% tree = fitctree(x1,y1,'Prune','off','KFold',4);
% view(tree,'mode','graph');

y_hat1 = predict(tree, x1(200:500,:));
cm1 = confusionmat(y1,y_hat1);

ttree = prune(tree,'Level',80);
view(ttree, 'mode','graph');

kModel = crossval(tree, 'KFold', 4);
kLoss = kfoldLoss(kModel)


%# load data
% load carsmall
% 
% %# construct predicting attributes and target class
% vars = {'MPG' 'Cylinders' 'Horsepower' 'Model_Year'};
% x = [MPG Cylinders Horsepower Model_Year];  %# mixed continous/discrete data
% y = cellstr(Origin);                        %# class labels
% 
% %# train classification decision tree
% t = classregtree(x, y, 'method','classification', 'names',vars, ...
%                 'categorical',[2 4], 'prune','off');
% view(t)
% 
% %# test
% yPredicted = eval(t, x);
% cm = confusionmat(y,yPredicted);           %# confusion matrix
% N = sum(cm(:));
% err = ( N-sum(diag(cm)) ) / N;             %# testing error
% 
% %# prune tree to avoid overfitting
% tt = prune(t, 'level',3);
% view(tt)
% 
% %# predict a new unseen instance
% inst = [26 4 88 76];
% prediction = eval(tt, inst)    %# pred = 'Japan'

% load census1994
% X = adultdata(:,{'age','workClass','education_num','marital_status','race',...
%     'sex','capital_gain','capital_loss','hours_per_week','salary'});
% summary(X)
% adtree = fitctree(X,'salary','PredictorSelection','curvature','Surrogate','on');
% view(adtree,'mode','graph')
% imp = predictorImportance(Mdl);
% 
% figure;
% bar(imp);
% title('Predictor Importance Estimates');
% ylabel('Estimates');
% xlabel('Predictors');
% h = gca;
% h.XTickLabel = Mdl.PredictorNames;
% h.XTickLabelRotation = 45;
% h.TickLabelInterpreter = 'none';