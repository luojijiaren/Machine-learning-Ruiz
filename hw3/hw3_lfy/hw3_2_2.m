load fisheriris

[x,t] = iris_dataset;
net = patternnet(2);
net = train(net,optdigits,optdigits_test);
view(net)
y = net(optdigits);
perf = perform(net,optdigits_test,y);
classes = vec2ind(y);
