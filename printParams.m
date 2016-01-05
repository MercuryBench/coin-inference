function printParams(params, nbits)
	labelfnc = @(k) sprintf(dec2bin(k-1, nbits));
	for k=1:2^nbits
		printf("P(0|%s) = %f\n", labelfnc(k), params(k));
	end
end
