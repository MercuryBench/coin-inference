function p = probAMarkov(initial, A_proc, A_next, NSim)	
% uses a Monte Carlo simulation to obtain an approximation of the probability of the event A
% given a nbits-bits memory Markov chain as a generator. nbits is the number of columns of A_proc
% initial is the first bits that have no full memory history by themselves yet: 
% e.g. for 3 bits memory the first 3 bits (or less for a shorter input) in the input string

% returns the logarithmic probability!

probA = ones(NSim, 1);

% catch the case where there are not enough input bits at all to match the required memory
% i.e. input is shorter than the memory specified


% the following if-block is only executed if there is actual memory-relying input, 
% i.e. input where there are bits which have a history with the specified memory bit number
if size(A_proc, 1) != 0
N = size(A_proc, 1);
nbits = size(A_proc, 2);

weights = 2.^((nbits-1):-1:0)';	% weights for binary numbering
indices = A_proc*weights + 1;
A_next_inv = 1-A_next;
params_regular = unifrnd(0, 1, 2^nbits, NSim);	% Monte Carlo: generate random transition probabilities

pars = params_regular(:, :);
pars_inv = 1-pars;
prob_next_0 = pars(indices, :);	% probability that the next character is a 0 for any row in A_proc
prob_next_1 = 1-prob_next_0;	% next character is a 1

% now calculate actual probability using the knowledge what the next character is (stored in A_next)
prob = prob_next_0.*repmat(A_next_inv, 1, NSim) + prob_next_1.*repmat(A_next, 1, NSim);

% those numbers will be small, so instead of multiplying them, we add their logarithmic values
probA = exp(sum(log(prob), 1))';

end % if size(A_proc, 1) == 0


% now take care of the first bits before a full memory history is achieved: 
% this number is the minimum of nbits and the actual number of input bits

% for this we need to consider "initial markov probabilities" like
% P(0), P(0|0) etc.
numfirstbits = length(initial);

for l=1:numfirstbits
% initialize random weights for the initial phase
paramsInit{l} = unifrnd(0, 1, 2^(l-1), NSim);
end

probInit = zeros(NSim, 1);


prob2 = zeros(numfirstbits, NSim);
for l=1:numfirstbits
if (l == 1)
weights = 1;
indices = 1;
else
weights = 2.^((l-2):-1:0)';	% weights for binary numbering
indices = initial(1:l-1)*weights + 1;
end
pars = (paramsInit{l})(:, :);
pars_inv = 1-pars;
prob_next_0 = pars(indices, :);	% probability that the next character is a 0 for any row in A_proc
prob_next_1 = 1-prob_next_0;	% next character is a 1
prob2(l, :) = prob_next_0.*(1-initial(l)) + prob_next_1.*initial(l);
end
probInit = prod(prob2, 1)';


p = log(1/NSim*sum(probA.*probInit));	% return logarithmic probability consisting of initial probabilities and "regular case" probabilities

end
