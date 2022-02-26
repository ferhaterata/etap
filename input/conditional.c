// -----------------------------------------------------------------------------
//  Test case for probabilistic symbolic simulation.               conditional.c
//   To validate whether the framework handles conditional events correctly.
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 09, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

int conditional(int n) {
#pragma distribution parameter "n <- DiscreteDistribution(supp=1:4)"
  if (n > 1) return n;
  return n;
}

int conditional0(int n) {
#pragma distribution parameter "n <- DiscreteDistribution(supp=1:4)"
  n = n - 1;
  if (n > 1) return n;
  return n;
}

int conditional1(int n) {
#pragma distribution parameter "n <- DiscreteDistribution(supp=1:4)"
  if (n > 1)
    if (n > 2)
      ;
  return n;
}

/*
### PATH 1; n > 1 and n > 2
rm(list = ls(all.names = TRUE))
x <- 1 # if(n > 1)
n <- DiscreteDistribution(supp = 1:4)
v.cmp <- n - x
if (is.numeric(v.cmp)) v.cmp <- DiscreteDistribution(v.cmp)
v.cmp.true.1 <- 1 - p(v.cmp)(0)
plot(v.cmp)
v.cmp <- Truncate(v.cmp, lower = 1, upper = Inf)
plot(v.cmp)
n <- v.cmp + x  # transfer knowledge back to N
plot(n)

x <- 2 # if(n > 2)
v.cmp <- n - x
if (is.numeric(v.cmp)) v.cmp <- DiscreteDistribution(v.cmp)
v.cmp.true.2 <- 1 - p(v.cmp)(0)
plot(v.cmp)
v.cmp <- Truncate(v.cmp, lower = 1, upper = Inf)
plot(v.cmp)
n <- v.cmp + x  # transfer knowledge back to N
plot(n)

ret1 <- n
prob1 <- v.cmp.true.1 * v.cmp.true.2
# 0.75 * 0.67

### PATH 2; n > 1 and n <= 2
x <- 1 # if(n > 1)
n <- DiscreteDistribution(supp = 1:4)
v.cmp <- n - x
if (is.numeric(v.cmp)) v.cmp <- DiscreteDistribution(v.cmp)
v.cmp.true.1 <- 1 - p(v.cmp)(0)
plot(v.cmp)
v.cmp <- Truncate(v.cmp, lower = 1, upper = Inf)
plot(v.cmp)
n <- v.cmp + x  # transfer knowledge back to N
plot(n)

x <- 2 # if(n <= 2)
v.cmp <- n - x
if (is.numeric(v.cmp)) v.cmp <- DiscreteDistribution(v.cmp)
v.cmp.false.1 <- p(v.cmp)(0)
plot(v.cmp)
v.cmp <- Truncate(v.cmp, lower = -Inf, upper = 0)
plot(v.cmp)
n <- v.cmp + x  # transfer knowledge back to N
plot(n)

ret2 <- n
prob2 <- v.cmp.true.1 * v.cmp.false.1
# 0.75 * 0.33

### PATH 3; n <= 1
x <- 1 # if(n <= 1)
n <- DiscreteDistribution(supp = 1:4)
v.cmp <- n - x
if (is.numeric(v.cmp)) v.cmp <- DiscreteDistribution(v.cmp)
v.cmp.false.1 <- p(v.cmp)(0)
plot(v.cmp)
v.cmp <- Truncate(v.cmp, lower = -Inf, upper = 0)
plot(v.cmp)
n <- v.cmp + x  # transfer knowledge back to N
plot(n)
# 0.25

ret3 <- n
prob3 <- v.cmp.false.1

####
dlist <- c(ret1, ret2, ret3)
coeff <- c(prob1, prob2, prob3)
ret <- UnivarMixingDistribution(Dlist = dlist, mixCoeff = coeff)
plot(ret)
 */

int conditional2(int n) {
#pragma distribution parameter "n <- DiscreteDistribution(supp=1:4)"
  int x = n;
  if (n > 1)
    if (n > 2) return n;
  return x;
}

int conditional3(int n) {
#pragma distribution parameter "n <- DiscreteDistribution(supp=1:4)"
  int x = n;
  int* xp = &x;
  if (n > 1)
    if (n > 2) return n;
  return *xp;
}

int conditional4(int x, int y) {
#pragma distribution parameter "x <- DiscreteDistribution(supp=1:4)"
#pragma distribution parameter "y <- DiscreteDistribution(supp=5:8)"
  if (x - y > 1) return x;
  return y;
}

int conditional5(int x, int y) {
#pragma distribution parameter "x <- DiscreteDistribution(supp=2:5)"
#pragma distribution parameter "y <- DiscreteDistribution(supp=4:7)"
  if (x > 3)
    if (y < x) return x;
  return y;
}

int conditional6(int x, int y) {
#pragma distribution parameter "x <- DiscreteDistribution(supp=2:5)"
#pragma distribution parameter "y <- DiscreteDistribution(supp=4:7)"
  int x = n;
  int* xp = &x;
  if (x > 3)
    if (y < x) return *xp;
  return y;
}
