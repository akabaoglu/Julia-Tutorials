using Plots, GLM, DataFrames, StatsPlots, Distributions

@time begin
df = DataFrame(x = sort(rand(Normal(5, 3), 10)))

df.y = map(x -> x^2 - 6x + 15, df.x)

df1 = first(df, 6)
df2 = last(df, 4)

m1 = lm(@formula(y ~ x), df1)
m2 = lm(@formula(y ~ x), df2)

@df df1 scatter(:x, :y, c = :firebrick2, label = "Sample 1")
@df df2 scatter!(:x, :y, c = :navyblue, label = "Sample 2")
Plots.abline!(reverse(coef(m1))..., c = :firebrick2, line = :dash, label = "Fit 1")
Plots.abline!(reverse(coef(m2))..., c = :navyblue, line = :dash, label = "Fit 2")
end