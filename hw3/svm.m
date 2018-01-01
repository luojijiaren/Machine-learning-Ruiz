filename=fullfile('adult.txt')
T=readtable(filename,'Delimiter',' ','ReadVariableNames',false);
X=T(:,1:14);
y=T(:,15);
rng(2);
SVMModel=fitcsvm(X,y,'Standardize',true,'KernelFunction','linear',...
    'KernelScale','auto')
CVsvm=crossval(SVMModel,'KFold',4)
loss=kfoldLoss(CVsvm)
%draw a plot
svInd=SVMModel.SupportVectors;
figure
gscatter(X(:,1),X(:,2),y)
hold on
plot(sv(:,1),sv(:,2),'ko','MarkerSize',10)
hold off
