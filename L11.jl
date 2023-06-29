using Plots, Distributions, DataFrames, StatsPlots

dat = DataFrame(candidate = reverse(["Yavas", "Imamoglu", "Aksener", "Kilicdaroglu"]), rate = reverse([49.4, 47, 46.3, 41.8]), opp_rate = reverse([39.8, 41.9, 41.7, 42.5]), uncer = [15.7, 12, 11.1, 10.8])

dat.rate_adj = 100*dat.rate ./ (dat.rate + dat.opp_rate)

grid = -3:.01:3

rates = [[1 - cdf(Normal(dat.rate_adj[i] + m, sqrt(dat.uncer[i])), 50) for m in grid] for i in 1:4]

function col_aes(data; baseline = nothing, pal = :default, rev = false)
    if !isnothing(baseline)
    agg = vcat([baseline[i] for i in 1:length(baseline)]...)
    range = maximum(agg) - minimum(agg)
    grad = (2^10)/range

    dat_filt = filter(x -> x in data, agg)
    c_vals = replace(x -> x > (2^10) ? (2^10) : x < 1 ? 1 : x, round.(Int, (dat_filt .- minimum(agg)) .* grad))

    else 
        range = maximum(data) - minimum(data)
        grad = (2^10)/range
        c_vals = replace(x -> x > (2^10) ? (2^10) : x < 1 ? 1 : x, round.(Int, (data .- minimum(data)) .* grad))
    end


    if rev == true
        return reverse(cgrad(pal, (2^10)))[c_vals]
        else return cgrad(pal, (2^10))[c_vals]
    end
end

c_p = :matter
rev_bool = false

p1 = plot(grid, rates[1], c = col_aes(rates[1], pal = c_p, rev = rev_bool), xlabel = dat.candidate[1], label = :none, ylim = (0, 1))
p2 = plot(grid, rates[2], c = col_aes(rates[2], baseline = rates, pal = c_p, rev = rev_bool), xlabel = dat.candidate[2], label = :none, ylim = (0, 1))
p3 = plot(grid, rates[3], c = col_aes(rates[3], baseline = rates, pal = c_p, rev = rev_bool), xlabel = dat.candidate[3], label = :none, ylim = (0, 1))
p4 = plot(grid, rates[4], c = col_aes(rates[4], baseline = rates, pal = c_p, rev = rev_bool), xlabel = dat.candidate[4], label = :none, ylim = (0, 1))

plot(p1, p2, p3, p4)