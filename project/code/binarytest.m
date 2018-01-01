


[height, width, numChannels,~] = size(trainingImages);
imageSize = [height width numChannels];
inputLayer = imageInputLayer(imageSize);
trainingLabels=categorical(trainingLabels);
accuracy=0;
result=[];
result_temp=[];
load('C:\Users\fzhan\Documents\GitHub\Machine-learning-Ruiz\project\w72..mat')

            for epochs=1:50                     
               
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
                        layers(2).Weights=w;
                        layers(2).Bias=0.01*ones(1,1,[numFilters]);
                        % Set the network training options
                        opts = trainingOptions('sgdm', ...
                            'MaxEpochs', epochs, ...
                            'Verbose', true);
%                             'Momentum', 0.9, ...
%                             'InitialLearnRate', rate, ...
%                             'LearnRateSchedule', 'piecewise', ...
%                             'LearnRateDropFactor', 0.1, ...
%                             'LearnRateDropPeriod', 8, ...
%                             'L2Regularization',0.004 , ...

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

                        con=confusionmat(YTest,testLabels2);
                        accuracy1=sum(diag(con))/length(testLabels2)
                        t=toc;
                        result_temp=[epochs t accuracy1] 
                        result=[result;result_temp]                       
%                         if accuracy1>accuracy
%                             accuracy=accuracy1;
% 
%                         end
                                
                            
                    end
  
% 
% result
% accuracy


