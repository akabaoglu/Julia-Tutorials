using Plots, Distributions, GLM, DataFrames, Statistics, StatsPlots

y = rand(Poisson(10), 50)

m1 = lm(@formula(Y ~ X1 + X2 + X3), DataFrame(Y = y, X1 = rand(50), X2 = rand(50), X3 = rand(50)))

function f_stat(x)
    r = r2(x)
    f = (r/3)/((1-r)/46)
    return f
end

fs = [f_stat(lm(@formula(Y ~ X1 + X2 + X3), DataFrame(Y = y, X1 = rand(50), X2 = rand(50), X3 = rand(50)))) for _ in 1:10^5]

ecdfplot(fs, xlim = (0, 6))
plot!(0:.1:6, cdf.(FDist(3, 46), 0:.1:6), legend = :none, line = :dash)
scatter!([f_stat(m1)], [length(filter(x -> x < f_stat(m1), fs))/10^5], c = :firebrick2)

