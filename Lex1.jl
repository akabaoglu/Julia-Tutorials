using Plots, Distributions, GLM, DataFrames, StatsModels, StatsPlots

Y = rand(25)
Xs = eachcol(rand(25, 50))

var_names = Symbol.(string.("V", 1:50))

function new_var(q)
    for i in 1:q
    df[:, var_names[i]] = Xs[i]
    end
    return df
end


df = DataFrame(Y = Y)

r_squared = [let df_temp = new_var(i); r2(lm(Term(:Y) ~ sum(Term.(Symbol.(names(df_temp[:, Not(:Y)])))), df_temp)) end for i in 1:24]

plot(1:.01:24, map(x -> r_squared[x], map(x -> round(Int, x -.49), 1:.01:24)))
