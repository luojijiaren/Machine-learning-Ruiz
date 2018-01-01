% Fangyu Lin
% CS539 HW3 
% Mar/28/2017
% Support Vector Machine Model
%========================

load fisheriris

inds = ~strcmp(species,'setosa');
xx1 = meas(inds,3:4);
X3 = cell2mat(adult(1:1000,[13,5])); 
yy1 = species(inds);
Y3 = adult(1:1000,15);

svmM = fitcsvm(X3,Y3);
kModel = crossval(svmM, 'KFold', 4);
svmLoss = kfoldLoss(kModel)
% view(svmM);

sv = svmM.SupportVectors;
figure
gscatter(X3(:,1),X3(:,2),Y3)
hold on
plot(sv(:,1),sv(:,2),'ko','MarkerSize',10)
legend('versicolor','virginica','Support Vector')
hold off