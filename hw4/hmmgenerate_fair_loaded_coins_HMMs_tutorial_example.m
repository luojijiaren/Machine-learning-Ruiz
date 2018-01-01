% Prof. Ruiz

clear; close;

%% I took the following comments and commands from the Matlab help, and
%% I applied the commands to the fair-loaded coin example from the 
%% tutorial slides used in class. See slide #14 of 
%% http://webcourse.cs.technion.ac.il/236522/Spring2007/ho/WCFiles/Tutorial05.ppt

% GENERATING A TEST SEQUENCE

% The following commands create the transition and emission matrices for the model described in the 
% tutorial above. There are two states corresponding to two coins: 
% The first coin is fair (1/2, 1/2) and the 2nd coin is loaded (3/4, 1/4). 
% The probability of flipping the same coin on times t and t+1 is 0.9, and 
% the probability of changing from one coin to the other from time t to t+1 is 0.1.

TRANS = [.9 .1; .1 .9;];

EMIS = [1/2, 1/2;...
3/4, 1/4];


% To generate a random sequence of states and emissions from the model, use hmmgenerate:

[seq,states] = hmmgenerate(20,TRANS,EMIS);

seq

states

% The output seq is the sequence of emissions and the output states is the sequence of states.

% hmmgenerate begins in state 1 at step 0, makes the transition to state i1 at step 1, and returns i1 as the first entry in states. 

% To change the initial state, see Changing the Initial State Distribution:
% To assign a different distribution of probabilities, p = [p1, p2, ..., pM], 


p = [2/3, 1/3];

% to the M initial states, do the following:
% Create an M+1-by-M+1 augmented transition matrix and an M+1-by-N augmented emission matrix,  
% of the following form: 

TRANS_HAT = [0 p; zeros(size(TRANS,1),1) TRANS];

EMIS_HAT = [zeros(1,size(EMIS,2)); EMIS];


TRANS_HAT 

EMIS_HAT 

% Now you can do the generation (note that the state names will be incremented by 1).

[seq_HAT,states_HAT] = hmmgenerate(20,TRANS_HAT,EMIS_HAT);

seq_HAT

states_HAT


% Run this program several times to observe different sequence generations.

