
diary('Fangling_Zhang_diary.txt');
d=readtable('wdbc.txt');
data=d(:,2:end);
x=data(:,2:end);
y1=data(:,1); 
%in excel, i replace "M" with 1 and "B" with 0 and save as"y1.mat'
y2=importdata('y1.mat');
y=table2array(y2);
%Q3
cv=cvpartition(569,'holdout',0.25);
xtr=x(training(cv),:);
xt=x(test(cv),:);
ytr=y(training(cv));
yt=y(test(cv));
%Q4
f1=fitcknn(xtr,ytr,'NumNeighbors',5);
f2=fitctree(xtr,ytr);
net=patternnet([10,2],'trainrp');
f3=train(net,xtr,ytr);
f4=fitcsvm(xtr,ytr);
f5=fitcsvm(xtr,ytr,'KernelFunction','polynomial');
fit=[f1 f2 f3 f4 f5];
accuracy=[0 0 0 0 0];
runtime=[0 0 0 0 0];
size=[0 0 0 0 0];
precision=[0 0 0 0 0];
for i =length(fit)
    tic
    yhat=predict(fit(i),xt);
    accuracy(i)=sum(isequal(yhat,yt));
    size(i)=whos(fit(i));
    t(i)=toc;
end

%Q5
f6=fitrtree(xtr,ytr);
f7=fitrtree(xtr,ytr,'MinParentSize',8);
f8=fitrtree(xtr,ytr,'CrossVal','on');
f9=fitrtree(xtr,ytr,'MaxNumSplits',10);
f10=prune(f6,'level',10);
fit=[f6 f7 f8 f9 f10];
sse=[0 0 0 0 0];
rmse=[0 0 0 0 0];
rse=[0 0 0 0 0];
rsq=[0 0 0 0 0];
size=[0 0 0 0 0];
runtime=[0 0 0 0 0];
for i =length(fit)
    tic
    yhat=predict(fit(i),xt);
    dif=yt-yhat;
    sse(i)=sum(dif'*dif)
    rmse(i)=sse(i)/length(yt);
    rsq(i)=1-sse(i);
    size(i)=whos(fit(i));
    t(i)=toc;
end

%Q6
f=pca(data);
%Q8
view(f9);
view(f10);

%Q8
