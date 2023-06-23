using Plots

function fx(x)
    x > 5 ? x^2 - 4*x + 76 : x < 5 ? x^(2)*6 : -20
end

fx(-14)
plot(fx, -10, 14, legend = :none, c = :purple, marker = :dot, ms = 2)
