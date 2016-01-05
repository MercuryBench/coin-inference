# coin-inference
Interpretes a string 01001000111... as a result of a coin toss and decides whether it comes from a fair coin, a bent coin or a human faking a coin toss.

Implementation in octave (should work in Matlab, though)

Run demo.m for a functionality demonstration: Input a sequence of 0s and 1s after prompt (at least 10 digits long, doesn't normally need more than 150 digits) to let the algorithm decide whether the input comes from a bent coin, a fair coin or a human generator.

The algorithm applies Bayesian Occam's razor: If the result is slightly "bent", for example "0100", the algorithm will still settle for "fair coin" as the result can more easily be explained by a fair coin than by a bent coin although the result does appear to be unbalanced.

The math behind the algorithm is explained in the doc-file of https://github.com/mdbenito/ModelSelection.
To test the "human generator hypothesis", the normalization of the measure $P(.|H) = \int P(.|par, H) \cdot P(par|H) d(par)$ is done via a simple Monte Carlo simulation.

The octave scripts sampleFair.m and sampleBent.m generate pseudorandom strings of 0s and 1s distributed according to a bent or fair coin. So you can run them and copy&paste the result into the prompt of demo if you want to.
