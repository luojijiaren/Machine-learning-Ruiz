% % Download CIFAR-10 data to a temporary directory
% cifar10Data = tempdir;
% 
% url = 'https://www.cs.toronto.edu/~kriz/cifar-10-matlab.tar.gz';
% 
% helperCIFAR10Data.download(url, cifar10Data);
% 
% % Load the CIFAR-10 training and test data.
% [trainingImages, trainingLabels, testImages, testLabels] = helperCIFAR10Data.load(cifar10Data);
% p1=find(trainingLabels=='airplane');
% p2=find(trainingLabels=='ship');
% trainingLabels0=trainingLabels([p1; p2]);
% trainingImages0=trainingImages(:,:,:,[p1; p2]);
% p3=find(testLabels=='airplane');
% p4=find(testLabels=='ship');
% testLabels0=(testLabels([p3; p4]));
% testImages0=testImages(:,:,:,[p3; p4]);

% Create the image input layer for 32x32x3 CIFAR-10 images
[height, width, numChannels,~] = size(trainingImages);

imageSize = [height width numChannels];
inputLayer = imageInputLayer(imageSize);
tic;
%Convolutional lay parameters we can use to experiments latter
filterSize=[5 5];
numFilters=32;

middleLayers=[
    convolution2dLayer(filterSize,numFilters,'Padding',2)
    reluLayer()  
    maxPooling2dLayer(3,'Stride',2)
    
    convolution2dLayer(filterSize,numFilters,'Padding',2)
    reluLayer()
    maxPooling2dLayer(3,'Stride',2)
   
    convolution2dLayer(filterSize,2*numFilters,'Padding',2)
    reluLayer()
    
    maxPooling2dLayer(3,'Stride',2)
    ]
finalLayers = [
    fullyConnectedLayer(32)
    reluLayer
    
    fullyConnectedLayer(2)
    softmaxLayer
    classificationLayer
    ]
layers=[
    inputLayer
    middleLayers
    finalLayers
    ]
rng(1234)
layers(2).Weights=0.0001*rand([filterSize numChannels numFilters]);
layers(2).Bias=0.01*ones(1,1,[numFilters]);
% Set the network training options
% Set the network training options
opts = trainingOptions('sgdm','Verbose', true);
trainingLabels=categorical(trainingLabels);

cifar2Net = trainNetwork(trainingImages, trainingLabels, layers, opts);

% doTraining = true;
% 
% if doTraining
%     % Train a network.
%     
% else
%     % Load pre-trained detectorfor the example.
%     load('rcnnStopSigns.mat','cifar10Net');
% end

% cifar2Net = trainNetwork(trainingImages, trainingLabels, layers, opts);
% 
% doTraining = false;

% if doTraining
%     % Train a network.
%     cifar10Net = trainNetwork(trainingImages, trainingLabels, layers, opts);
% else
%     % Load pre-trained detector for the example.
%     load('rcnnStopSigns.mat','cifar10Net')
% end

YTest = classify(cifar2Net, testImages);
% yhat=zeros(size(YTest));
% yhat(find(YTest=='bird'))=2;
% yhat(find(YTest=='cat'))=3;
testLabels2=categorical(testLabels);
% Calculate the accuracy.
% hist(YTest,unique(YTest))
% hist(yhat,unique(yhat))

con=confusionmat(YTest,testLabels2)
accuracy=sum(diag(con))/length(testLabels2)  
t=toc
prediction=con(1,1)/sum(con(:,1))
recall_value=con(1,1)/sum(con(1,:))


    
    