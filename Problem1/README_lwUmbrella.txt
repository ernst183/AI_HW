lwUmbrella implements a likelihood weighting algorithm in order to calculate P(Rain10|E). In order to find the probability, it takes an n number of samples (specified when the function is called).  For each of these samples, it weights them according to their likelihood according to the provided evidence. It then compiles all of these into a probability by normalizing the weights and adding together the weights of all of the samples that have R10 = True. 

To run the code, load it into your favorite python compiler and simply run, the provided script will do the rest

If you with to run just the lwUmbrella function, run:
	lwUmbrella(numSamples, numSteps, evidence)
The three evidence arrays given for the homework are available as:
	-evidence1
	-evidence2
	-evidence3

If you wish to change the numSamples or numSteps, you can alter the variables:
	-numSamples
	-numSteps

If you wish to alter the number of samples for calculating the variance, you can change the variable:
	-variance_samples

