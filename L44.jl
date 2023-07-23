using Plots, Distributions, GLM, DataFrames

dat = rand(MvNormal([0, 0, 0], [1 0 0; 0 1 .2; 0 .2 1]), 10^3)'

m1 = lm(@formula(Y ~ X1 + X2), DataFrame(X1 = dat[:, 1], X2 = dat[:, 2], Y = dat[:, 3]))

r2(m1)


function sens(q, r)
    vals = rand(MvNormal([0, 0, 0], [1 q r; q 1 .2; r .2 1]), 10^3)'

    df = DataFrame(X1 = vals[:, 1], X2 = vals[:, 2], Y = vals[:, 3])

    m = lm(@formula(Y ~ X1 + X2), df)

    return coeftable(m).cols[4][3]
end

ran = 0:.025:.5

p_means = [mean([sens(a, b) for _ in 1:10^3]) for a in ran, b in ran]

sig = map(x -> x > .05, p_means)

heatmap(ran.^2, ran.^2, sig, c = cgrad(:roma, 2, categorical = true), legend = :none)