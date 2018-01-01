% Fangyu Lin
% CS539 HW3 
% Mar/29/2017
% ANN Model test
%=======================

clear ALL;
clc;

net = feedforwardnet(2);
[net, tr] = train(net, optdigits, optdigits_test(65:72,:));

% [trainImages,~,trainAngles] = optdigits;
% numTrainImages = size(optdigits,8);

% figure
% idx = randperm(numTrainImages,20);
% for i = 1:numel(idx)
%     subplot(4,5,i)
% 
%     imshow(trainImages(:,:,:,idx(i)))
%     drawnow
% end

% layers = [ ...
%     imageInputLayer([8 8 1])
%     convolution2dLayer(12,25)
%     reluLayer
%     fullyConnectedLayer(2)
%     regressionLayer];
% 
% options = trainingOptions('sgdm','InitialLearnRate',0.001,'MaxEpochs',15);
% net = feedforwardnet(2);
% [net, tr] = train(net, optdigits, optdigits_test(65:72,:));
