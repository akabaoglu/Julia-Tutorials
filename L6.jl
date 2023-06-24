using Plots, StatsPlots, Distributions, Statistics

dat = rand(Normal(9.3, 2.7), 10^4)

grid_m, grid_s = 9:0.001:10, 2:.01:3

log_lik = [sum(log.(pdf.(Normal(i, j), dat))) for i in grid_m, j in grid_s]

heatmap(grid_s, grid_m, log_lik, c = cgrad(:default, [.99]))