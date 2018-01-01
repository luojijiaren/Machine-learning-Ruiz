diary('Fangling_Zhang_diary.txt')
clc;clear;close

TRANS = [0 0.4 0.1 0.5; 0 0.3 0.5 0.2; 0 0.2 0.2 0.6;  0 0.7 0.1 0.2];
EMIS = [0; 1; 1; 1];
STATES=[];
rng(1)
for i=1:100,
    [seq,states] = hmmgenerate(1000,TRANS,EMIS,'Statenames',{'start','S1','S2','S3'});
    STATES=[STATES;states];
end

SEQ=ones(size(STATES));
TR_sum=zeros(size(TRANS));EM_sum=zeros(size(EMIS));
for i=1:100,
    
    seq=SEQ(i,:);states=STATES(i,:);
    [TR_temp,EM_temp] = hmmestimate(seq,states,'Statenames',{'start','S1','S2','S3'})
    TR_sum=TR_sum+TR_temp;      
    EM_sum=EM_sum+EM_temp;
end
TR=TR_sum/100
EM=EM_sum/100


    [PSTATES,logpseq] = hmmdecode(seq,TR,EM,'Statenames',{'start','S1','S2','S3');
    p=exp(logpseq)


