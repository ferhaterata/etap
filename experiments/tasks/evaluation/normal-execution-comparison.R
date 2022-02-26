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

# timing plot
opar <- par()

real <- function(x) dnorm(x, 6150.038, 0.01343)
prof <- read.csv("experiments/profiling-eren/bitcount/bitcount_normal_execution_50sample.csv", header = TRUE, sep = ",")
data <- prof$executionTime.s. * 1000  # s to s

prediction <- distr::Norm(6145.405, 0.01)
q1 <- distr::q(prediction)(.025)
mn <- distrEx::E(prediction)
q2 <- distr::q(prediction)(.975)
sd <- distrEx::sd(prediction)
rnd <- round(c(q1, mn, q2), 2)
lab <- paste0("95% Confidence Interval (", rnd[1], ", ", rnd[2], ", ", rnd[3], ")")

timingPlot <- paste0(".dots/timing/bitcount-normal.pdf")
dir.create(dirname(timingPlot), showWarnings = FALSE, recursive = TRUE)
pdf(timingPlot, width = 7, height = 7)
par(mfrow = c(1, 1))


plot(prediction, mfColRow = FALSE, to.draw.arg = "d", bty = "7",
     # col.main = topo.colors(1),
     panel.first = grid(lwd = 1), lwd = 1, vertical = FALSE,
     col.points = c("red", "black"), cex.points = 1.8, xlab = "", ylab = "", main = "",
     xlim = c(6145, 6151))
curve(real, n = 2000, col = topo.colors(2), add = TRUE)
hist(data, col = "red", prob = TRUE, breaks = 10, add = TRUE)
# abline(v = c(q1, mn, q2), col = c("skyblue", "coral", "skyblue"))
title(xlab = lab)
legend("topleft", legend = c("real", "prediction"),
       # col = c("blue", "red", "black"),
       col = topo.colors(2),
       # pch = c("o", "*"),
       lty = c(1, 2),
       box.lwd = 0,
       box.lty = 0,
       # ncol = 1,
       inset = c(0.05, 0.05)
)

suppressWarnings(par(opar))
dev.off()
# browseURL(paste0('file://', file.path(getwd(), timingPlot)))
