function probA = probAMarkov(A_proc, A_next, NSim)	
% uses a Monte Carlo simulation to obtain an approximation of the probability of the event A
% given a nbits-bits memory Markov chain as a generator. nbits is the number of columns of A_proc

% returns the logarithmic probability!

N = size(A_proc, 1);
nbits = size(A_proc, 2);

weights = 2.^((nbits-1):-1:0)';	% weights for binary numbering
indices = A_proc*weights + 1;
A_next_inv = 1-A_next;
params = unifrnd(0, 1, 2^nbits, NSim);	% Monte Carlo: generate random transition probabilities
probA = 0;
for k=1:NSim
pars = params(:, k);
pars_inv = 1-pars;
prob_next_0 = pars(indices);	% probability that the next character is a 0 for any row in A_proc
prob_next_1 = 1-prob_next_0;	% next character is a 1

% now calculate actual probability using the knowledge what the next character is (stored in A_next)
prob = prob_next_0.*A_next_inv + prob_next_1.*A_next;

% prob is now a column vector. Each row contains the probability of some succession of bits 
% (using the sampled Markov transition probabilities)

% those numbers will be small, so instead of multiplying them, we add their logarithmic values
probA = probA + exp(sum(log(prob))); 
end
probA = log(1/NSim*probA);	% return logarithmic probability
end
