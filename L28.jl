using Plots, Distributions, StatsPlots, Random

Random.seed!(61801)

pop = rand(Normal(100, 10), 1000)

samp10 = sample(pop, 10, replace = false)
samp100 = sample(pop, 100, replace = false) 

samp10_means = [sample(samp10, 10, replace = true) for _ in 1:10^4]
samp100_means = [sample(samp100, 100, replace = true) for _ in 1:10^4]

density(mean.(samp10), c = :black)
vline!([mean(pop)], line = :dash, c = :grey)

density(mean.(samp100), c = :black)
vline!([mean(pop)], line = :dash, c = :grey)