#!/usr/bin/env Rscript
default <- list(name = "default",
                timing = Binom(prob = 1, size = 1),
                energy = DiscreteDistribution(supp = 12, prob = 1))
class(default) <- "opcode"

name <- function(x) {
  UseMethod("name")
}

energy <- function(x) {
  UseMethod("energy")
}

timing <- function(x) {
  UseMethod("timing")
}

name.opcode <- function(opcode) {
  opcode$name
}

energy.opcode <- function(opcode) {
  opcode$energy
}

timing.opcode <- function(opcode) {
  opcode$timing
}

'name<-' <- function(x, value) {
  UseMethod('name<-', x)
}

'timing<-' <- function(x, value) {
  UseMethod('timing<-', x)
}

'energy<-' <- function(x, value) {
  UseMethod('energy<-', x)
}

'name<-.opcode' <- function(opcode, value) {
  opcode$name <- value
  opcode
}

'timing<-.opcode' <- function(opcode, value) {
  opcode$timing <- value
  opcode
}

'energy<-.opcode' <- function(opcode, value) {
  opcode$energy <- value
  opcode
}

plot.opcode <- function(opcode) {
  plot(opcode$timing)
  plot(opcode$energy)
}

print.opcode <- function(opcode) {
  print(opcode$name)
}
