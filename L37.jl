using Plots, Optim, Distributions, GLM, DataFrames, Random

Random.seed!(61801)

function abs_diff(X, Y)
    function fx(x)
       sum(abs, Y .- x[1] .- x[2].*X)
    end

    o = optimize(fx, [0.0, 0.0])
    
    return Optim.minimizer(o)
end

vals = rand(MvNormal([5, 10], [12 8; 8 9]), 100)'

abs_est = abs_diff(vals[: , 1], vals[: , 2])

lm_est = coef(lm(@formula(Y ~ X), DataFrame(X = vals[: , 1], Y = vals[: , 2])))

scatter(vals[: , 1], vals[: , 2], ms = 3, msw = 0, c = :navyblue, label = "Data Points")
Plots.abline!(reverse(abs_est)..., label = "Abs_Diff Fit", c = :firebrick2)
Plots.abline!(reverse(lm_est)..., label = "LM Fit", c = :purple)

