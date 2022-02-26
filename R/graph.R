#!/usr/bin/env Rscript
suppressPackageStartupMessages(library("distr"))
suppressPackageStartupMessages(library("distrEx"))
distroptions("WarningArith" = FALSE)

cmdArgs <- commandArgs(TRUE)
XMIN <- as.double(cmdArgs[1])
XMAX <- as.double(cmdArgs[2])
YMAX <- as.double(cmdArgs[3])
INC <- as.double(cmdArgs[4])
FROM <- as.double(cmdArgs[5])
TO <- as.double(cmdArgs[6])

readCostFile <- function(filename) {
  data <- readLines(filename)
  costs <- vector()
  for (i in seq_along(data)) {
    costs <- c(strsplit(data[i], ";"), costs)
  }
  return(costs)
}

run <- function(inputDir = ".") {
  fileList <- list.files(inputDir)
  for (i in fileList) {
    costs <- readCostFile(paste0(inputDir, i))
    draw(costs, i)
  }
}

draw <- function(costs, funcName) {
  x <- seq(XMIN, XMAX, INC)
  distrs <- ""
  coeffs <- ""
  pathV <- vector()
  # Mixture
  for (path in costs) {
    conv1 <- paste0("d(", path[1], ")")
    pathV <- c(pathV, paste0(conv1, "(x)"))
    distrs <- paste0(distrs, ",", path[1])
    coeffs <- paste0(coeffs, ",", path[2])
  }
  distrs <- substring(distrs, 2)
  coeffs <- substring(coeffs, 2)
  x11(width = 18, height = 8)
  par(mfrow = c(1, 2))

  # Mixing Distribution
  M <- eval(parse(text = paste("UnivarMixingDistribution(", distrs, ",mixCoeff = c(", coeffs, "))")))

  #plot(x, (M)(x), bty = "7", panel.first = grid(lwd = 2), ylim = c(0, YMAX), type = "h", lwd = 1, main = paste("Probability Density Function of ", funcName))
  plot(M, to.draw.arg = "d", mfColRow = FALSE, bty = "7", panel.first = grid(lwd = 2), lwd = 1, inner = list(paste("Probability Function of ", funcName)),
       col.points = c("red", "black"), cex.points = 1.8, #pch.u = 5, pch.a = 19,
       vertical = FALSE, xlab = "")

  expectation <- E(M)
  title(xlab = paste0("E(x) = ", round(expectation, 2)))

  # Individual paths
  for (path in pathV) {
    K <- eval(parse(text = paste("function(x)", path)))
    #png("plots.png")
    lines(x, K(x), lty = 2, col = rgb(sample(0:255, 1), sample(0:255, 1), sample(0:255, 1), maxColorValue = 255))
    #dev.off()
  }

  a <- FROM
  b <- TO
  analysis <- "x"
  if (a < b) {
    analysis <- paste0("F(", b, ") - F(", a, ") = ", round(p(M)(b) - p(M)(a), 2))
    x.shade <- seq(a, b, INC)
    cord.x <- c(a, x.shade, b)
    cord.y <- c(0, d(M)(x.shade), 0)
    polygon(cord.x, cord.y, col = "skyblue") #steelblue
  } else {
    warning("From is less than to")
  }

  # Cumulative
  #plot(x, p(M)(x), bty = "7", panel.first = grid(lwd = 2), ylim = c(0, 1), xlab = analysis, type = "l", col = "red", main = "Cumulative Distribution Function")
  plot(M, to.draw.arg = "p", mfColRow = FALSE, bty = "7", panel.first = grid(lwd = 2), ylim = c(0, 1), lwd = 1, inner = list("Cumulative Distribution Function"),
       col.points = c("red", "black"), cex.points = 1.8, #pch.u = 5, pch.a = 19,
       vertical = FALSE, xlab = "")

  title(xlab = analysis)

  if (a < b) {
    x.shade <- seq(a, b, INC)
    cord.x <- c(a, x.shade, b)
    cord.y <- c(0, p(M)(x.shade), 0)
    polygon(cord.x, cord.y, col = "red", density = c(10, 20), angle = c(-45, 45))
  } else {
    warning("From is less than to")
  }
  abline(h = c(0.65, 0.95), lty = 2, col = "skyblue", lwd = 1)
  abline(h = c(0.5, 0), lty = 2, col = "skyblue", lwd = 1)
}

run("./.temp/")

#x11()
#library(png)
#pp <- readPNG(".get_sign.dot.png")
#plot.new()
#rasterImage(pp, 0, 0, 1, 1)

while (length(dev.list())) {
  Sys.sleep(0.1)
}