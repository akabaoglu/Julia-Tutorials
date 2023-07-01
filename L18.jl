using Plots, Distributions, GLM, DataFrames, StatsPlots, Statistics

tc = [0, 1]

IVs = reshape(collect(Base.product(tc, tc, tc, tc, tc, tc, tc, tc, tc, tc)), 2^10, 1)[2:1023, :]
DV = rand(Poisson(10), 10)

full_perm = [coef(lm(@formula(response ~ treatment), DataFrame(treatment = collect(i), response = DV)))[2] for i in IVs]

###

IV = collect(rand(IVs, 1)[1])

part_perm = [coef(lm(@formula(response ~ treatment), DataFrame(treatment = sample(IV, 10, replace = false), response = DV)))[2] for _ in 1:10^5]

density(full_perm, label = "Full Permutation")
density!(part_perm, label = "Partial Permutation")