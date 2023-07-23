using Plots, Distributions, GLM, DataFrames

dat = transform(DataFrame(X = rand(Normal(100, 5), 100)), :X => ByRow(x -> 55 + .3*x) => :Y)

sims = [[coeftable(lm(@formula(Y ~ X), transform(DataFrame(X = rand(Normal(100, 5), j)), :X => ByRow(x -> 55 + i*x + rand(Normal(0, 25))) => :Y))).cols[4][2] for i in .1:.1:2, j in 125:125:500] for _ in 1:10^4]

sims_ordered = [[sims[i][x, y] for i in 1:100] for x in 1:20, y in 1:4]

sim_means = mean.(sims_ordered)

plot(.1:.1:2, eachrow(sim_means'), labels = ["125" "250" "375" "500"])
hline!([.05], c = :red, line = :dash, label = "Level = .05")