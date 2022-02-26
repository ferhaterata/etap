timing$load <- Norm(mean = 20, sd = 1)
energy$load <- Norm(mean = 80, sd = 1)

timing$alloca <- Norm(mean = 10, sd = 1)
energy$alloca <- Norm(mean = 50, sd = 1.6)

timing$memcpy <- function(x) Norm(mean = 13.06, sd = 0.01) + x * Norm(mean = 9.06, sd = 0.01)
energy$memcpy <- function(x) Norm(mean = 35.04, sd = 1.38) + x * Norm(mean = 24.21, sd = 1.24)

timing$default <- Norm(1.02, 0.01)
energy$default <- Norm(6.97, 0.62)
