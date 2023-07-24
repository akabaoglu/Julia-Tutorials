using Distributions, Plots, StatsPlots

dists = map(x -> TDist(x), 2:2:10)

plot(dists, label = reshape(string.(collect(2:2:10)), 1, 5), xlim = (-5, 5))
plot!(Normal(), label = "Gaussian", c = :grey, line = :dash)