using Distributions, DataFrames, Plots, StatsPlots

dat = DataFrame(x = rand(Normal(), 10^5), y = rand(Binomial(), 10^5), z = rand(Poisson(), 10^5))

transform!(dat, [:x, :y, :z] => ((a, b, c) -> a + b + c) => :SUM)

@df dat density(:SUM)

