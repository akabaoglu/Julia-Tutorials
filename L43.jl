using Distributions, GLM, DataFrames

X1 = rand(Normal(10, 5), 10^3)

X2 = 15 .+ 5*X1 .+ rand(Normal(0, 10), 10^3) 

Y = 10 .+ 3*X1 .+ 2*X2 + rand(Normal(0, 25), 10^3)

est_unbiased = coef(lm(@formula(Y ~ X1 + X2), DataFrame(Y = Y, X1 = X1, X2 = X2)))[3]

est_biased = coef(lm(@formula(Y ~ X2), DataFrame(Y = Y, X2 = X2)))[2]

est_unbiased - est_biased