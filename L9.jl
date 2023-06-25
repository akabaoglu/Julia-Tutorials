using DataFrames, GLM, StatsBase

dat = DataFrame(dist = [16, 52, 50, 64, 20, 32, 50, 36, 26, 60], speed = [0, 1, 1, 1, 0, 1, 1, 0, 0, 0])

function perm()
    dat_new = DataFrame(dist = sample(dat.dist, 10, replace = false), speed = dat.speed)
    m = lm(@formula(speed ~ dist), dat_new)
    return coef(m)[2]
end

pars = [perm() for _ in 1:10^6]

m1 = lm(@formula(speed ~ dist), dat)
n_fil = length(filter(x -> x > coef(m1)[2], pars))

p_val = n_fil/10^6

density(pars)
plot!(Normal(mean(pars), std(pars)), c = :gray, line = :dash, alpha = .5)
vline!([coef(m1)[2]], c = :red)