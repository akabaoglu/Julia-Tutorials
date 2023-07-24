using Distributions, GLM, DataFrames, .Threads

@time [coef(glm(@formula(Y ~ X1 + X2 + X3), DataFrame(X1 = rand(Normal(10, 5), 25*10^3), X2 = rand(Normal(10, 5), 25*10^3), X3 = rand(Normal(10, 5), 25*10^3), Y = rand(Binomial(1, .3), 25*10^3)), Binomial(), LogitLink())) for _ in 1:10^4]

@time Threads.@threads for i in 1:10^4
    coef(glm(@formula(Y ~ X1 + X2 + X3), DataFrame(X1 = rand(Normal(10, 5), 25*10^3), X2 = rand(Normal(10, 5), 25*10^3), X3 = rand(Normal(10, 5), 25*10^3), Y = rand(Binomial(1, .3), 25*10^3)), Binomial(), LogitLink()))
end