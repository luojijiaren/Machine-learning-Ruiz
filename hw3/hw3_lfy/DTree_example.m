% Fangyu Lin
% CS539 DT example
% Mar/23/2017
%========================

clear ALL;
clc;

load carsmall
vars = {'MPG' 'Cylinders' 'Horsepower' 'Model_Year'};
x = [MPG Cylinders Horsepower Model_Year];  %# mixed continous/discrete data
y = cellstr(Origin);                        %# class labels

t = fitctree(x, y, 'PredictorNames',vars, ...
    'CategoricalPredictors',{'Cylinders', 'Model_Year'}, 'Prune','off');
view(t, 'mode','graph')

% y_hat = predict(t, x);
% cm = confusionmat(y,y_hat);
% 
% tt = prune(t, 'Level',3);
% view(tt)
% 
% predict(tt, [22 4 90 76])