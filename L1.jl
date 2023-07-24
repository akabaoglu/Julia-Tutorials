using RDatasets, Plots, StatsPlots, DataFrames, GLM

urine_dat = dataset("boot", "urine")

describe(urine_dat.Urea)

urine_dat.UreaBin = [urine_dat.Urea[i] > 266 ? 1 : 0 for i in eachindex(urine_dat.Urea)] 

m_cont = lm(@formula(Calc ~ Urea), urine_dat)
m_bin = lm(@formula(Calc ~ UreaBin), urine_dat)

ran_cont = minimum(urine_dat.Urea):10:maximum(urine_dat.Urea)
ran_bin = 0:.01:1

p1 = @df urine_dat scatter(:Urea, :Calc, msw = 0, ms = 3, c = :black)
plot!(ran_cont, [coef(m_cont)'*[1, i] for i in ran_cont], c = :red, legend = :none)

p2 = @df urine_dat scatter(:UreaBin, :Calc, msw = 0, ms = 3, c = :black, alpha = .5)
plot!(ran_bin, [coef(m_bin)'*[1, i] for i in ran_bin], c = :red, legend = :none)

plot(p1, p2)