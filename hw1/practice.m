j=rng;
a=normrnd(60,8,1,1000); %a=60+8*randn(1,1000);
m=1/1000*sum(a);
s=sqrt(sum((a-m).^2)/1000)
phat=mle(a)

N=1000;beta=3;mu0=60;beta0=3;
bayes=m*(N/beta^2)/(N/beta^2+1/beta0^2)+mu0*(1/beta0^2)/(N/beta^2+1/beta0^2)

k=rng;
X1=normrnd(60,8,1,500);
X2=normrnd(30,12,1,300);
X3=normrnd(80,4,1,200);
X=[X1,X2,X3];
y=[ones(1,500),ones(1,300)*2,ones(1,200)*3];

x=50
c=discre_para(X,y,x)

c

z=[X;y]

u=rng;
ind = randperm(1000);
train = z(:, ind(1:600));
test = z(:, ind(601:1000));
yhat=zeros(1,400)
accuracy=0
confusion=zeros(3,3);
for i=1:400
    yhat(i)=discre_para(X,y,int16(test(1,i)))
    confusion(yhat(i),test(2,i))=confusion(yhat(i),test(2,i))+1;
    if yhat(i)==test(2,i)
        accuracy=accuracy+1;
    end
end
accuracy/400
confusion


    


    
            

    
    




    



