import random

def sample_state(probability_true):
    t = random.random()
    if t < probability_true:
        return 1
    else:
        return 0

def normalize_weights(weight_list):
    total = 0
    for i in range(len(weight_list)):
        total += weight_list[i]
    for i in range(len(weight_list)):
        weight_list[i] = weight_list[i] / total
    return weight_list

def weight_particles(particles, evidence_t):
    temp = particles.copy()
    weight_list = particles
    if evidence_t == 0:
        for i in range(len(weight_list)):
            if weight_list[i] == 0:
                weight_list[i] = 1 - probability_ev_no_rain
            else:
                weight_list[i] = 1 - probability_ev_rain
    else:
        for i in range(len(weight_list)):
            if weight_list[i] == 0:
                weight_list[i] = probability_ev_no_rain
            else:
                weight_list[i] = probability_ev_rain
    weight_list = normalize_weights(weight_list)
    w0 = 0
    w1 = 0

    for i in range(len(particles)):
        if temp[i] == 0:
            w0 += weight_list[i]
        else:
            w1 += weight_list[i]
    return w0, w1

def pfUmbrella(numSamples, numSteps, evidence):
    particles = []
    for i in range(numSamples):
        particles.append(sample_state(.5))
    for j in range(1, numSteps):
        for i in range(len(particles)):
            if particles[i] == 0:
                particles[i] = sample_state(probability_rain_no_rain)
            else:
                particles[i] = sample_state(probability_rain_rain)
        w0, w1 = weight_particles(particles, evidence[j])
        for i in range(len(particles)):
            if particles[i] == 0:
                particles[i] = sample_state(w0)
            else:
                particles[i] = sample_state(w1)
    total = 0
    for i in range(len(particles)):
        total += particles[i]
    return total/numSamples

def find_variance(variance_samples, numSamples, numSteps, evidence):
    samples = []
    for i in range(variance_samples):
        samples.append(pfUmbrella(numSamples, numSteps, evidence))
    total = sum(samples)
    mean = float(total/len(samples))
    for i in range(len(samples)):
        samples[i] = (samples[i] - mean) ** 2
    new_total = sum(samples)
    variance = float(new_total/len(samples))
    return variance

probability_rain_rain = .7
probability_rain_no_rain = .3
probability_ev_rain = .9
probability_ev_no_rain = .2
evidence1 = [1, 1, 1, 1, 0, 0, 0, 0, 0, 0]
evidence2 = [0, 0, 0, 0, 0, 0, 0, 0, 1, 1]
evidence3 = [1, 0, 1, 0, 1, 0, 1, 0, 1, 0]
numSamples = 1000
numSteps = 10
using_evidence = evidence2
variance_samples = 100
print("Probability:",pfUmbrella(numSamples, numSteps, using_evidence))
print("Variance:", find_variance(variance_samples, numSamples, numSteps, using_evidence))
#evidence1 prob: .056
#evidence2 prob: .858
#evidence3 prob: .151