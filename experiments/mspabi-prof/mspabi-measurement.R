rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
options("StartupBanner" = "off")
library(distr)
distroptions("WarningArith" = FALSE)

set.seed(100)
LPM_CURRENT <- 250000 # nA
BLOCK_COUNT <- 1
BOOTSTRAP_COUNT <- 10000


# 10000 for loop nv i
forloop_time<-distr::Norm(205926960 ,4148805) # ns
forloop_energy<-distr::Norm(213.67, 3.32) # uj

energy_trace <- read.csv("./experiments/mspabi-prof/.energytrace/EnergyTrace_2021_04_20_133830_MulABI_10000loop_50times.csv", header = TRUE, sep = ",")

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
  bb <- block_time_list[[i]]  # ns
  x_bar <- mean(bb)
  cat("\nblock_time:", i, "sample mean: ", x_bar, "\n\t")
  n <- length(bb)
  bootstrap_dist <- vector()
  for (j in 1:BOOTSTRAP_COUNT) {
    bootstrap_dist <- append(bootstrap_dist, mean(sample(bb, n, replace = TRUE)))
  }
  se <- sd(bootstrap_dist) # se (standard error) is sd of sampling distribution
  mb <- mean(bootstrap_dist) # mean of the boot would be similar to sample mean
  cat("se : ", se)
  cat("\nbs mean : ", mb, "\n")
  population_distr <- distr::Norm(x_bar, se)
  mov_100000times <- population_distr - forloop_time
  mov <- mov_100000times / 10000  # for 1 instruction
  mov <- mov / 1000 # ns to us

  # plot(population_distr, to.draw.arg = "d", bty = "7",
  #      panel.first = grid(lwd = 1), lwd = 1, vertical = FALSE,
  #      col.points = c("red", "black"), cex.points = 1.8, col = "red")
  # hist(bootstrap_dist, prob = TRUE, breaks = 100, add = TRUE)

  block_time_dist_list[[i]] <- mov
}

block_energy_dist_list <- list()
for (i in 1:BLOCK_COUNT) {
  bb <- block_energy_list[[i]]  # uj
  x_bar <- mean(bb)
  cat("\nblock_energy:", i, "sample mean: ", x_bar, "\n\t")
  n <- length(bb)
  bootstrap_dist <- vector()
  for (j in 1:BOOTSTRAP_COUNT) {
    bootstrap_dist <- append(bootstrap_dist, mean(sample(bb, n, replace = TRUE)))
  }
  se <- sd(bootstrap_dist) # se (standard error) is sd of sampling distribution
  mb <- mean(bootstrap_dist) # mean of the boot would be similar to sample mean
  cat("se : ", se)
  cat("\nbs mean : ", mb, "\n")
  population_distr <- distr::Norm(x_bar, se)
  mov_100000times <- population_distr - forloop_energy
  mov <- mov_100000times / 10000  # for 1 instruction
  mov <- mov * 1000 # uj to nj

  plot(population_distr, to.draw.arg = "d", bty = "7",
       panel.first = grid(lwd = 1), lwd = 1, vertical = FALSE,
       col.points = c("red", "black"), cex.points = 1.8, col = "red")
  hist(bootstrap_dist, prob = TRUE, breaks = 100, add = TRUE)


  block_energy_dist_list[[i]] <- mov
  for (k in bootstrap_dist) {
    k <- k - mean(forloop_energy)
    k <- k / 100000 # for one instruction
    k <- k * 1000 # uj to nj
    cat(k, ",", file = paste0("addressmode_", i), append = TRUE)
  }
}

print_addressing_modes_time <- function() {
  cat("\nTime @ 1 MHz (us)")
  cat("\nMode ", "Mean", "Sd")
  cat("\nmspabi ", round(mean(block_time_dist_list[[1]]), 2), round(sd(block_time_dist_list[[1]]), 2))
}

print_addressing_modes_energy <- function() {
  cat("\nEnergy (nj)")
  cat("\nMode ", "Mean", "Sd")
  cat("\nmspabi", round(mean(block_energy_dist_list[[1]]), 2), round(sd(block_energy_dist_list[[1]]), 2))
}

 print_addressing_modes_time()
print_addressing_modes_energy()


