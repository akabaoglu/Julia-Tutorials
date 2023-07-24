using Distributions, Statistics, Plots

X = rand(Uniform(-100, 100), 10^3)
Y = (1.3 .* X) .+ rand(Normal(0, 50), 10^3)

grid_m = .5:.01:2
grid_s = 1:1:100

logLik = [sum([log.(pdf.(Normal(m*X[i], s), Y[i])) for i in 1:10^3]) for m in grid_m, s in grid_s]

indexin(maximum(logLik), logLik)

grid_m[80]
grid_s[51]

surface(grid_s, grid_m, logLik, camera = (200, 30))