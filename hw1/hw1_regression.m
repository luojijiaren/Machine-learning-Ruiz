e=rng;
X=60+8*randn(1,1000);
f=@(x) 2*sin(1.5*x);
gama=randn(1,1000);
r=f(X)+gama;
Z=[X;r];
ind=randperm(1000);
training=Z(:,ind(1:600));
testing=Z(:,ind(601:1000));
figure;
plot(X,r)
plot(training(1,:),training(2,:))
plot(testing(1,:),testing(2,:))

x_tr=training(1,:);
y_tr=training(2,:);
for i=0:4
    polyfit(x_tr,y_tr,i)
end


