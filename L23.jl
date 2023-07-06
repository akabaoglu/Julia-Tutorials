using Plots, GLM, RDatasets, DataFrames, StatsPlots, StatsBase

RDatasets.datasets()[621, :]
galton = dataset("psych", "heights")

tru_val = coef(lm(@formula(Cubit ~ Height), galton))[2]

@df galton scatter(:Height, :Cubit, alpha = .1)

###

galton[sample(1:348, 10), :]

coefs = [[coef(lm(@formula(Cubit ~ Height), galton[sample(1:348, n), :]))[2] for _ in 1:10^5] for n in 10:10:50]

density(coefs, xlim = (.1, .4), labels = reshape([string("N=$i") for i in 10:10:50], 1, 5), fill = (0, .1))
vline!([tru_val], color = :red, line = :dash, label = "True Value")