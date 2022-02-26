rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
options("StartupBanner" = "off")
library(distr)
distroptions("WarningArith" = FALSE)

set.seed(100)
LPM_CURRENT <- 220000 # nA
BLOCK_COUNT <- 1
BOOTSTRAP_COUNT <- 100000
PRECISION_LOOP_COUNT <- 100
forloop_time <- 0 # ns
forloop_energy <- 0 # uj

energy_trace <- read.csv("experiments/checkpoint-restore/.energytrace/EnergyTrace_2021_04_03_220145_numan.csv", header = TRUE, sep = ",")
names(energy_trace) <- list("Time(ns)", "Current(nA)", "Voltage(mV)", "Energy(uJ)")

energy_trace <- energy_trace[energy_trace$`Current(nA)` != "0",] # remove initial 0 current

time_list <- as.double(energy_trace$`Time(ns)`)
current_list <- as.double(energy_trace$`Current(nA)`)
energy_list <- as.double(energy_trace$`Energy(uJ)`)

block_counter <- 0
block_time_list <- list()
block_time_start <- time_list[[1]]
block_time_finish <- 0

block_energy_list <- list()
block_energy_start <- energy_list[[1]]
block_energy_finish <- 0

lpm <- 0
for (i in seq_along(current_list)) {
  if (current_list[[i]] < LPM_CURRENT) {
    # LPM start time
    if (!lpm) {

      block_time_finish <- time_list[[i]]
      block_energy_finish <- energy_list[[i]]

      b_name <- paste0("block:", block_counter)

      block_time_list[[b_name]] <- append(block_time_list[[b_name]], (block_time_finish - block_time_start))
      block_energy_list[[b_name]] <- append(block_energy_list[[b_name]], (block_energy_finish - block_energy_start))

      block_counter <- block_counter + 1
      if (block_counter == BLOCK_COUNT) {
        block_counter <- 0
      }
    }
    lpm <- 1
  }else {
    # LPM end time
    if (lpm) {
      block_time_start <- time_list[[i]]
      block_energy_start <- energy_list[[i]]
    }
    lpm <- 0
  }
}

block_time_dist_list <- list()
for (i in 1:BLOCK_COUNT) {
  bootstrap_dist <- vector()
  bb <- block_time_list[[i]]  # ns
  x_bar <- mean(bb)
  cat("\nblock_time:", i, "sample mean: ", x_bar, "\n\t")
  n <- length(bb)
  for (j in 1:BOOTSTRAP_COUNT) {
    bootstrap_dist <- append(bootstrap_dist, mean(sample(bb, n, replace = TRUE)))
  }
  se <- sd(bootstrap_dist) # se (standard error) is sd of sampling distribution
  mb <- mean(bootstrap_dist) # mean of the boot would be similar to sample mean
  cat("sd : ", se)
  cat("\nbs mean : ", mb, "\n")
  population_distr <- distr::Norm(x_bar, se)
  #population_distr<-population_distr-forloop
  population_distr <- population_distr / PRECISION_LOOP_COUNT # for 1 checkpoint
  # mov <- mov / 1000 # ns to us

  plot(population_distr, to.draw.arg = "d", bty = "7",
       panel.first = grid(lwd = 1), lwd = 1, vertical = FALSE,
       col.points = c("red", "black"), cex.points = 1.8, col = "red")
  hist(bootstrap_dist, prob = TRUE, breaks = 50, add = TRUE)

  block_time_dist_list[[i]] <- population_distr
}

block_energy_dist_list <- list()
for (i in 1:BLOCK_COUNT) {
  bootstrap_dist <- vector()
  bb <- block_energy_list[[i]]  # uj
  x_bar <- mean(bb)
  cat("\nblock_energy:", i, "sample mean: ", x_bar, "\n\t")
  n <- length(bb)
  for (j in 1:BOOTSTRAP_COUNT) {
    bootstrap_dist <- append(bootstrap_dist, mean(sample(bb, n, replace = TRUE)))
  }
  se <- sd(bootstrap_dist) # se (standard error) is sd of sampling distribution
  mb <- mean(bootstrap_dist) # mean of the boot would be similar to sample mean
  cat("sd : ", se)
  cat("\nbs mean : ", mb, "\n")
  population_distr <- distr::Norm(x_bar, se)
  population_distr <- population_distr / PRECISION_LOOP_COUNT # for 1 checkpoint

  plot(population_distr, to.draw.arg = "d", bty = "7",
       panel.first = grid(lwd = 1), lwd = 1, vertical = FALSE,
       col.points = c("red", "black"), cex.points = 1.8, col = "red")
  hist(bootstrap_dist, prob = TRUE, breaks = 100, add = TRUE)

  block_energy_dist_list[[i]] <- population_distr
}

print_addressing_modes_time <- function() {
  cat("\nTime @ 1 MHz (ns)")
  cat("\nMode ", "Mean", "Sd")
  cat("\nRestore ", round(mean(block_time_dist_list[[1]]), 4), round(sd(block_time_dist_list[[1]]), 2))
}

print_addressing_modes_energy <- function() {
  cat("\nEnergy (uj)")
  cat("\nMode ", "Mean", "Sd")
  cat("\nRestore ", round(mean(block_energy_dist_list[[1]]), 4), round(sd(block_energy_dist_list[[1]]), 2))
}

print_addressing_modes_time()
print_addressing_modes_energy()
