rootFolder = fullfile('catg');
categories = {'bird', 'cat'};
imds = imageDatastore(fullfile(rootFolder, categories), 'LabelSource', 'foldernames');


% Notice that each set now has exactly the same number of images.
countEachLabel(imds)

% Find the first instance of an image for each category
% bird = find(imds.Labels == 'airplanes', 1);
% ferry = find(imds.Labels == 'ferry', 1);
% laptop = find(imds.Labels == 'laptop', 1);
% 
% figure
% subplot(1,3,1);
% imshow(readimage(imds,airplanes))
% subplot(1,3,2);
% imshow(readimage(imds,ferry))
% subplot(1,3,3);
% imshow(readimage(imds,laptop))
imds.ReadFcn = @(filename)readAndPreprocessImage(filename);

rng(231)
[trainingSet, testSet] = splitEachLabel(imds, 0.3, 'randomize');

net = alexnet()
% Get the network weights for the second convolutional layer
w1 = net.Layers(2).Weights;

% Scale and resize the weights for visualization
w1 = mat2gray(w1);
w1 = imresize(w1,5);
lay=char('conv2', 'conv3', 'conv4', 'conv5' ,'fc6' ,'fc7', 'fc8');
lay=cellstr(lay);
minib=[8 16 32];
% % Display a montage of network weights. There are 96 individual sets of
% % weights in the first layer.
% figure
% montage(w1)
% title('First convolutional layer weights')
accuracy=0;
result=[];
result_temp=[];
for i=1:length(lay)
    for j=1:length(minib)
  
            tic;
            featureLayer = char(lay(i));
            trainingFeatures = activations(net, trainingSet, featureLayer, ...
                'MiniBatchSize', minib(j), 'OutputAs', 'columns');
            % Get training labels from the trainingSet
            trainingLabels = trainingSet.Labels;

            % Train multiclass SVM classifier using a fast linear solver, and set
            % 'ObservationsIn' to 'columns' to match the arrangement used for training
            % features.
            classifier = fitcecoc(trainingFeatures, trainingLabels, ...
                'Learners', 'linear', 'Coding', 'onevsall', 'ObservationsIn', 'columns');
            % Extract test features using the CNN
            testFeatures = activations(net, testSet, featureLayer, 'MiniBatchSize',minib(j));

            % Pass CNN image features to trained classifier
            predictedLabels = predict(classifier, testFeatures);

            % Get the known labels
            testLabels = testSet.Labels;

            % Tabulate the results using a confusion matrix.
            confMat = confusionmat(testLabels, predictedLabels);

            % Convert confusion matrix into percentage form
            confMat = bsxfun(@rdivide,confMat,sum(confMat,2))
            accuracy1=sum(diag(confMat))/2
            t=toc;
            result_temp=[lay(i) minib(j) t accuracy1]
            result=[result;result_temp];
            if accuracy1>accuracy
                            accuracy=accuracy1;

            end
                       
    end
end
result
accuracy
                                