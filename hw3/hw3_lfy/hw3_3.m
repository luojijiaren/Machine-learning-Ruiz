% Fangyu Lin
% CS539 HW3 
% Mar/28/2017
% Support Vector Machine Model
%========================

load fisheriris

% y1 = adult(:,15);
% 
% xd = meas(51:end,[4,2]);
% group = species(51:end);
% figure;
% svmStruct = svmtrain(xd, group, 'ShowPlot', true);

% inds = ~strcmp(species,'setosa');
% X1 = meas(inds,3:4);
% y1 = species(inds);
% svmM = fitcsvm(X1,y1);
% 
% kModel = crossval(svmM, 'KFold', 10);
% svmLoss = kfoldLoss(kModel);
% 
% sv1 = svmM.SupportVectors;
% figure
% gscatter(X1(:,1),X1(:,2),y1)
% hold on
% plot(sv1(:,1),sv1(:,2),'ko','MarkerSize',10)
% legend('versicolor','virginica','Support Vector')
% hold off

xdata = meas(51:end,3:4);            % need to discuss diferent kinds of features conbimation
X = cell2mat(adult(1:2000,[13,5]));  % this one can be replaced by [1,3,5,11,12,13] indexing
group = species(51:end);
Y = adult(1:2000,15);  % the target result
svmStruct = svmtrain(X,Y,'ShowPlot',true,'kernel_function','rbf','rbf_sigma',1.0,'kernelcachelimit',20000); % because it can only show 2D, there are two features each time
% the rbf sigma value can be changed to find a best fit


% X = meas(:,[1,4]);
% y = ones(size(X,1),1); 
% 
% rng(1);
% SVMModel = fitcsvm(X,y,'KernelScale','auto','Standardize',true,...
%     'OutlierFraction',0.005);
% 
% svInd = SVMModel.IsSupportVector;
% h = 0.02; % Mesh grid step size
% [X1,X2] = meshgrid(min(X(:,1)):h:max(X(:,1)),...
%     min(X(:,2)):h:max(X(:,2)));
% [~,score] = predict(SVMModel,[X1(:),X2(:)]);
% scoreGrid = reshape(score,size(X1,1),size(X2,2));
% 
% figure
% plot(X(:,1),X(:,2),'k.')
% hold on
% plot(X(svInd,1),X(svInd,2),'ro','MarkerSize',10)
% contour(X1,X2,scoreGrid)
% colorbar;
% title('{\bf Iris Outlier Detection via One-Class SVM}')
% xlabel('Sepal Length (cm)')
% ylabel('Sepal Width (cm)')
% legend('Observation','Support Vector')
% hold off