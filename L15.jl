using Plots, GLM, RDatasets, StatsPlots

pop = dataset("car", "USPop")

pop.Population = log.(pop.Population)

m1 = lm(@formula(Population ~ Year), pop)

@df pop scatter(:Year, :Population, label = "Log Population")
Plots.abline!(coef(m1)[2], coef(m1)[1], label = "OLS Fit")