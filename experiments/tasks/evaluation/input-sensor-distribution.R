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
distroptions("WarningArith" = FALSE)
set.seed(100)

.function <- rlang::env()
.function$name <- "Sensor Data Distribution"

# timing plot
opar <- par()
path.timing.mixture <- UnivarMixingDistribution(Binom(40, 0.4), 15 + Binom(30, 0.6), mixCoeff = c(0.7, 0.3))
q1 <- distr::q(path.timing.mixture)(.025)
mn <- distrEx::E(path.timing.mixture)
q2 <- distr::q(path.timing.mixture)(.975)
sd <- distrEx::sd(path.timing.mixture)
rnd <- round(c(q1, mn, q2), 2)
lab <- "Mixture(Binom(40, 0.4), 15 + Binom(30, 0.6), mixCoeff = c(0.7, 0.3))"
timingPlot <- paste0(".dots/timing/input.svg")
dir.create(dirname(timingPlot), showWarnings = FALSE, recursive = TRUE)
svg(timingPlot, width = 10.5, height = 3.5)
par(mfrow = c(1, 3))
plot(path.timing.mixture, mfColRow = FALSE, to.draw.arg = "d", bty = "7",
     panel.first = grid(lwd = 1), lwd = 1, vertical = FALSE,
     col.points = c("red", "black"), cex.points = 1.8, xlab = "",
     inner = list(paste("Probability Function Of", .function$name)))
abline(v = c(q1, mn, q2), col = c("skyblue", "coral", "skyblue"))
title(xlab = lab)
plot(path.timing.mixture, mfColRow = FALSE, to.draw.arg = "p", bty = "7",
     panel.first = grid(lwd = 1), lwd = 1, vertical = FALSE,
     col.points = c("red", "black"), cex.points = 1.8, xlab = "",
     inner = list(paste("CDF of", .function$name)))
title(xlab = lab)
abline(v = c(q1, mn, q2), col = c("skyblue", "coral", "skyblue"))
plot(path.timing.mixture, mfColRow = FALSE, to.draw.arg = "q", bty = "7",
     panel.first = grid(lwd = 1), lwd = 1, vertical = FALSE,
     col.points = c("red", "black"), cex.points = 1.8,
     inner = list(paste("Quantile Function of", .function$name)))
abline(h = c(q1, mn, q2), col = c("skyblue", "coral", "skyblue"))
suppressWarnings(par(opar))
dev.off()
browseURL(paste0('file://', file.path(getwd(), timingPlot)))
