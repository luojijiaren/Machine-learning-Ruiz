% CS539 HW4 
% Fangyu Lin
% April/13/2017

% Stratified Sampling ============================
% cls100 = cvpartition(adult(:,15),'KFold',4);
fraction = 0.75;

classes = unique(adult(:,15));

%this is dataset preprocessing line
% ptadult = replaceNum(adult); 

nObs = length(ptadult(:,15));
nClasses = length(classes);
nSamples = round(nObs * fraction / nClasses);
ind0 = [];
ind1 = [];

flag = (strcmp(ptadult(:,15),classes(ii)));
for k = 1:length(flag)
    if flag(k) == 0
        ind0 = cat(1,ind0,k);
    else
        ind1 = cat(1,ind1,k);
    end
end

% first do the index patitioning for different classes
[tr1,te1,val1] = dividerand(ind0',0.75,0.25,0); 
[tr2,te2,val2] = dividerand(ind1',0.75,0.25,0);
tr1 = tr1';
te1 = te1';
tr2 = tr2';
te2 = te2';
Xtest = cat(1,ptadult(tr1,:),ptadult(tr2,:));
Xtrain = cat(1,ptadult(te1,:),ptadult(te2,:));

% rowheaders = {'age','workclass','fnlwgt','education','education_num','marital','occupation','relationship','race','sex','capital_gain','capital_loss','hours_per_week','native_country','earn'};
cnb = fitcnb(cell2mat(Xtrain(:,1:14)),cell2mat(Xtrain(:,15)));
Ytest = predict(cnb,cell2mat(Xtest(:,1:14)));
Rcnb = cov(cell2mat(Xtest(:,15)),Ytest);
acycnb = sum(cell2mat(Xtest(:,15))==Ytest)/length(Ytest)

% Observable Markov Models and Hidden Markov Models (60 points)
