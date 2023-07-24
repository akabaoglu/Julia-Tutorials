using Plots, Distributions, GLM, DataFrames, Loess

function fx(ssize)
    dat = rand(MvNormal([10, 20], [16 5; 5 6]), ssize)'
    
    df = DataFrame(X = dat[:, 1], Y = dat[:,  2])
    
    t_val = coeftable(lm(@formula(Y ~ X), df)).cols[3][2]

    return t_val
end

x_s = repeat(5:10^3, inner = 10)

t_vals = [fx(i) for i in x_s]

scatter(x_s, t_vals, ms = 2, msw = 0, alpha = .5, c = :black)
plot!(5:10^3, predict(loess(x_s, t_vals), 5:10^3), linewidth = 3, c = :red, legend = :none)