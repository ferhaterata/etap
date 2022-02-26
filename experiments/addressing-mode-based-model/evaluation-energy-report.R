rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
options("StartupBanner" = "off")
library(distr)
library(ggplot2)
distroptions("WarningArith" = FALSE)

set.seed(100)
LPM_CURRENT <- 250000 # nA
BLOCK_COUNT <- 8
BOOTSTRAP_COUNT <- 10000

forloop_time <- distr::Norm(mean = 2310614078, sd = 45932124) # ns
forloop_energy <- distr::Norm(mean = 3128.09, sd = 62.13) # uj

# energy_trace <- read.csv("experiments/addressing-mode-based-model/.energytrace/EnergyTrace_ADD_addressing_modes_21_2021_03_10_151035_new_haven.csv", header = TRUE, sep = ",")
# energy_trace <- read.csv("experiments/addressing-mode-based-model/.energytrace/EnergyTrace_ADD_addressing_modes_50_2021_03_10_131920.csv", header = TRUE, sep = ",")
energy_trace <- read.csv("experiments/addressing-mode-based-model/.energytrace/EnergyTrace_MOV_addressing_modes_50_2021_03_10_123232_new_haven.csv", header = TRUE, sep = ",")
# energy_trace <- read.csv("experiments/addressing-mode-based-model/.energytrace/EnergyTrace_MOV_addressing_modes_30_2021_03_09_164332_new_haven.csv", header = TRUE, sep = ",")
# energy_trace <- read.csv("experiments/addressing-mode-based-model/.energytrace/EnergyTrace_MOV_addressing_modes_20_2021_03_09_160257_new_haven.csv", header = TRUE, sep = ",")
# energy_trace <- energy_trace[[1]]
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

# block_time_dist_list <- list()
# for (i in 1:BLOCK_COUNT) {
#   bb <- block_time_list[[i]]  # ns
#   x_bar <- mean(bb)
#   cat("\nblock_time:", i, "sample mean: ", x_bar, "\n\t")
#   n <- length(bb)
#   bootstrap_dist <- vector()
#   for (j in 1:BOOTSTRAP_COUNT) {
#     bootstrap_dist <- append(bootstrap_dist, mean(sample(bb, n, replace = TRUE)))
#   }
#   se <- sd(bootstrap_dist) # se (standard error) is sd of sampling distribution
#   mb <- mean(bootstrap_dist) # mean of the boot would be similar to sample mean
#   cat("se : ", se)
#   cat("\nbs mean : ", mb, "\n")
#   population_distr <- distr::Norm(x_bar, se)
#   mov_100000times <- population_distr - forloop_time
#   mov <- mov_100000times / 100000  # for 1 instruction
#   mov <- mov / 1000 # ns to us
#
#   # plot(population_distr, to.draw.arg = "d", bty = "7",
#   #      panel.first = grid(lwd = 1), lwd = 1, vertical = FALSE,
#   #      col.points = c("red", "black"), cex.points = 1.8, col = "red")
#   # hist(bootstrap_dist, prob = TRUE, breaks = 100, add = TRUE)
#
#   block_time_dist_list[[i]] <- mov
# }

block_energy_dist_list <- list()
# for (i in 1:BLOCK_COUNT) {
bb <- block_energy_list[[i <- 5]]  # uj
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

# plot(population_distr, to.draw.arg = "d", bty = "7",
#      panel.first = grid(lwd = 1), lwd = 1, vertical = FALSE,
#      col.points = c("red", "black"), cex.points = 1.8, col = "red")
# hist(bootstrap_dist, prob = TRUE, breaks = 100, add = TRUE)

opar <- par()
timingPlot <- paste0(".evaluation/energy-100.pdf")
dir.create(dirname(timingPlot), showWarnings = FALSE, recursive = TRUE)
pdf(timingPlot, width = 7, height = 7)
par(mfrow = c(1, 1))

library(ggplot2)

loop_distr <- function(x) dnorm(x, distr::mean(forloop_energy), distr::sd(forloop_energy))
pop_distr <- function(x) dnorm(x, distr::mean(population_distr), distr::sd(population_distr))
mov_100000 <- function(x) dnorm(x, distr::mean(mov_100000times), distr::sd(mov_100000times))

base <- ggplot() +
  xlim(2900, 3500) +
  theme(legend.position = "right", legend.justification = c(.1, .1))
base +
  geom_function(aes(colour = "X ~ Loop overhead (100K inst.)"), fun = loop_distr) +
  geom_function(aes(colour = "Y ~ 100K inst. w/ loop overhead"), fun = pop_distr)

# plot(loop_distr, bty = "7",
#      col = topo.colors(10)[1],
#      panel.first = grid(lwd = 1), lwd = 1, xlab = "", ylab = "", main = "",
#      xlim = c(2900, 3500), ylim = c(0, 0.055))
# curve(pop_distr, n = 2000, col = topo.colors(10)[5], add = TRUE)
# curve(mov_100000, n = 2000, col = topo.colors(10)[10], add = TRUE)
# hist(data, col = "red", prob = TRUE, breaks = 10, add = TRUE)
# abline(v = c(q1, mn, q2), col = c("skyblue", "coral", "skyblue"))
# title(xlab = lab)
# legend("topleft", legend = c("X ~ Loop overhead (100K inst.)", "Y ~ 100K inst. w/ loop overhead", "convolve(Y-X)"),
#        # col = c("blue", "red", "black"),
#        col = c(topo.colors(10)[1], topo.colors(10)[5], topo.colors(10)[10]),
#        # pch = c("o", "*"),
#        lty = c(1, 1, 1),
#        box.lwd = 0,
#        box.lty = 0,
#        # ncol = 1,
#        inset = c(0.05, 0.05)
# )

suppressWarnings(par(opar))
dev.off()

block_energy_dist_list[[i]] <- mov
for (k in bootstrap_dist) {
  k <- k - mean(forloop_energy)
  k <- k / 100000 # for one instruction
  k <- k * 1000 # uj to nj
  cat(k, ",", file = paste0("addressmode_", i), append = TRUE)
}
# }

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
  # cat("\n00 0 ", round(mean(block_energy_dist_list[[1]]), 2), round(sd(block_energy_dist_list[[1]]), 2))
  # cat("\n00 1 ", round(mean(block_energy_dist_list[[2]]), 2), round(sd(block_energy_dist_list[[2]]), 2))
  # cat("\n01 0 ", round(mean(block_energy_dist_list[[3]]), 2), round(sd(block_energy_dist_list[[3]]), 2))
  # cat("\n01 1 ", round(mean(block_energy_dist_list[[4]]), 2), round(sd(block_energy_dist_list[[4]]), 2))
  cat("\n10 0 ", round(mean(block_energy_dist_list[[5]]), 2), round(sd(block_energy_dist_list[[5]]), 2))
  # cat("\n10 1 ", round(mean(block_energy_dist_list[[6]]), 2), round(sd(block_energy_dist_list[[6]]), 2))
  # cat("\n11 0 ", round(mean(block_energy_dist_list[[7]]), 2), round(sd(block_energy_dist_list[[7]]), 2))
  # cat("\n11 1 ", round(mean(block_energy_dist_list[[8]]), 2), round(sd(block_energy_dist_list[[8]]), 2))
}

# print_addressing_modes_time()
print_addressing_modes_energy()
