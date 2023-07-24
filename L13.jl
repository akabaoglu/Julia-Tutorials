using Plots, Distributions, StatsBase, Statistics, DataFrames, StatsPlots

f_goal = rand(Poisson(51/20), 10^6)
a_goal = rand(Poisson(39/20), 10^6)

res = [[f_goal[i], a_goal[i]] for i in 1:10^4]

res_u = unique(res)

freq = [length(filter(x -> x == i, res)) for i in unique(res)]

dat = DataFrame(f_score = first.(res_u), a_score = last.(res_u), freq = freq./sum(freq))

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

@df dat surface(:f_score, :a_score, :freq)

###

function finder(a, b)
    r = filter(x -> x.f_score == a && x.a_score == b, dat)

    if nrow(r) == 0
        return 0
    else
    return r.freq[1]
    end
end
    
threedim = [finder(x, y) for x in 0:5, y in 0:5]

function colcat(x, y)
    x > y ? -1 : y > x ? 1 : 0
end

col_categ = [colcat(x, y) for x in 0:5, y in 0:5]

alphas = threedim .* (1/maximum(threedim) - minimum(threedim))

heatmap(0:5, 0:5, col_categ, c = cgrad([:red, :yellow, :blue]), xlabel = "Fenerbahce Score", ylabel = "Adanademirspor Score", alpha = alphas, legend = :none)

heatmap(0:5, 0:5, threedim, c = reverse(cgrad(:inferno)))