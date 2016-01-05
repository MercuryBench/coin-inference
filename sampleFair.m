function w = sampleFair(N)
	% samples a fair coin's N tosses and writes them in a string
	vv = unidrnd(2, 1, N)-1;
	w = "";
	for k=1:length(vv)
		w = strcat(w, num2str(vv(k)));
	end
	w
end
