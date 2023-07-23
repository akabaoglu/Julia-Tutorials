using Plots, Distributions, StatsPlots

days = round.(Int, rand(Exponential(1/.025), 100))

ran = minimum(days):1:maximum(days)

dens = [mean(map(x -> x > i, days)) for i in ran]

plot(ran, dens, c = :firebrick2, lw = 2, label = "ecdf")
plot!(ran, map(x -> 1- cdf(Exponential(1/.025), x), ran), c = :navyblue, label = "Exp Dist")