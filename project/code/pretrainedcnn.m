load('rcnnStopSigns.mat','cifar10Net');
YTest = classify(cifar10Net, testImages);
% yhat=zeros(size(YTest));
% yhat(find(YTest=='bird'))=2;
% yhat(find(YTest=='cat'))=3;
testLabels2=categorical(testLabels);
% Calculate the accuracy.
% hist(YTest,unique(YTest))
% hist(yhat,unique(yhat))

con=confusionmat(YTest,testLabels2)
accuracy=sum(diag(con))/length(testLabels2)
prediction=con(1,1)/sum(con(:,1))
recall_value=con(1,1)/sum(con(1,:))