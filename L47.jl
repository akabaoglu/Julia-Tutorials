using Distributions, Plots, DataFrames, GLM

IV = vcat(rand(Normal(25, 10), 50), rand(Normal(75, 10), 50))

IV = IV./100

DV = [rand(Binomial(1, i)) for i in IV]

est = coef(glm(@formula(Y ~ X), DataFrame(Y = DV, X = IV), Binomial(), ProbitLink()))

plot(0:.01:1, cdf.(Normal(), est[1] .+ est[2].* collect(0:.01:1)), c = :black, label = "Probit Fit")
scatter!(IV, DV, msw = 0, alpha = .5, c = :black, label = "Observations")
