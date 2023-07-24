using Plots, DataFrames, Distributions, StatsBase, StatsPlots

dat = DataFrame(G = round.(Int, rand(Uniform(1, 50), 10^3)), T = rand(Binomial(1, .5), 10^3), O = rand(Normal(10, 5), 10^3))

function block_ra()
    dat_new = DataFrame(G = Int64[], T = Int64[], O = Float64[])
    for j in unique(dat.G)
        dat_s = subset(dat, :G => x -> x .== j)
        dat_s.T = sample(dat_s.T, length(dat_s.T), replace = false)
        [push!(dat_new, dat_s[i, :]) for i in 1:nrow(dat_s)]
    end
    return dat_new
end

dim_blocked = [mean(subset(block_ra(), :T => x -> x .== 0).O) - mean(subset(block_ra(), :T => x -> x .== 1).O) for _ in 1:10^4]

dim_unblocked = [let dat_temp = DataFrame(G = dat.G, T = sample(dat.T, length(dat.T), replace = false), O = dat.O); mean(subset(dat_temp, :T => x -> x .== 0).O) - mean(subset(dat_temp, :T => x -> x .== 1).O) end for _ in 1:10^4]

density(dim_blocked, label = "Blocked Randomization", c = :firebrick2)
density!(dim_unblocked, label = "Regular Randomization", c = :navyblue)