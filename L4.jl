using Dates, StatsBase, Plots

dates = Date("15-05-2012", "d-m-y"):Day(1):Date("15-05-2022", "d-m-y")

r_dates = rand(dates, 10^5)

dayname.(r_dates)

a = Dict("Monday" => 1, "Tuesday" => 2, "Wednesday" => 3, "Thursday" => 4,
    "Friday" => 5, "Saturday" => 6, "Sunday" => 7)

c_s = counts([a[i] for i in dayname.(r_dates)], 1:7)

bar(1:7, c_s, c = :pink, legend = :none, xticks = (1:7, ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]))