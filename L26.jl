using Plots, Distributions, StatsPlots

grid = 0:.01:5

plot(grid, pdf.(FDist(9900, 99), grid), c = :red)
plot!(grid, pdf.(FDist(95, 4), grid), c = :blue)
plot!(grid, pdf.(FDist(7, 2), grid), c = :limegreen, legend = :none)