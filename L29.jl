using Plots, QuadGK, Distributions

fx(x) = sin(x^3) + exp(1/9)*(x^2 -  19*cos(1-(pi/5*(x)))) + abs((x-3)/2) + sin(log(abs(x) + 3, 100))*(pi + 2)^1.9 + 45

plot(fx, xlim = (-10, 10), ylim = (0, 200), c = :black)

val1 = quadgk(fx, -10, 10)[1]

###

xs = rand(Uniform(-10, 10), 10^5)
ys = rand(Uniform(0, 200), 10^5)

ps = [[xs[i], ys[i]] for i in 1:10^5]

val2 = (length(filter(x -> x[2] < fx(x[1]), ps))/10^5)*4000

val1 - val2


outer = filter(x -> x[2] > fx(x[1]), ps)
inner = filter(x -> x[2] < fx(x[1]), ps)

plot(fx, xlim = (-10, 10), ylim = (0, 200), c = :black)
scatter!(first.(inner), last.(inner), ms = 1, msw = 0, c = :firebrick)
scatter!(first.(outer), last.(outer), ms = 1, msw = 0, c =  :navyblue, legend = :none)