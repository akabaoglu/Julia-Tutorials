using Distributions, StatsPlots

par_norm = rand(Normal(50,10), 10^5)
samp_norm = [rand(Poisson(x), 1000) for x in par_norm]
samp_col = vcat([samp_norm[i] for i in 1:100]...)

par_unif = rand(Uniform(0, 100), 10^5)
samp_unif = [rand(Poisson(x), 1000) for x in par_unif]
samp_col2 = vcat([samp_unif[i] for i in 1:100]...)

density(samp_col, label = "Normal Means", xlabel = "Aggregated Poisson Samples", c = :red)
density!(samp_col2, label = "Uniform Means", c = :purple)