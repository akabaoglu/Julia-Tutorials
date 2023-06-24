using Distributions, Statistics, StatsBase, ColorSchemes, Plots, StatsPlots

function col_aes(dat; pal = :default, rev = false)
    range = maximum(dat) - minimum(dat)
    grad = (2^10)/range
    c_vals = replace(x -> x > (2^10) ? (2^10) : x < 1 ? 1 : x, round.(Int, (dat .- minimum(dat)) .* grad))

    if rev == true
    return reverse(cgrad(pal, (2^10)))[c_vals]
    else return cgrad(pal, (2^10))[c_vals]
    end
end

### Application 1
dat1 = -rand(Poisson(10^6), 100)
scatter(1:100, dat1, c = col_aes(dat1, rev = true))


### Application 2
dat2 = round.(Int, rand(Normal(10, 2), 100))
len = minimum(dat2):maximum(dat2)
c_s = counts(dat2, len)
bar(len, c_s, c = col_aes(c_s, pal = :algae))


### Application 3
dist = Normal(10, 5)
dens = [pdf(dist, i) for i in -5:.1:25]

plot(-5:.1:25, dens, c = col_aes(dens, rev = true), legend = :none)




