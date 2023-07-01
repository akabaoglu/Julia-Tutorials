using Plots, Distributions

prior = Beta(10, 15)
likelihood = Beta(23, 17)
posterior = Beta(33, 32)

plot(prior, label = "Prior", c = :navyblue, line = :dash)
plot!(likelihood, label = "Likelihood", c = :tomato2, line = :dash)
plot!(posterior, label = "Posterior", c = :red, line = :purple)