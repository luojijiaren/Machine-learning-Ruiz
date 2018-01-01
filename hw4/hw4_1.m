% hw4 HMM test

% Prof. Ruiz
clear;

% I took the following comments and commands from the Matlab help, and
% I applied the commands to the pepsi-coke example from the 
% tutorial slides used in class. See slide #14 of 
% http://webcourse.cs.technion.ac.il/236522/Spring2007/ho/WCFiles/Tutorial05.ppt

% GENERATING A TEST SEQUENCE

% The following commands create the transition and emission matrices for the model described in the 
% tutorial above. There are two states corresponding to the two sodas: 
% coke and pepsi. I made the emission of a state equal to the state.
% That is, the emission of the "coke" state (== 1), is 1 (== coke)
% and.    the emission of the "pepsi" state (== 2), is 2 (== pepsi)

TRANS = [.9 .1; .2 .8;];

EMIS = [1, 0 ; 0, 1];

% To generate a random sequence of states and emissions from the model, use hmmgenerate:

[seq,states] = hmmgenerate(10,TRANS,EMIS);

% seq

% states

% The output seq is the sequence of emissions and the output states is the sequence of states.

% hmmgenerate begins in state 1 at step 0, makes the transition to state i1 at step 1, and returns i1 as the first entry in states. 

% To change the initial state, see Changing the Initial State Distribution:
% To assign a different distribution of probabilities, p = [p1, p2, ..., pM], 

p = [.6, .4];

% to the M initial states, do the following:
% Create an M+1-by-M+1 augmented transition matrix and an M+1-by-N augmented emission matrix,  
% of the following form: 

TRANS_HAT = [0 p; zeros(size(TRANS,1),1) TRANS];

EMIS_HAT = [zeros(1,size(EMIS,2)); EMIS];


% TRANS_HAT 

% EMIS_HAT 

% Now you can do the generation (note that the state names will be incremented by 1).

[seq_HAT,states_HAT] = hmmgenerate(10,TRANS_HAT,EMIS_HAT);

% seq_HAT

% states_HAT

% Run this program several times to observe different sequence generations.
P = 2;
C = 1;
seqen = [P P P P C C P P P C C C P C C C C C P P P C P C P];
TRANS = [0 0.6 0.1 0.3; 0 0.2 0.1 0.7; 0 0.1 0.1 0.8;  0 0.4 0.3 0.3];
EMIS = [0 0; 0.6 0.4; 0.9 0.1; 0.5 0.5];
prd = 0.0;

for i = 1:1000
    [seq,states] = hmmgenerate(25,TRANS,EMIS);
    likelystates = hmmviterbi(seqen, TRANS, EMIS);
    prd = prd + sum(states==likelystates)/25;
end 

res = prd/1000  % result of probobility this sequence is generated by HMM

% the following transaction without start state:
TRANS2 = [0.2 0.1 0.7; 0.1 0.1 0.8; 0.4 0.3 0.3];
EMIS2 = [0.6 0.4; 0.9 0.1; 0.5 0.5];
[seq,states] = hmmgenerate(25,TRANS2,EMIS2);
[TRANS_EST, EMIS_EST] = hmmestimate(seqen, states);
[TRANS_EST2, EMIS_EST2] = hmmtrain(seqen, TRANS_EST, EMIS_EST);

% estimate the state probability
testsq = [C P C]
[PSTATES,logpseq] = hmmdecode(testsq,TRANS,EMIS);
seqen
PSTATES
% logpseq