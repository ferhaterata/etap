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

motionDetectionSensor_100cm_1MHz_sample1 <- read.csv("./experiments/profiling-eren/motion_detection_sensor/motion_detection_intermittent_data/config1/50mF/100cm/1Mhz/motion_detection_config1_50mF_1mhz_100cm_50sample1.csv")
motionDetectionSensor_100cm_1MHz_sample2 <- read.csv("./experiments/profiling-eren/motion_detection_sensor/motion_detection_intermittent_data/config1/50mF/100cm/1Mhz/motion_detection_config1_50mF_1mhz_100cm_50sample2.csv")
motionDetectionSensor_100cm_1MHz_sample3 <- read.csv("./experiments/profiling-eren/motion_detection_sensor/motion_detection_intermittent_data/config1/50mF/100cm/1Mhz/motion_detection_config1_50mF_1mhz_100cm_50sample3.csv")
motionDetectionSensor_100cm_1MHz_sample4 <- read.csv("./experiments/profiling-eren/motion_detection_sensor/motion_detection_intermittent_data/config1/50mF/100cm/1Mhz/motion_detection_config1_50mF_1mhz_100cm_50sample4.csv")
motionDetectionSensor_100cm_1MHz_sample5 <- read.csv("./experiments/profiling-eren/motion_detection_sensor/motion_detection_intermittent_data/config1/50mF/100cm/1Mhz/motion_detection_config1_50mF_1mhz_100cm_50sample5.csv")

motionDetectionSensor_100cm_1MHz <- c(motionDetectionSensor_100cm_1MHz_sample1$executionTime.s.,
                                      motionDetectionSensor_100cm_1MHz_sample2$executionTime.s.,
                                      motionDetectionSensor_100cm_1MHz_sample3$executionTime.s.,
                                      motionDetectionSensor_100cm_1MHz_sample4$executionTime.s.,
                                      motionDetectionSensor_100cm_1MHz_sample5$executionTime.s.)

motionDetectionSensor_100cm_16MHz_sample1 <- read.csv("./experiments/profiling-eren/motion_detection_sensor/motion_detection_intermittent_data/config1/50mF/100cm/16Mhz/motion_detection_50mF_config1_16mhz_100cm_50sample1.csv")
motionDetectionSensor_100cm_16MHz_sample2 <- read.csv("./experiments/profiling-eren/motion_detection_sensor/motion_detection_intermittent_data/config1/50mF/100cm/16Mhz/motion_detection_50mF_config1_16mhz_100cm_50sample2.csv")
motionDetectionSensor_100cm_16MHz_sample3 <- read.csv("./experiments/profiling-eren/motion_detection_sensor/motion_detection_intermittent_data/config1/50mF/100cm/16Mhz/motion_detection_50mF_config1_16mhz_100cm_50sample3.csv")
motionDetectionSensor_100cm_16MHz_sample4 <- read.csv("./experiments/profiling-eren/motion_detection_sensor/motion_detection_intermittent_data/config1/50mF/100cm/16Mhz/motion_detection_50mF_config1_16mhz_100cm_50sample4.csv")
motionDetectionSensor_100cm_16MHz_sample5 <- read.csv("./experiments/profiling-eren/motion_detection_sensor/motion_detection_intermittent_data/config1/50mF/100cm/16Mhz/motion_detection_50mF_config1_16mhz_100cm_50sample5.csv")

motionDetectionSensor_100cm_16MHz <- c(motionDetectionSensor_100cm_16MHz_sample1$executionTime.s.,
                                       motionDetectionSensor_100cm_16MHz_sample2$executionTime.s.,
                                       motionDetectionSensor_100cm_16MHz_sample3$executionTime.s.,
                                       motionDetectionSensor_100cm_16MHz_sample4$executionTime.s.,
                                       motionDetectionSensor_100cm_16MHz_sample5$executionTime.s.)

motionDetectionSensor_140cm_1MHz_sample1 <- read.csv("./experiments/profiling-eren/motion_detection_sensor/motion_detection_intermittent_data/config1/50mF/140cm/1Mhz/motion_detection_config1_50mF_1mhz_140cm_50sample1.csv")
motionDetectionSensor_140cm_1MHz_sample2 <- read.csv("./experiments/profiling-eren/motion_detection_sensor/motion_detection_intermittent_data/config1/50mF/140cm/1Mhz/motion_detection_config1_50mF_1mhz_140cm_50sample2.csv")
motionDetectionSensor_140cm_1MHz_sample3 <- read.csv("./experiments/profiling-eren/motion_detection_sensor/motion_detection_intermittent_data/config1/50mF/140cm/1Mhz/motion_detection_config1_50mF_1mhz_140cm_50sample3.csv")
motionDetectionSensor_140cm_1MHz_sample4 <- read.csv("./experiments/profiling-eren/motion_detection_sensor/motion_detection_intermittent_data/config1/50mF/140cm/1Mhz/motion_detection_config1_50mF_1mhz_140cm_50sample4.csv")
motionDetectionSensor_140cm_1MHz_sample5 <- read.csv("./experiments/profiling-eren/motion_detection_sensor/motion_detection_intermittent_data/config1/50mF/140cm/1Mhz/motion_detection_config1_50mF_1mhz_140cm_50sample5.csv")

motionDetectionSensor_140cm_1MHz <- c(motionDetectionSensor_140cm_1MHz_sample1$executionTime.s.,
                                      motionDetectionSensor_140cm_1MHz_sample2$executionTime.s.,
                                      motionDetectionSensor_140cm_1MHz_sample3$executionTime.s.,
                                      motionDetectionSensor_140cm_1MHz_sample4$executionTime.s.,
                                      motionDetectionSensor_140cm_1MHz_sample5$executionTime.s.)

motionDetectionSensor_140cm_16MHz_sample1 <- read.csv("./experiments/profiling-eren/motion_detection_sensor/motion_detection_intermittent_data/config1/50mF/140cm/16Mhz/motion_detection_config1_50mF_16mhz_140cm_50sample1.csv")
motionDetectionSensor_140cm_16MHz_sample2 <- read.csv("./experiments/profiling-eren/motion_detection_sensor/motion_detection_intermittent_data/config1/50mF/140cm/16Mhz/motion_detection_config1_50mF_16mhz_140cm_50sample2.csv")
motionDetectionSensor_140cm_16MHz_sample3 <- read.csv("./experiments/profiling-eren/motion_detection_sensor/motion_detection_intermittent_data/config1/50mF/140cm/16Mhz/motion_detection_config1_50mF_16mhz_140cm_50sample3.csv")
motionDetectionSensor_140cm_16MHz_sample4 <- read.csv("./experiments/profiling-eren/motion_detection_sensor/motion_detection_intermittent_data/config1/50mF/140cm/16Mhz/motion_detection_config1_50mF_16mhz_140cm_50sample4.csv")
motionDetectionSensor_140cm_16MHz_sample5 <- read.csv("./experiments/profiling-eren/motion_detection_sensor/motion_detection_intermittent_data/config1/50mF/140cm/16Mhz/motion_detection_config1_50mF_16mhz_140cm_50sample5.csv")

motionDetectionSensor_140cm_16MHz <- c(motionDetectionSensor_140cm_16MHz_sample1$executionTime.s.,
                                       motionDetectionSensor_140cm_16MHz_sample2$executionTime.s.,
                                       motionDetectionSensor_140cm_16MHz_sample3$executionTime.s.,
                                       motionDetectionSensor_140cm_16MHz_sample4$executionTime.s.,
                                       motionDetectionSensor_140cm_16MHz_sample5$executionTime.s.)

cat("CONFIG - 1 \n")
# bootstrap(motionDetectionSensor_100cm_1MHz, "100cm", "50mF", "1MHz")
# bootstrap(motionDetectionSensor_100cm_16MHz, "100cm", "50mF", "16MHz")
# bootstrap(motionDetectionSensor_140cm_1MHz, "140cm", "50mF", "1MHz")
# bootstrap(motionDetectionSensor_140cm_16MHz, "140cm", "50mF", "16MHz")

# HARVESTER PROFILE
motionDetectionSensor_100cm_1MHz_offtime_sample1 <- read.csv("./experiments/profiling-eren/motion_detection_sensor/motion_detection_intermittent_data/config1/50mF/100cm/1Mhz/motion_detection_config1_50mF_1mhz_100cm_50sample1_on_off_Time.csv")
motionDetectionSensor_100cm_1MHz_offtime_sample2 <- read.csv("./experiments/profiling-eren/motion_detection_sensor/motion_detection_intermittent_data/config1/50mF/100cm/1Mhz/motion_detection_config1_50mF_1mhz_100cm_50sample2_on_off_Time.csv")
motionDetectionSensor_100cm_1MHz_offtime_sample3 <- read.csv("./experiments/profiling-eren/motion_detection_sensor/motion_detection_intermittent_data/config1/50mF/100cm/1Mhz/motion_detection_config1_50mF_1mhz_100cm_50sample3_on_off_Time.csv")
motionDetectionSensor_100cm_1MHz_offtime_sample4 <- read.csv("./experiments/profiling-eren/motion_detection_sensor/motion_detection_intermittent_data/config1/50mF/100cm/1Mhz/motion_detection_config1_50mF_1mhz_100cm_50sample4_on_off_Time.csv")
motionDetectionSensor_100cm_1MHz_offtime_sample5 <- read.csv("./experiments/profiling-eren/motion_detection_sensor/motion_detection_intermittent_data/config1/50mF/100cm/1Mhz/motion_detection_config1_50mF_1mhz_100cm_50sample5_on_off_Time.csv")

motionDetectionSensor_100cm_offtime_1MHz <- c(motionDetectionSensor_100cm_1MHz_offtime_sample1$off.time,
                                              motionDetectionSensor_100cm_1MHz_offtime_sample2$off.time,
                                              motionDetectionSensor_100cm_1MHz_offtime_sample3$off.time,
                                              motionDetectionSensor_100cm_1MHz_offtime_sample4$off.time,
                                              motionDetectionSensor_100cm_1MHz_offtime_sample5$off.time)
bootstrap(motionDetectionSensor_100cm_offtime_1MHz, "100cm", "50mF", "1MHz")

motionDetectionSensor_140cm_1MHz_offtime_sample1 <- read.csv("./experiments/profiling-eren/motion_detection_sensor/motion_detection_intermittent_data/config1/50mF/140cm/1Mhz/motion_detection_config1_50mF_1mhz_140cm_50sample1_on_off_Time.csv")
motionDetectionSensor_140cm_1MHz_offtime_sample2 <- read.csv("./experiments/profiling-eren/motion_detection_sensor/motion_detection_intermittent_data/config1/50mF/140cm/1Mhz/motion_detection_config1_50mF_1mhz_140cm_50sample2_on_off_Time.csv")
motionDetectionSensor_140cm_1MHz_offtime_sample3 <- read.csv("./experiments/profiling-eren/motion_detection_sensor/motion_detection_intermittent_data/config1/50mF/140cm/1Mhz/motion_detection_config1_50mF_1mhz_140cm_50sample3_on_off_Time.csv")
motionDetectionSensor_140cm_1MHz_offtime_sample4 <- read.csv("./experiments/profiling-eren/motion_detection_sensor/motion_detection_intermittent_data/config1/50mF/140cm/1Mhz/motion_detection_config1_50mF_1mhz_140cm_50sample4_on_off_Time.csv")
motionDetectionSensor_140cm_1MHz_offtime_sample5 <- read.csv("./experiments/profiling-eren/motion_detection_sensor/motion_detection_intermittent_data/config1/50mF/140cm/1Mhz/motion_detection_config1_50mF_1mhz_140cm_50sample5_on_off_Time.csv")

motionDetectionSensor_140cm_offtime_1MHz <- c(motionDetectionSensor_140cm_1MHz_offtime_sample1$off.time,
                                              motionDetectionSensor_140cm_1MHz_offtime_sample2$off.time,
                                              motionDetectionSensor_140cm_1MHz_offtime_sample3$off.time,
                                              motionDetectionSensor_140cm_1MHz_offtime_sample4$off.time,
                                              motionDetectionSensor_140cm_1MHz_offtime_sample5$off.time)
bootstrap(motionDetectionSensor_140cm_offtime_1MHz, "140cm", "50mF", "1MHz")