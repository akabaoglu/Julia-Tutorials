using Plots, Distributions, StatsPlots, Statistics

grid = 150:350

n_dens = map(x -> pdf(Normal(250, sqrt(250)), x), grid)
p_dens = map(x -> pdf(Poisson(250), x), grid)

plot(grid, n_dens - p_dens)