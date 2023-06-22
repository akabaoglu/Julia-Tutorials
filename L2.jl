using RDatasets, Plots, Distributions, StatsBase, Unicode

RDatasets.datasets()[578,:]

dat = round.(Int, dataset("plm", "Snmesp").F)


dat_s = string.(dat)

char = [filter(isdigit, collect(i)) for i in dat_s]
char = vcat([char[i] for i in 1:length(dat_s)]...)
char = parse.(Int, char)

counts(char, 0:9)

bar(0:9, counts(char, 0:9), xticks = 0:9, label = :none)
