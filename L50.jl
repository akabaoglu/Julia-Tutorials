using Distributions, Plots, DataFrames, StatsPlots

df = DataFrame(V1 = rand(Normal(100, 25), 100), V2 = rand(Poisson(100), 100),
V3 = rand(NegativeBinomial(10, .3), 100))

transform!(df, [:V1, :V2, :V3] => ByRow((x, y, z) -> sqrt(x)*sqrt(y)/sqrt(z)) => :V4)

@df df density(:V4)

