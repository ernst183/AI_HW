import random

def normalize_dict(dict):
    total_value = 0
    for i in dict.keys():
        total_value += dict[i]
    for i in dict.keys():
        dict[i] /= total_value
    return dict

def sample_state(probability_true):
    t = random.random()
    if t < probability_true:
        return 1
    else:
        return 0

def weighted_sample(nodes_to_sample, evidence):
    w = 1
    for i in range(0, 10):
        if i == 0:
            nodes_to_sample[i] = sample_state(.5)
        else:
            if(nodes_to_sample[i-1] == 1):
                nodes_to_sample[i] = sample_state(probability_rain_rain)
            else:
                nodes_to_sample[i] = sample_state(probability_rain_no_rain)
    for i in range(0, 10):
        if nodes_to_sample[i] == 1 and evidence[i] == 1:
            w *= probability_ev_rain
        elif nodes_to_sample[i] == 1 and evidence[i] == 0:
            w *= 1 - probability_ev_rain
        elif nodes_to_sample[i] == 0 and evidence[i] == 1:
            w *= probability_ev_no_rain
        elif nodes_to_sample[i] == 0 and evidence[i] == 0:
            w *= 1 - probability_ev_no_rain
    return nodes_to_sample, w


def lwUmbrella(numSamples, numSteps, evidence):
    W_x = dict()
    rain_nodes = [-1, -1, -1, -1, -1, -1, -1, -1, -1, -1]
    for i in range(0, numSamples):
        x, w = weighted_sample(rain_nodes, evidence)
        x_hash = 0
        for i in range(0, len(x)):
            x_hash += x[i]*pow(10, i)
        if x_hash in W_x.keys():
            W_x[x_hash] += w
        else:
            W_x[x_hash] = w
    W_x = normalize_dict(W_x)
    total_p = 0
    for i in W_x.keys():
        if i >= 1000000000:
            total_p += W_x[i]
    return total_p

def find_variance(variance_samples, numSamples, numSteps, evidence):
    samples = []
    for i in range(variance_samples):
        samples.append(lwUmbrella(numSamples, numSteps, evidence))
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
print("Probability:", lwUmbrella(numSamples, numSteps, using_evidence))
print("Variance:", find_variance(variance_samples, numSamples, numSteps, using_evidence))




