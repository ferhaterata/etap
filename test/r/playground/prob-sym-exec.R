# Title     : Probabilistic Symbolic Execution
# Objective : Foundations and Prototyping
# Created by: Ferhat Erata
# Created on: 9.11.2020

options("StartupBanner" = "off")
library("distr")
library("distrEx")
x <- DiscreteDistribution(0) + Norm()
p(x)(0)
plot(x)
##########
#X <- Unif(10, 12); E(X); plot(X)
X <- Norm(11, sd = 1); E(X); plot(X)
#Y <- Unif(2, 8); E(Y); plot(Y)
Y <- Norm(5, sd = 1); E(Y); plot(Y)
# if (X < Y + 6) A:=2*Y
# if (X - Y < 6) A:=2*Y
Z <- (X - Y); plot(Z)
# T and F Legs of Branch
p(Z)(6) # Z < 6
p(Z)(Inf) - p(Z)(6) # Z >= 6
# Conditional Density Functions
##T: P( Z | Z < 6)
Z.T <- Truncate(Z, lower = -Inf, upper = 6)
plot(Z.T); p(Z.T)(6)
### a := 2 * y
A <- 2 * Y; plot(A)
### if (A > -2)
### if (A + 2 > 0)
B <- (A + 2); plot(B)
### T and F Legs of Branch
p(B)(Inf) - p(B)(0) # P(B > 0)
round(p(B)(0), 2) # P(B < 0)  P(B <= 0) P(3
###T: P( B | B > 0)
B.T <- Truncate(B, lower = 0, upper = Inf)
plot(B.T); p(B)(Inf) - p(B)(0) # B > 0
R.1 <- Y * X; plot(R.1)
###F: P( B | B <= 0)
B.F <- Truncate(B, lower = -Inf, upper = 0)
plot(B.F); round(p(B)(0), 2) # B <= 0
R.2 <- X; plot(R.2)
##F: P( Z | Z >= 6)
Z.F <- Truncate(Z, lower = 6, upper = Inf)
plot(Z.F); p(Z.F)(6)
R.2 <- X; plot(R.2)
############

############
X <- DiscreteDistribution(supp = 10:11)
support(X); E(X); plot(X)
Y <- DiscreteDistribution(supp = 2:7)
support(Y); E(Y); plot(Y)
# if (X < Y + 6) A:=2*Y
# if (X - Y < 6) A:=2*Y
Z <- (X - Y); plot(Z)
# T and F Legs of Branch
p(Z)(6) # Z <= 6
p(Z)(Inf) - p(Z)(6) # Z > 6
# Conditional Density Functions
##T: P( Z | Z < 6)
Z.T <- Truncate(Z, lower = -Inf, upper = 6)
plot(Z.T); p(Z.T)(6)
### a := 2 * y
A <- 2 * Y; plot(A)
### if (A > -2)
### if (A + 2 > 0)
B <- (A - 8); plot(B)
### T and F Legs of Branch
p(B)(Inf) - p(B)(0) # B > 0
p(B)(0.1) # B <= 0
###T: P( B | B > 0)
B.T <- Truncate(B, lower = 0, upper = Inf)
plot(B.T); p(B)(Inf) - p(B)(0) # B > 0
R.1 <- X * Y; plot(R.1)
###F: P( B | B <= 0)
B.F <- Truncate(B, lower = -Inf, upper = 0)
plot(B.F); round(p(B)(0), 2) # B <= 0
R.2 <- X; plot(R.2)
##F: P( Z | Z >= 6)
Z.F <- Truncate(Z, lower = 6, upper = Inf)
plot(Z.F); p(Z.F)(6)
R.2 <- X; plot(R.2)

############
############
D1 <- DiscreteDistribution(12)
support(D1)
plot(D1)
############
X <- DiscreteDistribution(supp = 2:7)
support(X)
plot(X)
############
Y <- DiscreteDistribution(supp = 10:11)
support(Y)
plot(Y)
############
############
x <- as.double(4.34)
y <- as.double(0)


foo <- function(x, y) {
  if (x < y + 6) {
    a <- 2 * y
    if (a > -2)
      return(x * y)
  }
  return(x)
}
