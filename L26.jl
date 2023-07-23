using Plots, Distributions, StatsPlots

grid = 0:.01:5

pars = eachrow([round.(Int, rand(Normal(10000, 2500), 5)) round.(Int, rand(Normal(10, 5), 5))])

dists = map(x -> FDist(x...), pars)

plot(grid, [map(x -> pdf(i, x), grid) for i in dists], label = reshape(string.("N = ", first.(pars), ", ", "# of Parameters = ", last.(pars)), 1, 5))