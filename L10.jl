using Plots, Distributions, DataFrames, StatsPlots

dat =  DataFrame(candidate = reverse(["Yavas", "Imamoglu", "Aksener", "Kilicdaroglu"]), rate = reverse([49.4, 47, 46.3, 41.8]), opp_rate = reverse([39.8, 41.9, 41.7, 42.5]))

dat.rate_adj = 100*dat.rate ./ (dat.rate + dat.opp_rate)

@df dat scatter(:candidate, :rate_adj, yerror = repeat([1/sqrt(3980)*1.96*100],4))

### More Colorful One

function clr(x)
    return [[x[i]] for i in 1:length(x)]
end

@df dat scatter(clr(:candidate), clr(:rate_adj), yerror = repeat([1/sqrt(3980)*1.96*100],4), markerstrokecolor = :auto, legend = :none)
hline!([50], c = :black, line = :dash)
