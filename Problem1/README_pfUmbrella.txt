pfUmbrella implements a particle filtering algorithm in order to calculate P(Rain10|e). In order to find the probability, it creates a number of particles that iterate through the provided evidence array. Each iteration, it updates each particle according to the probability updates for the problem, then re-samples them according to the evidence array provided to the problem. After doing it up to Rain10, it returns the proportion of particles that are True, giving an accurate estimation of P(Rain10|e)

To run the code, load it into your favorite python compiler and simply run, the provided script will do the rest

If you with to run just the pfUmbrella function, run:
	pfUmbrella(numSamples, numSteps, evidence)
The three evidence arrays given for the homework are available as:
	-evidence1
	-evidence2
	-evidence3

If you wish to change the numSamples or numSteps, you can alter the variables:
	-numSamples
	-numSteps

If you wish to alter the number of samples for calculating the variance, you can change the variable:
	-variance_samples

