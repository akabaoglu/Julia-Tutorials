using DataFrames, StatsBase, Distributions, StatsPlots

N = 50
n = round(Int, N/2)

dat = DataFrame(Treatment = repeat([1, 0], inner = n), Baseline = vcat(rand(Beta(55, 15), n), rand(Beta(60, 12), n)), Obs = 1:N)

###

t = filter(:Treatment => x -> x == 1, dat)
c = filter(:Treatment => x -> x == 0, dat)

store_min = Matrix{Float64}(undef, n, 4)


for j in 1:10^5
    t_rand = t[sample(1:n, n, replace = false), :]
    
    t_val = t_rand.Baseline
    c_val = collect(c.Baseline)
    
    t_ind = t_rand.Obs
    c_ind = collect(c.Obs)

    store = Matrix{Float64}(undef, n, 4)
    
    for i in 1:n  
        ind = findmin(abs.(t_val[i] .- c_val))[2]
        
        store[i, :] = vcat(t_ind[i], t_val[i],  c_ind[ind], c_val[ind])
        
        splice!(c_val, ind)
        splice!(c_ind, ind)
    end

    if j == 1
        store_min = store
    end


    if sum(x -> x^2, store_min[:, 2] - store_min[:, 4]) > sum(x -> x^2, store[:, 2] - store[:, 4])
        store_min = store
        println(j, " - ", sum(x -> x^2, store_min[:, 2] - store_min[:, 4]))
    end
end


actual = sum(x -> x^2, store_min[:, 2] - store_min[:, 4]) 

### 

function fx()
    let dat_sim = select(dat, [:Treatment, :Baseline], :Treatment => (x -> sample(x, N, replace = false)) => :Treatment)

    t_sim = dat_sim[dat_sim.Treatment .== 1, :]
    c_sim = dat_sim[dat_sim.Treatment .== 0, :]

    return sum(x -> x^2, t_sim.Baseline - c_sim.Baseline)
    end
end


rand_diffs = [fx() for _ in 1:10^4]

density(rand_diffs)
vline!([actual])

scatter(1:n, (abs.(store_min[:, 2] - store_min[:, 4])))