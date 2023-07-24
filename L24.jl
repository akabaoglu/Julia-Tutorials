using Plots, GLM, RDatasets, DataFrames, StatsBase, StatsPlots

RDatasets.datasets()[93, :]

sumhes = dataset("Ecdat", "SumHes")

sumhes.GDP_Bin = map(x -> x >= 1750 ? 0 : 1, sumhes.GDP)

coefs = [[coef(glm(@formula(GDP_Bin ~ SR), sumhes[sample(1:3250, n, replace = false),:], Binomial(), LogitLink()))[2] for _ in 1:10^4] for n in 100:100:2400]

mean.(coefs)
density(coefs)

coef_real = coef(glm(@formula(GDP_Bin ~ SR), sumhes, Binomial(), LogitLink()))[2]

scatter(100:100:2400, abs.(mean.(coefs) .- coef_real))



