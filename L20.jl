using Plots, Distributions, StatsPlots, StatsBase

samples = rand(Binomial(10^6, 10^-3), 10^6)

proportions(samples)

bar(minimum(samples):maximum(samples), proportions(samples), lw = 0, c = :navyblue, label = :none)
plot!(Normal(1000, 1000*sqrt(10^-3*(1-10^-3))), c = :salmon, label = :none)