using Plots, Optim

function fibonacci(n)
    ser = big.([1, 1])
    for i in 3:n
        val = ser[i-2] + ser[i-1]
        push!(ser, val)
    end
    return ser
end

f = 15

fib = fibonacci(f)

function abs_err(x)
    return sum(abs.((x[1] .^ (1:f)) .- big.(fib)))
end

min_val = Optim.minimizer(optimize(abs_err, [1.5], autodiff = :forward))[1]

min_val_r = round(min_val, digits = 5)

scatter(1:15, min_val .^ (1:15), c = :firebrick, label = "x^~$min_val_r", alpha = .65)
scatter!(1:15, fib, c = :navyblue, label = "Fibonacci Series", alpha = .65)

###

function abs_errs(y)
    fib_new = fibonacci(y)
    
    function abs_err(x)
        return sum(abs.((x[1] .^ (1:y)) .- big.(fib_new)))
    end
    
    min_val = Optim.minimizer(optimize(abs_err, [1.5], autodiff = :forward))[1]

    return(min_val)
end

abs_errs(10)

plot(5:150, map(abs_errs, 5:150), color = :navyblue)
scatter!(5:150, map(abs_errs, 5:150), color = :navyblue, ms = 1)
hline!([1.6], line = :dash, color = :tomato2, legend = :none)