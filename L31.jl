using Plots, Distributions, QuadGK

function ent_unif(s)
    ent = quadgk(x -> -pdf(Uniform(-s, s), x)*log(pdf(Uniform(-s, s), x)), -s, s)[1]  
    return ent
end

plot(1:1:100, map(ent_unif, 1:1:100), c = :black, xlab = "Internal Width", ylab = "Entropy of Uniform Distribution")