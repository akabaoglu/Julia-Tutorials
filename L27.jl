using Plots, Distributions, GLM, DataFrames, Random

Random.seed!(12345)

X = rand(Normal(10, 5), 100)
Y = 15 .+ 5X + rand(Normal(0, 100), 100)

m1 = lm(@formula(DV ~ IV), DataFrame(DV = Y, IV = X))

plot(-5:.1:15, 1 .- [coeftable(lm(@formula(DV ~ IV), DataFrame(DV = Y .- i*X, IV = X))).cols[4][2] for i in -5:.1:15], c = :black)
vline!(confint(m1)[2,:], color = :darkgrey, line = :dash, legend = :none)