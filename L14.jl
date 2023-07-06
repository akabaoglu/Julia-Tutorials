using StatsBase

roster = ["Seung", "Jane", "Hyeonseo", "Zach", "Paul", "Qiaoyi", "Rahnuma", "Alesha", "Abdullah"]

reshape(sample(roster, 9, replace = false), 3, 3)

###

groups = [reshape(sample(roster, 9, replace = false), 3, 3) for _ in 1:10^3]

locations = [indexin(["Paul", "Zach"], groups[i]) for i in 1:10^3]

sum([locations[i][1][2] == locations[i][2][2] for i in 1:10^3])