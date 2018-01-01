clear ; close all; clc
rng(23)
filename=fullfile('adult.txt');
T=readtable(filename,'Delimiter',' ','ReadVariableNames',false);
%delete nan value
TF = ismissing(T,{'' '.' 'NA' NaN -99 '?,' 0});
T(any(TF,2),:);
T=T(~any(TF,2),:);
rng(1)
y=T(:,15);
y=table2array(y);
classes=unique(y)
low=T(strmatch(classes(1),y),:);
cvp1=cvpartition(size(low,1),'holdout',0.25);
tr1=low(training(cvp1),:);
t1=low(test(cvp1),:);
high=T(strmatch(classes(2),y),:);
cvp2=cvpartition(size(high,1),'holdout',0.25);
tr2=high(training(cvp2),:);
t2=high(test(cvp2),:);
tr=[tr1;tr2];
t=[t1;t2];
xtr=tr(:,1:14);
ytr=tr(:,15);
xt=t(:,1:14);
yt=t(:,15);
yt=table2array(yt);
nb=fitcnb(xtr,ytr);
%ltIndex = strcmp(nb.ClassNames,'>50K');
%estimates = nb.DistributionParameters{ltIndex,1}

%CPT

for hh = [2,4,6,7,8,9,10,14] %for each discrete variable with less than 10 classes;
    da=T(:,[hh,15]);   
    dx=table2array(T(:,hh));
    class=unique(dx);
    probs = zeros(2, length(class));
    for ii = [1,2], % for each class of y
        da2=da(strmatch(classes(ii),y),:);
        dx2=table2array(da2(:,1));
        for jj = 1:length(class), % for each class of variable      
            dx3=dx2(strmatch(class(jj),dx2));
            probs(ii, jj) = (length(dx3)+1)/(length(dx2)+length(class)); 
        end
    end
    probs
end

%attribute 2 and 9,10,14 (workclass, race, sex and native-country have
%much larger number in one column).

cpre=predict(nb,xt);
%[post,cpre,logp] = posterior(nb,xt)
con=confusionmat(cpre,yt)
accuracy=sum(diag(con))/length(yt)
prediction=con(1,1)/sum(con(:,1))
recall_value=con(1,1)/sum(con(1,:))
