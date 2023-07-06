using Plots, Distributions, QuadGK

function ent_normal(s)
    ent = quadgk(x -> -pdf(Normal(0, s), x)*log(pdf(Normal(0, s), x)), -2*s, 2*s)[1]  
    return ent
end

plot(1:1:100, map(ent_normal, 1:1:100), c = :black, xlab = "Standard Deviation", ylab = "Entropy of Gaussian Distribution")