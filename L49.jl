using Plots, GLM, Distributions, DataFrames

dat = rand(MvNormal([10, 50], [10 1.5; 1.5 8]), 50)'

m = lm(@formula(Y ~ X), DataFrame(X = dat[:, 1], Y = dat[:, 2]))

coeftable(m).cols[1]

mc = eachrow([rand(Normal(coeftable(m).cols[1][2], coeftable(m).cols[2][2]), 100) rand(Normal(coeftable(m).cols[1][1], coeftable(m).cols[2][1]), 100)])


function line(a, b)
    return x -> a*x + b
end

plot([1,100], [map(line(i...), [1,100]) for i in mc], legend = :none, c = :black, alpha = .3, xlim = (10 - 3sqrt(10), 10 + 3sqrt(10)), ylim = (50 - 3sqrt(8), 50 + 3sqrt(8)))