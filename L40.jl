using Distributions, Plots, Loess, StatsBase, Random

Random.seed!(12345)

pop = rand(Normal(100, 10), 1000)

ssize = repeat(10:10:500, inner = 1000)

means = [mean(sample(pop, i, replace = false)) for i in ssize]

diffs = [mean(abs.(last.(filter(x -> x[1] == i, eachrow(hcat(ssize, means)))) .- mean(pop))) for i in 10:10:500]

scatter(10:10:500, diffs, ms = 3, msw = 0, label = :none)
plot!(10:10:500, predict(loess(10:10:500, diffs), 10:10:500), c = :firebrick2, label = "Loess Curve", xlab = "Sample Size", ylab = "Absolute Mean Error")