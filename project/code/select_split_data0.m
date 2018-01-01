clear ; close all; clc
%load data and merge
data1 = load('data_batch_1');
data2 = load('data_batch_2');
data3 = load('data_batch_3');
data4 = load('data_batch_4');
data5 = load('data_batch_5');
totaldata=[data1.data,data1.labels;data2.data,data2.labels;data3.data,data3.labels;data4.data,data4.labels;data5.data,data5.labels];


%find bird data and set labels to 1
a=find(totaldata(:,3073)==2);
birddata=totaldata(a,:);
birddata(:,3073)=1;
%get 5000 no-bird data and set labels to 0
% b=find(totaldata(:,3073)~=2);
% todata2=totaldata(b,:);
% compdata=todata2(randperm(45000, 5000),:);
% compdata(:,3073)=0;
b=find(totaldata(:,3073)==3);
compdata=totaldata(b,:);
compdata(:,3073)=0;
%merge bird and no-bird data
data=[birddata;compdata];
%split training data and test data
rng(0)
index=randperm(10000);
trainingSet=data(index(1:800),:)';
testSet=data(index(801:1000),:)';
trainingImages0=trainingSet(1:3072,:);
trainingLabels=trainingSet(3073,:);
testImages0=testSet(1:3072,:);
testLabels=testSet(3073,:);
%transform data to 4-D data
trainingImages=reshape(trainingImages0,32,32,3,800);
testImages=reshape(testImages0,32,32,3,200);
%virsulize the whole sample
figure
birdImages0=totaldata(:,1:3072)';
birdImages=reshape(birdImages0,32,32,3,50000);
sample=birdImages(:,:,:,1:100);
sample=imresize(sample,[64 64]);
montage(sample)
%virsulize the 2 classes sample
figure
sample=testImages(:,:,:,1:25);
sample=imresize(sample,[64 64]);
montage(sample)
%check if testImages and testLabes match
testLabels(1:100)






