# Title     : TODO
# Objective : TODO
# Created by: ferhat
# Created on: 4.04.2021
rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
# load libraries
options("StartupBanner" = "off")
options(expressions = 500000) #increase the limit on the number of nested expressions that will be evaluated
library("distr")
library("distrEx")
distr::distroptions("WarningArith" = FALSE)
set.seed(100)

timing <- rlang::env()
energy <- rlang::env()

timing$checkpoint$entry <- distr::Norm(mean = 1.04, sd = 0.24) # us
energy$checkpoint$entry <- distr::Norm(mean = 4.52, sd = 0.62) # nj
timing$restore$entry <- distr::Norm(mean = 1.04, sd = 0.24) # us
energy$restore$entry <- distr::Norm(mean = 4.52, sd = 0.62) # nj
timing$bc_main$entry <- distr::Norm(mean = 28.49, sd = 0.72) # us
energy$bc_main$entry <- distr::Norm(mean = 67.11, sd = 1.96) # nj
timing$bc_main$for.cond <- distr::Norm(mean = 11.07, sd = 0.34) # us
energy$bc_main$for.cond <- distr::Norm(mean = 29.92, sd = 1.39) # nj
timing$bc_main$for.body <- distr::Norm(mean = 15.17, sd = 0.49) # us
energy$bc_main$for.body <- distr::Norm(mean = 38.4, sd = 1.52) # nj
timing$bc_main$if.then <- distr::Norm(mean = 5.06, sd = 0.24) # us
energy$bc_main$if.then <- distr::Norm(mean = 12.77, sd = 0.88) # nj
timing$bc_main$for.cond2 <- distr::Norm(mean = 9.07, sd = 0.34) # us
energy$bc_main$for.cond2 <- distr::Norm(mean = 24.12, sd = 1.24) # nj
timing$bc_main$for.body4 <- distr::Norm(mean = 27.44, sd = 0.72) # us
energy$bc_main$for.body4 <- distr::Norm(mean = 69.65, sd = 2.06) # nj
timing$bc_main$if.then.i <- 2 # us
energy$bc_main$if.then.i <- distr::Norm(mean = 5.8, sd = 0.62) # nj
timing$bc_main$do.body.i <- distr::Norm(mean = 37.8, sd = 1.07) # us
energy$bc_main$do.body.i <- distr::Norm(mean = 118.06, sd = 2.91) # nj
timing$bc_main$do.end.i <- 2 # us
energy$bc_main$do.end.i <- distr::Norm(mean = 5.8, sd = 0.62) # nj
timing$bc_main$bit_count.exit <- distr::Norm(mean = 16.19, sd = 0.48) # us
energy$bc_main$bit_count.exit <- distr::Norm(mean = 39.67, sd = 1.52) # nj
timing$bc_main$for.inc <- distr::Norm(mean = 30.53, sd = 0.9) # us
energy$bc_main$for.inc <- distr::Norm(mean = 86.17, sd = 2.4) # nj
timing$bc_main$for.end <- 2 # us
energy$bc_main$for.end <- distr::Norm(mean = 5.8, sd = 0.62) # nj
timing$bc_main$if.else <- distr::Norm(mean = 9.07, sd = 0.34) # us
energy$bc_main$if.else <- distr::Norm(mean = 24.12, sd = 1.24) # nj
timing$bc_main$if.then7 <- distr::Norm(mean = 5.06, sd = 0.24) # us
energy$bc_main$if.then7 <- distr::Norm(mean = 12.77, sd = 0.88) # nj
timing$bc_main$for.cond8 <- distr::Norm(mean = 9.07, sd = 0.34) # us
energy$bc_main$for.cond8 <- distr::Norm(mean = 24.12, sd = 1.24) # nj
timing$bc_main$for.body10 <- distr::Norm(mean = 183.1, sd = 2.45) # us
energy$bc_main$for.body10 <- distr::Norm(mean = 595.16, sd = 6.62) # nj
timing$bc_main$for.inc13 <- distr::Norm(mean = 30.53, sd = 0.9) # us
energy$bc_main$for.inc13 <- distr::Norm(mean = 86.17, sd = 2.4) # nj
timing$bc_main$for.end16 <- 2 # us
energy$bc_main$for.end16 <- distr::Norm(mean = 5.8, sd = 0.62) # nj
timing$bc_main$if.else17 <- distr::Norm(mean = 9.07, sd = 0.34) # us
energy$bc_main$if.else17 <- distr::Norm(mean = 24.12, sd = 1.24) # nj
timing$bc_main$if.then19 <- distr::Norm(mean = 5.06, sd = 0.24) # us
energy$bc_main$if.then19 <- distr::Norm(mean = 12.77, sd = 0.88) # nj
timing$bc_main$for.cond20 <- distr::Norm(mean = 9.07, sd = 0.34) # us
energy$bc_main$for.cond20 <- distr::Norm(mean = 24.12, sd = 1.24) # nj
timing$bc_main$for.body22 <- distr::Norm(mean = 17.24, sd = 0.54) # us
energy$bc_main$for.body22 <- distr::Norm(mean = 40.87, sd = 1.52) # nj
timing$bc_main$do.body.i94 <- distr::Norm(mean = 55.1, sd = 1.25) # us
energy$bc_main$do.body.i94 <- distr::Norm(mean = 178.56, sd = 3.62) # nj
timing$bc_main$ntbl_bitcnt.exit <- distr::Norm(mean = 12.19, sd = 0.48) # us
energy$bc_main$ntbl_bitcnt.exit <- distr::Norm(mean = 31.34, sd = 1.39) # nj
timing$bc_main$for.inc25 <- distr::Norm(mean = 30.53, sd = 0.9) # us
energy$bc_main$for.inc25 <- distr::Norm(mean = 86.17, sd = 2.4) # nj
timing$bc_main$for.end28 <- 2 # us
energy$bc_main$for.end28 <- distr::Norm(mean = 5.8, sd = 0.62) # nj
timing$bc_main$if.else29 <- distr::Norm(mean = 9.07, sd = 0.34) # us
energy$bc_main$if.else29 <- distr::Norm(mean = 24.12, sd = 1.24) # nj
timing$bc_main$if.then31 <- distr::Norm(mean = 5.06, sd = 0.24) # us
energy$bc_main$if.then31 <- distr::Norm(mean = 12.77, sd = 0.88) # nj
timing$bc_main$for.cond32 <- distr::Norm(mean = 9.07, sd = 0.34) # us
energy$bc_main$for.cond32 <- distr::Norm(mean = 24.12, sd = 1.24) # nj
timing$bc_main$for.body34 <- distr::Norm(mean = 96.05, sd = 1.76) # us
energy$bc_main$for.body34 <- distr::Norm(mean = 348.31, sd = 5.22) # nj
timing$bc_main$for.inc37 <- distr::Norm(mean = 30.53, sd = 0.9) # us
energy$bc_main$for.inc37 <- distr::Norm(mean = 86.17, sd = 2.4) # nj
timing$bc_main$for.end40 <- 2 # us
energy$bc_main$for.end40 <- distr::Norm(mean = 5.8, sd = 0.62) # nj
timing$bc_main$if.else41 <- distr::Norm(mean = 9.07, sd = 0.34) # us
energy$bc_main$if.else41 <- distr::Norm(mean = 24.12, sd = 1.24) # nj
timing$bc_main$if.then43 <- distr::Norm(mean = 5.06, sd = 0.24) # us
energy$bc_main$if.then43 <- distr::Norm(mean = 12.77, sd = 0.88) # nj
timing$bc_main$for.cond44 <- distr::Norm(mean = 9.07, sd = 0.34) # us
energy$bc_main$for.cond44 <- distr::Norm(mean = 24.12, sd = 1.24) # nj
timing$bc_main$for.body46 <- distr::Norm(mean = 20.3, sd = 0.59) # us
energy$bc_main$for.body46 <- distr::Norm(mean = 47.84, sd = 1.64) # nj
timing$bc_main$for.cond.i <- distr::Norm(mean = 14.28, sd = 0.59) # us
energy$bc_main$for.cond.i <- distr::Norm(mean = 43.62, sd = 1.75) # nj
timing$bc_main$land.rhs.i <- distr::Norm(mean = 12.2, sd = 0.59) # us
energy$bc_main$land.rhs.i <- distr::Norm(mean = 37.43, sd = 1.64) # nj
timing$bc_main$land.end.i <- distr::Norm(mean = 10.11, sd = 0.42) # us
energy$bc_main$land.end.i <- distr::Norm(mean = 28.64, sd = 1.39) # nj
timing$bc_main$for.body.i <- distr::Norm(mean = 48.99, sd = 1.18) # us
energy$bc_main$for.body.i <- distr::Norm(mean = 151.36, sd = 3.28) # nj
timing$bc_main$bit_shifter.exit <- distr::Norm(mean = 16.19, sd = 0.48) # us
energy$bc_main$bit_shifter.exit <- distr::Norm(mean = 39.67, sd = 1.52) # nj
timing$bc_main$for.inc49 <- distr::Norm(mean = 30.53, sd = 0.9) # us
energy$bc_main$for.inc49 <- distr::Norm(mean = 86.17, sd = 2.4) # nj
timing$bc_main$for.end52 <- 2 # us
energy$bc_main$for.end52 <- distr::Norm(mean = 5.8, sd = 0.62) # nj
timing$bc_main$if.else53 <- distr::Norm(mean = 9.07, sd = 0.34) # us
energy$bc_main$if.else53 <- distr::Norm(mean = 24.12, sd = 1.24) # nj
timing$bc_main$if.then55 <- distr::Norm(mean = 5.06, sd = 0.24) # us
energy$bc_main$if.then55 <- distr::Norm(mean = 12.77, sd = 0.88) # nj
timing$bc_main$for.cond56 <- distr::Norm(mean = 9.07, sd = 0.34) # us
energy$bc_main$for.cond56 <- distr::Norm(mean = 24.12, sd = 1.24) # nj
timing$bc_main$for.body58 <- 2 # us
energy$bc_main$for.body58 <- distr::Norm(mean = 5.8, sd = 0.62) # nj
timing$bc_main$for.inc59 <- distr::Norm(mean = 30.53, sd = 0.9) # us
energy$bc_main$for.inc59 <- distr::Norm(mean = 86.17, sd = 2.4) # nj
timing$bc_main$for.end62 <- 2 # us
energy$bc_main$for.end62 <- distr::Norm(mean = 5.8, sd = 0.62) # nj
timing$bc_main$if.else63 <- distr::Norm(mean = 9.07, sd = 0.34) # us
energy$bc_main$if.else63 <- distr::Norm(mean = 24.12, sd = 1.24) # nj
timing$bc_main$if.then65 <- distr::Norm(mean = 5.06, sd = 0.24) # us
energy$bc_main$if.then65 <- distr::Norm(mean = 12.77, sd = 0.88) # nj
timing$bc_main$for.cond66 <- distr::Norm(mean = 9.07, sd = 0.34) # us
energy$bc_main$for.cond66 <- distr::Norm(mean = 24.12, sd = 1.24) # nj
timing$bc_main$for.body68 <- 2 # us
energy$bc_main$for.body68 <- distr::Norm(mean = 5.8, sd = 0.62) # nj
timing$bc_main$for.inc69 <- distr::Norm(mean = 30.53, sd = 0.9) # us
energy$bc_main$for.inc69 <- distr::Norm(mean = 86.17, sd = 2.4) # nj
timing$bc_main$for.end72 <- 2 # us
energy$bc_main$for.end72 <- distr::Norm(mean = 5.8, sd = 0.62) # nj
timing$bc_main$if.end <- 2 # us
energy$bc_main$if.end <- distr::Norm(mean = 5.8, sd = 0.62) # nj
timing$bc_main$if.end73 <- 2 # us
energy$bc_main$if.end73 <- distr::Norm(mean = 5.8, sd = 0.62) # nj
timing$bc_main$if.end74 <- 2 # us
energy$bc_main$if.end74 <- distr::Norm(mean = 5.8, sd = 0.62) # nj
timing$bc_main$if.end75 <- 2 # us
energy$bc_main$if.end75 <- distr::Norm(mean = 5.8, sd = 0.62) # nj
timing$bc_main$if.end76 <- 2 # us
energy$bc_main$if.end76 <- distr::Norm(mean = 5.8, sd = 0.62) # nj
timing$bc_main$if.end77 <- 2 # us
energy$bc_main$if.end77 <- distr::Norm(mean = 5.8, sd = 0.62) # nj
timing$bc_main$if.end78 <- 2 # us
energy$bc_main$if.end78 <- distr::Norm(mean = 5.8, sd = 0.62) # nj
timing$bc_main$for.inc79 <- distr::Norm(mean = 9.13, sd = 0.42) # us
energy$bc_main$for.inc79 <- distr::Norm(mean = 24.37, sd = 1.24) # nj
timing$bc_main$for.end81 <- distr::Norm(mean = 53.04, sd = 1.15) # us
energy$bc_main$for.end81 <- distr::Norm(mean = 143.05, sd = 3.04) # nj
timing$main$entry <- distr::Norm(mean = 9.16, sd = 0.54) # us
energy$main$entry <- distr::Norm(mean = 27.11, sd = 1.39) # nj

mean <- function(x) {
  if (is(x, "Norm"))
    distr::mean(x)
  else
    x
}

energy_vec <- lapply(energy$bc_main, FUN = mean)
energy_vec <- as.vector(unlist(energy_vec, use.names = FALSE))
hist(energy_vec, breaks = 30)
abline(v = fivenum(energy_vec), col = "skyblue")
fivenum(energy_vec)

outlier_upper_point <- quantile(energy_vec, .75) + 1.5 * IQR(energy_vec)
outliers <- energy_vec[energy_vec > outlier_upper_point]
outliers <- outliers / 2
outliers <- outliers[outliers > outlier_upper_point]
outliers <- outliers / 2

#
# energy_vec_above_threshold <- energy_vec[energy_vec >= quantile(energy_vec, 0.75)]
# length(energy_vec_above_threshold)
# energy_vec_above_threshold_halved <- energy_vec_above_threshold / 2
# length(energy_vec_above_threshold_halved)
# energy_vec_above_threshold_halved <- energy_vec_above_threshold_halved[energy_vec_above_threshold_halved >= quantile(energy_vec, 0.75)]
# length(energy_vec_above_threshold_halved)
# energy_vec_above_threshold_halved <- energy_vec_above_threshold_halved / 2
