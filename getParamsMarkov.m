function pars = getParamsMarkov(A_proc, A_next)	
	% get the optimal parameters for a nbits-bit memory Markov process to match the given A_proc/A_next
	N = size(A_proc, 1);
	nbits = size(A_proc, 2);
	counter = zeros(2^nbits, 2);

	weights = 2.^((nbits-1):-1:0)';	% weights for binary numbering
	indices = A_proc*weights + 1;

	for k=1:length(A_next)
		index = indices(k);
		if A_next(k) == 0
			counter(index, 1) = counter(index, 1) + 1;
		else
			counter(index, 2) = counter(index, 2) + 1;
		end
	end
	pars = zeros(8, 1);
	for k=1:8
		if sum(counter(k, :)) == 0
			pars(k) = 0.5;
		else
			pars(k) = counter(k, 1)/(counter(k, 1) + counter(k, 2));
		end
	end
end
