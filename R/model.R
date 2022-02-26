#!/usr/bin/env Rscript
options("StartupBanner" = "off")
library("distr")
distroptions("WarningArith" = FALSE)

openHTML <- function(x) browseURL(paste0('file://', file.path(getwd(), x)))
cmdArgs <- commandArgs(TRUE)
filename <- as.character(cmdArgs[1])
rendering <- as.character(cmdArgs[2])
#if (rendering != "svg" && rendering != "x11")
#  rendering <- "x11" #  stop(paste0("Rendering type is not supported: ", rendering))

run <- function(filename) {

  lines <- readLines(filename, skipNul = T)
  rows <- length(lines)

  opcodes <- list()
  for (i in seq_along(lines)) {
    line <- strsplit(lines[i], ";")
    line <- unlist(line)
    Timing <- eval(parse(text = line[2]))
    Energy <- eval(parse(text = line[3]))
    if (is.numeric(Energy))
      Energy <- Energy * DiscreteDistribution(1)
    if (is.numeric(Timing))
      Timing <- Timing * DiscreteDistribution(1)
    opcodes[[i]] <- list(name = line[1], timing = Timing, energy = Energy)
  }

  if (rendering == "svg") {
    modelSVG <- paste0(".model/timing.svg")
    dir.create(dirname(modelSVG), showWarnings = FALSE, recursive = TRUE)
    svg(modelSVG, width = 10.5, height = rows * 3.5)
  } else if (rendering == "x11")
    x11(width = 18, height = rows * 6)

  opar <- par(mfrow = c(rows, 3))      # make a copy of current settings
  for (opcode in opcodes) {
    tit <- paste0("Timing Model of ", opcode$name)
    plot(opcode$timing, mfColRow = FALSE, to.draw.arg = c("d", "p", "q"), bty = "7",
         panel.first = grid(lwd = 1), lwd = 1, vertical = FALSE, col.points = c("red", "black"), cex.points = 1.8)
  }

  par(opar)          # restore original settings
  if (rendering == "svg") {
    dev.off()
    openHTML(modelSVG)
  }

  if (rendering == "svg") {
    modelSVG <- paste0(".model/energy.svg")
    dir.create(dirname(modelSVG), showWarnings = FALSE, recursive = TRUE)
    svg(modelSVG, width = 10.5, height = rows * 3.5)
  } else if (rendering == "x11")
    x11(width = 18, height = rows * 6)

  opar <- par(mfrow = c(rows, 3))      # make a copy of current settings
  for (opcode in opcodes) {
    tit <- paste0("Energy Model of ", opcode$name)
    plot(opcode$energy, mfColRow = FALSE, to.draw.arg = c("d", "p", "q"), bty = "7",
         panel.first = grid(lwd = 1), lwd = 1, vertical = FALSE, col.points = c("red", "black"), cex.points = 1.8)
  }
  par(opar)          # restore original settings

  if (rendering == "svg") {
    dev.off()
    openHTML(modelSVG)
  }
}

run(filename)

if (rendering == "x11") {
  while (length(dev.list())) {
    Sys.sleep(0.1)
  }
}
