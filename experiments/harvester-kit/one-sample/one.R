rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
options("StartupBanner" = "off")
library(distr)
distroptions("WarningArith" = FALSE)
options(scipen = 999)
set.seed(100)

# (1000uF) 1000 x 10^-3 mF; 1mF = 1 x 10^-3 = 0.001 F
# (50mF) 50 x 10^-3 F = 0.05 F
CAPACITANCE <- 0.05 # F
DISTANCE <- 60 # cm
BOOTSTRAP_COUNT <- 10000

file <- paste0("experiments/harvester-kit/one-sample/", DISTANCE, "cm_harvester_data")
trace <- read.csv(paste0(file, ".csv"), header = TRUE, sep = ",")
row_sub <- apply(trace, 1, function(row) all(row != 0)) # remove rows with 0
trace <- subset(trace, row_sub)

voltage <- as.double(trace$Voltage.V.) # volt
time <- as.double(trace$Time.ms.) / 1000 # ms to s
power <- as.double(trace$Power.Watt.) # watt

max <- 1 / 2 * CAPACITANCE * 1.25^2 # j

out_file <- paste0(file, ".out.csv")
cat(file = out_file, sep = ",", "Time.s", "Voltage.V", "Power.Watt", "Energy.J\n")

# max(w_1, w_2) * dt - (dw x dt/2)
t1 <- 0
w1 <- 0
e1 <- 0
e <- 0
time_stamps <- list(0)
for (i in seq_along(time)) {
  v <- voltage[i]
  t2 <- time[i]
  w2 <- power[i]
  dt <- abs(t1 - t2)
  dw <- abs(w1 - w2)
  e2 <- max(w1, w2) * dt - dw * dt / 2
  cat(file = out_file, append = TRUE, sep = ",", t2, v, w2, paste0(e1 + e2, "\n"))
  e <- e + e2
  if (e > max) {
    e <- 0
    time_stamps <- append(time_stamps, t2)
  }
  t1 <- t2
  w1 <- w2
  e1 <- e1 + e2
}

if (length(time_stamps) != 1) {
  time_intervals <- vector()
  for (i in 1:(length(time_stamps) - 1)) {
    time_intervals <- append(time_intervals, (time_stamps[[i + 1]] - time_stamps[[i]]) * 1000) # s -> ms
  }
  sample_times_mean <- mean(time_intervals)

  # trace <- read.csv(out_file, header = TRUE, sep = ",")
  # plot(as.double(trace$Time.s), as.double(trace$Energy.J), type = "l", lty = 1)

  bootstrap_dist <- vector()
  n <- length(time_intervals)
  for (j in 1:BOOTSTRAP_COUNT) {
    bootstrap_dist <- append(bootstrap_dist, (mean(sample(time_intervals, n, replace = TRUE))))
  }
  se <- sd(bootstrap_dist) # se (standard error) is sd of sampling distribution
  mb <- mean(bootstrap_dist) # mean of the boot would be similar to sample mean

  # inference of the population distribution
  (population_distr <- distr::Norm(round(sample_times_mean, 2), round(se, 2)))
  distr::plot(population_distr, to.draw.arg = "d", bty = "7",
              panel.first = grid(lwd = 1), lwd = 1, vertical = FALSE,
              col.points = c("red", "black"), cex.points = 1.8, col = "red", prob = TRUE)
  hist(bootstrap_dist, prob = TRUE, breaks = 100, add = TRUE)
  cat("95% Confidence Interval\n")
  (q <- round(quantile(bootstrap_dist, c(0.025, 0.975)), 2))
} else
  warning("sampling time interval is not enough to model this capacitor size!")