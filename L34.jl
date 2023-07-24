using Plots, Distributions, GLM, DataFrames

dat = rand(MvNormal([10, 20], [16 5; 5 6]), 1000)'

df = DataFrame(X = dat[:, 1], Y = dat[:,  2])

coefs = coef(lm(@formula(Y ~ X), df))

scatter(df.X, df.Y, ms = 2, msw = 0, c = :navyblue)
Plots.abline!(reverse(coefs)..., legend = :none, linewidth = 3, c = :firebrick2)