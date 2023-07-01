using RDatasets, GLM, DataFrames, StatsBase, Distributions, Statistics, Random, StatsPlots

RDatasets.datasets()[189, :]

cs = dataset("ISLR", "Carseats")

function cs_perm()
    cs_new = cs
    cs_new.Advertising = sample(cs.Advertising, 400, replace = false)
    m1 = lm(@formula(Population ~ Advertising), cs_new)
    return coeftable(m1).cols[4][2]
end

function cs_unif()
    cs_new = DataFrame(Population = cs.Population, Advertising = rand(Uniform(minimum(cs.Advertising), maximum(cs.Advertising)), 400))
    m2 = lm(@formula(Population ~ Advertising), cs_new)
    return coeftable(m2).cols[4][2]
end

function cs_norm()
    cs_new = DataFrame(Population = cs.Population, Advertising = rand(Normal(mean(cs.Advertising), std(cs.Advertising)), 400))
    m3 = lm(@formula(Population ~ Advertising), cs_new)
    return coeftable(m3).cols[4][2]
end

n = 1000
N = 1000

vals1 = [[cs_perm() for i in 1:n] for _ in 1:N]
vals2 = [[cs_unif() for i in 1:n] for _ in 1:N]
vals3 = [[cs_norm() for i in 1:n] for _ in 1:N]

size_insample = length.(filter.(x -> x < .05, vals1)) ./ n
size_outsample_unif = length.(filter.(x -> x < .05, vals2)) ./ n
size_outsample_norm = length.(filter.(x -> x < .05, vals3)) ./ n

boxplot(["In-Sample"], size_insample, color = :tomato2)
boxplot!(["Out-Sample Uni"], size_outsample_unif, color = :darkkhaki)
boxplot!(["Out-Sample Norm"], size_outsample_norm, color = :dodgerblue, legend = :none)