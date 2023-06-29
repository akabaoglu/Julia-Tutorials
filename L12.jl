using RDatasets, Plots, Distributions, StatsBase, StatsPlots

RDatasets.datasets()[291,:]

dat = dataset("MASS", "quine")

dat.SexBin = map(x -> x == "M" ? 1 : 0, dat.Sex)

function rand_coef()
    dat_rand = DataFrame(IV = sample(dat.SexBin, 146, replace = true), DV = dat.Days)
    return mean(filter(x -> x.IV == 1, dat_rand)[:, :DV] ) - mean(filter(x -> x.IV == 0, dat_rand)[:, :DV])
end

coef_list = [rand_coef() for i in 1:10^6]

density(coef_list, legend = :none)