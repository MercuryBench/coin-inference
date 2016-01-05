clear();
nbits = 3;	% number of memory bits
NSim = 100000;	% number of Monte Carlo simulations

inp = input("input random string: ", "s");
% process string to number array
for k=1:length(inp)
A(k) = str2num(inp(k));
end

%A = unidrnd(2, 1, 150)-1;

N = length(A);	% length of input
K = N-sum(A);	% number of 0s
KInit = nbits - sum(A(1:nbits));	% number of 0s in first nbits bits
% Warning: We ignore the first nbits bits in each hypothesis to make the probabilities comparable
% If we want to incorporate the first bits in the "markov" hypothesis, we need to model parameters
% P(0), P(1), P(0|0), P(0|1), ... , P(1|11), ... etc. until for the first time nbits bits are in the history.


% A_proc contains every sequence of [nbits] bits memory, one at each row
% A_next contains the subsequent element for every sequence, i.e. for 
% A = ... 0 1 0 0 1 ..., there is a row 1 0 0 in A_proc and an element 1 in A_next at the same index

% these variables help to quicker calculate likelihoods and such.

% Example of A, A_proc and A_next for nbits=3:
% A = 1 0 1 1 1 0
% A_proc = 	1 0 1
%		0 1 1
%		1 1 1
%	
% A_next = 	1
%		1
%		0	


% process A to have all nbits-tupels in rows, save in A_proc
A_proc = zeros(length(A)-nbits, nbits);
for k=1:size(A_proc, 1)
A_proc(k, :) = A(k:k+2);
end;
% next-step-results (fitting A_proc)
A_next = A(nbits+1:end)';


% get Markov parameters
pars = getParamsMarkov(A_proc, A_next);

% now compare the logarithmic likelihoods of all hypotheses:
% we calculate everything in logarithmic quantities to avoid rounding off errors
logprob(1) = (N-nbits)*log(0.5);
sumterms1 = [1:(N-nbits+1)];		% ignore first nbits bits
sumterms2 = [1:(K-KInit),1:(N-nbits-K+KInit)];	% ignore first nbits bits
logprob(2) = sum(-log(sumterms1))+sum(log(sumterms2));
logprob(3) = probAMarkov(A_proc, A_next, NSim);

prob = exp(logprob);
prob = prob/sum(prob);

displayResult(prob, pars, K/N, nbits);
