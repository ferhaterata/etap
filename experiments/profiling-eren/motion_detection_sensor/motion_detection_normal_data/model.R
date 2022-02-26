#config1

rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
options("StartupBanner" = "off")
library(distr)
distroptions("WarningArith" = FALSE)

set.seed(100)
BOOTSTRAP_COUNT <- 10000

bootstrap <- function(data, distance, capSize, frequency) {

  timing <- data * 1000000  # s to us
  outliers_high <- quantile(timing, .75) + 1.5 * IQR(timing)
  outliers_low <- quantile(timing, .25) - 1.5 * IQR(timing)
  timing <- timing[timing > outliers_low]
  timing <- timing[timing < outliers_high]
  bootstrap_dist <- vector()
  x_bar <- mean(timing)
  n <- length(timing)

  for (j in 1:BOOTSTRAP_COUNT) {
    bootstrap_dist <- append(bootstrap_dist, mean(sample(timing, n, replace = TRUE)))
  }
  se <- sd(bootstrap_dist) # se (standard error) is sd of sampling distribution
  mb <- mean(bootstrap_dist) # mean of the boot would be similar to sample mean
  population_distr <- distr::Norm(x_bar, se)

  # plot(population_distr, to.draw.arg = "d", bty = "7",
  #      panel.first = grid(lwd = 1), lwd = 1, vertical = FALSE,
  #      col.points = c("red", "black"), cex.points = 1.8, col = "red")
  # hist(bootstrap_dist, prob = TRUE, breaks = 50, add = TRUE)

  cat("\nTime @ ", frequency, " | ", distance, " | ", capSize, " (us)")
  cat("\n", "Mean", "Sd")
  cat("\n", round(mean(bootstrap_dist), 2), round(sd(bootstrap_dist), 2), "\n")
}

motionDetectionSensor_1MHz_sample1 <- read.csv("./experiments/profiling-eren/motion_detection_sensor/motion_detection_normal_data/motion_detection_conntinuous_50sample.csv")



cat("CONFIG - 1 \n")
bootstrap(motionDetectionSensor_1MHz_sample1, "-", "-", "1MHz")




