T=readtable('optdigits.tra.txt');     
X=T(:,1:64);
y=T(:,65);
cvp=cvpartition(3823,'holdout',0.25);
xtr=X(training(cvp),:);
ytr=y(training(cvp),:);
xt=X(test(cvp),:);
yt=y(test(cvp),:);
st=cputime;
net=patternnet([50,10],'trainrp');
net=train(net,xtr,ytr);
t=cputime-st;
yhat=net(xt);
classes=vec2ind(yhat);
accuracy=sum(yt==classes)/length(classes);
confusionmat(yt,classes);
perform(net,yhat,yt);


%layers=[X
    fullyConnectedLayer(20)
    reluLayer

    fullyConnectedLayer(10)
    softmaxLayer
    classificationLayer()];
%options = trainingOptions('sgdm', ...
    'MaxEpochs',5, ...
    'InitialLearnRate',0.0001);
%netTransfer = trainNetwork(T,layers,options);
