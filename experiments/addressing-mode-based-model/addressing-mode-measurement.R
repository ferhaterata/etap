rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
options("StartupBanner" = "off")
library(distr)
distroptions("WarningArith" = FALSE)

set.seed(100)
LPM_CURRENT <- 180000 # nA
BLOCK_COUNT <- 8
BOOTSTRAP_COUNT <- 10000

# 1 MHz
# forloop_time <- distr::Norm(mean = 2310614078, sd = 45932124) # ns
# forloop_energy <- distr::Norm(mean = 3128.09, sd = 62.13) # uj

# 4 MHz 100000loop
# forloop_time <- distr::Norm(mean = 679040941, sd = 3968698) # ns
# forloop_energy <- distr::Norm(mean = 1276.32, sd = 3) # uj

# 8 MHz 100000loop
# forloop_time <- distr::Norm(mean = 392192745, sd = 4600674) # ns
# forloop_energy <- distr::Norm(mean = 1077.3, sd = 3.47) # uj

# 16 MHz 100000loop
forloop_time <- distr::Norm(mean = 536454471, sd = 4511244) # ns
forloop_energy <- distr::Norm(mean = 1493.19, sd = 3.66) # uj

# energy_trace <- read.csv("experiments/addressing-mode-based-model/.energytrace/EnergyTrace_ADD_addressing_modes_21_2021_03_10_151035_new_haven.csv", header = TRUE, sep = ",")
# energy_trace <- read.csv("experiments/addressing-mode-based-model/.energytrace/EnergyTrace_ADD_addressing_modes_50_2021_03_10_131920.csv", header = TRUE, sep = ",")
# energy_trace <- read.csv("experiments/addressing-mode-based-model/.energytrace/EnergyTrace_MOV_addressing_modes_50_2021_03_10_123232_new_haven.csv", header = TRUE, sep = ",")
# energy_trace <- read.csv("experiments/addressing-mode-based-model/.energytrace/EnergyTrace_MOV_addressing_modes_30_2021_03_09_164332_new_haven.csv", header = TRUE, sep = ",")
# energy_trace <- read.csv("experiments/addressing-mode-based-model/.energytrace/EnergyTrace_MOV_addressing_modes_20_2021_03_09_160257_new_haven.csv", header = TRUE, sep = ",")
# energy_trace <- energy_trace[[1]]

# CLOCK RATE CSV
# energy_trace <- read.csv("experiments/addressing-mode-based-model/.energytrace/4MHz_EnergyTrace_2021_07_27_200521.csv", header = TRUE, sep = ";")
# energy_trace <- read.csv("experiments/addressing-mode-based-model/.energytrace/8MHz_EnergyTrace_2021_07_27_202742.csv", header = TRUE, sep = ";")
energy_trace <- read.csv("experiments/addressing-mode-based-model/.energytrace/16mhz_EnergyTrace_2021_07_27_183202.csv", header = TRUE, sep = ";")


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
  mov <- mov_100000times / 100000  # for 1 instruction
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
  mov <- mov_100000times / 100000  # for 1 instruction
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
  cat("\n00 0 ", round(mean(block_time_dist_list[[1]]), 2), round(sd(block_time_dist_list[[1]]), 2))
  cat("\n00 1 ", round(mean(block_time_dist_list[[2]]), 2), round(sd(block_time_dist_list[[2]]), 2))
  cat("\n01 0 ", round(mean(block_time_dist_list[[3]]), 2), round(sd(block_time_dist_list[[3]]), 2))
  cat("\n01 1 ", round(mean(block_time_dist_list[[4]]), 2), round(sd(block_time_dist_list[[4]]), 2))
  cat("\n10 0 ", round(mean(block_time_dist_list[[5]]), 2), round(sd(block_time_dist_list[[5]]), 2))
  cat("\n10 1 ", round(mean(block_time_dist_list[[6]]), 2), round(sd(block_time_dist_list[[6]]), 2))
  cat("\n11 0 ", round(mean(block_time_dist_list[[7]]), 2), round(sd(block_time_dist_list[[7]]), 2))
  cat("\n11 1 ", round(mean(block_time_dist_list[[8]]), 2), round(sd(block_time_dist_list[[8]]), 2))

}

print_addressing_modes_energy <- function() {
  cat("\nEnergy (nj)")
  cat("\nMode ", "Mean", "Sd")
  cat("\n00 0 ", round(mean(block_energy_dist_list[[1]]), 2), round(sd(block_energy_dist_list[[1]]), 2))
  cat("\n00 1 ", round(mean(block_energy_dist_list[[2]]), 2), round(sd(block_energy_dist_list[[2]]), 2))
  cat("\n01 0 ", round(mean(block_energy_dist_list[[3]]), 2), round(sd(block_energy_dist_list[[3]]), 2))
  cat("\n01 1 ", round(mean(block_energy_dist_list[[4]]), 2), round(sd(block_energy_dist_list[[4]]), 2))
  cat("\n10 0 ", round(mean(block_energy_dist_list[[5]]), 2), round(sd(block_energy_dist_list[[5]]), 2))
  cat("\n10 1 ", round(mean(block_energy_dist_list[[6]]), 2), round(sd(block_energy_dist_list[[6]]), 2))
  cat("\n11 0 ", round(mean(block_energy_dist_list[[7]]), 2), round(sd(block_energy_dist_list[[7]]), 2))
  cat("\n11 1 ", round(mean(block_energy_dist_list[[8]]), 2), round(sd(block_energy_dist_list[[8]]), 2))
}

print_addressing_modes_time()
print_addressing_modes_energy()

# Time @ 4 MHz (us)
# Mode  Mean Sd
# 00 0  0.3 0.08
# 00 1  0.84 0.07
# 01 0  0.83 0.07
# 01 1  1.43 0.08
# 10 0  0.63 0.09
# 10 1  1.06 0.07
# 11 0  0.7 0.08
# 11 1  1.2 0.08
# Energy (nj)
# Mode  Mean Sd
# 00 0  2.77 0.05
# 00 1  3.56 0.08
# 01 0  4.05 0.06
# 01 1  4.37 0.11
# 10 0  3.15 0.07
# 10 1  3.94 0.11
# 11 0  3.66 0.05
# 11 1  1.76 0.12

# Time @ 8 MHz (us)
# Mode  Mean Sd
# 00 0  0.24 0.08
# 00 1  0.48 0.09
# 01 0  0.61 0.08
# 01 1  0.75 0.09
# 10 0  0.46 0.08
# 10 1  0.67 0.08
# 11 0  0.49 0.08
# 11 1  0.69 0.09
# Energy (nj)
# Mode  Mean Sd
# 00 0  2.61 0.07
# 00 1  3.22 0.1
# 01 0  3.82 0.09
# 01 1  3.84 0.13
# 10 0  2.94 0.07
# 10 1  3.6 0.13
# 11 0  3.42 0.06
# 11 1  1.32 0.11

# Time @ 16 MHz (us)
# Mode  Mean Sd
# 00 0  2 0.06
# 00 1  2.15 0.06
# 01 0  2.76 0.07
# 01 1  2.23 0.07
# 10 0  2.12 0.07
# 10 1  2.22 0.06
# 11 0  2.63 0.06
# 11 1  3.03 0.08
# Energy (nj)
# Mode  Mean Sd
# 00 0  6.5 0.04
# 00 1  6.96 0.05
# 01 0  8.72 0.08
# 01 1  7.44 0.08
# 10 0  6.77 0.07
# 10 1  7.19 0.07
# 11 0  8.36 0.04
# 11 1  10.35 0.06
