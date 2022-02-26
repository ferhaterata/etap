load; UnivarMixingDistribution(Unif(0, 0.3), Unif(0.6, 1), mixCoeff = c(0.8, 0.2)); Norm(mean = 80, sd = 1)
br; AbscontDistribution(d = function(x) exp(-abs(x)^2), withStand = TRUE, Symmetry = SphericalSymmetry()); Norm(mean = 50, sd = 1.6)
icmp; Exp() + 2; UnivarMixingDistribution(Unif(4, 5), Unif(10, 11), mixCoeff = c(0.7, 0.3))
default; Truncate(Norm(), lower = -1, upper = 5) + 2; Norm(mean = 10, sd = 1)
