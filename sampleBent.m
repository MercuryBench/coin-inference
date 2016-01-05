function w = sampleBent(p, N)
	% samples a bent coin's N tosses with bentness parameter p and writes them in a string
	vv = unifrnd(0, 1, 1, N);
	vv = (vv < 0.6);
	w = "";
	for k=1:length(vv)
		w = strcat(w, num2str(vv(k)));
	end
end
