# Title     : TODO
# Objective : TODO
# Created by: ferhat
# Created on: 13.04.2021
library(ggplot2)

data <- data.frame(value=rnorm(100))
base <- ggplot(data, aes(x = value)) +
 xlim(-5, 5) + xlab("nJ") + ylab("") +
  theme(legend.position = c(0, 1), legend.justification = c(-0.2, 1.3)) 
base + theme(legend.title = element_blank()) +
  geom_function(aes(colour = "X ~ Loop overhead (100K inst.)"), fun = dnorm) +
  geom_function(aes(colour = "Y ~ 100K inst. w/ loop overhead"), fun = dt, args = list(df = 1))




# geom_function() is useful for overlaying functions
set.seed(1492)
# ggplot(data.frame(x = rnorm(100)), aes(x)) +
#   geom_density() +
#   geom_function(fun = dnorm, colour = "red")

# To plot functions without data, specify range of x-axis
base <- ggplot() + xlim(-5, 5)
# base + geom_function(fun = dnorm)
# base + geom_function(fun = dnorm, args = list(mean = 2, sd = .5))
# The underlying mechanics evaluate the function at discrete points
# and connect the points with lines
# base + stat_function(fun = dnorm, geom = "point")
# base + stat_function(fun = dnorm, geom = "point", n = 20)
# base + geom_function(fun = dnorm, n = 20)
# Two functions on the same plot
base +
  geom_function(aes(colour = "normal"), fun = dnorm) +
  geom_function(aes(colour = "t, df = 1"), fun = dt, args = list(df = 1))
# Using a custom anonymous function
base + geom_function(fun = function(x) 0.5 * exp(-abs(x)))
base + geom_function(fun = ~0.5 * exp(-abs(.x)))
# Using a custom named function
f <- function(x)0.5 * exp(-abs(x))
base + geom_function(fun = f)