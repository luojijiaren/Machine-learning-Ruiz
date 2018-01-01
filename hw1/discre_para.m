function [ c ] = discre_para(X,y,x ) 
for i=1:3
    for j=1:1000
        if y(j)==i
            yi(j)=1;
        else yi(j)=0;   
        end
    end
    mi=sum(X.*yi)/sum(yi);
    si_sq=sum(((X-mi).^2).*yi)/sum(yi);
    pci=mean(yi);
    gi(x)=-log(abs(sqrt(si_sq)))-(x-mi).^2/(2*si_sq)+log(pci);
    gx(i)=gi(x);

end

for i=1:3
    if gx(i)== max(gx)
       c=i;
    end


    
end



