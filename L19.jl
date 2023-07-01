using Plots, Distributions, GLM, DataFrames, StatsPlots, Statistics

IV = rand(Binomial(1, .45), 100)
DV = rand(Poisson(25), 100)

repl = [coef(lm(@formula(outcome ~ treatment), DataFrame(treatment = sample(IV, 100, replace = true), outcome = DV)))[2] for _ in 1:10^5]
no_repl = [coef(lm(@formula(outcome ~ treatment), DataFrame(treatment = sample(IV, 100, replace = false), outcome = DV)))[2] for _ in 1:10^5]

density(repl, label = "With Replacement")
density!(no_repl, label = "With No Replacement")