energy$load <- Binom(12, 0.7)
energy$br <- Pois(lambda = 1.2)
energy$default <- 12 * Binom(prob = 1, size = 1)

timing$load <- 15
timing$br <- DiscreteDistribution(supp = c(12, 15), prob = c(0.4, 0.6))
timing$default <- DiscreteDistribution(supp = c(12, 15), prob = c(0.4, 0.6))

