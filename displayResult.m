function [] = displayResult(prob, pars, p, nbits)
printf("Result of the analysis: Probability for\n");
printf("\tfair coin:\t%f\n", prob(1));
printf("\tbent coin:\t%f\n", prob(2));
printf("\thuman:\t\t%f\n", prob(3));

printf("\nbest fitting bentness parameter:\n");
printf("P(0) = %f", p);

printf("\nbest fitting human transition probabilities:\n");
printParams(pars, nbits);
end
