using Plots, Distributions

vals = rand(Uniform(0, 2), 10^5, 2)

inside = filter(x -> (x[1] - 1)^2 + (x[2] - 1)^2 < 1, eachrow(vals))
outside = filter(x -> (x[1] - 1)^2 + (x[2] - 1)^2 > 1, eachrow(vals))

scatter(first.(inside), last.(inside), ms = 2, msw = 0, c = :tomato2, label = :none, alpha = .2)
scatter!(first.(outside), last.(outside), ms = 2, msw = 0, c = :navyblue, label = :none, alpha = .2)

round((length(inside)/10^5)*4 - pi)