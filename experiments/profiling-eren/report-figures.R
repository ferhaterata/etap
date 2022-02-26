rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
options("StartupBanner" = "off")
library(distr)
distr::distroptions("WarningArith" = FALSE)

set.seed(100)
BOOTSTRAP_COUNT <- 10000

bootstrap <- function(file, precision_count) {
  prof <- read.csv(paste0("experiments/profiling-eren/", file), header = TRUE, sep = ",")

  timing <- prof$executionTime.s. * 1000000  # s to us
  timing <- timing / precision_count
  bootstrap_dist <- vector()
  x_bar <- mean(timing)
  n <- length(timing)

  for (j in 1:BOOTSTRAP_COUNT) {
    bootstrap_dist <- append(bootstrap_dist, mean(sample(timing, n, replace = TRUE)))
  }
  se <- sd(bootstrap_dist) # se (standard error) is sd of sampling distribution
  mb <- mean(bootstrap_dist) # mean of the boot would be similar to sample mean
  population_distr <- distr::Norm(x_bar, se)

  plot(population_distr, to.draw.arg = "d", bty = "7",
       panel.first = grid(lwd = 1), lwd = 1, vertical = FALSE,
       col.points = c("red", "black"), cex.points = 1.8, col = "red")
  hist(bootstrap_dist, prob = TRUE, breaks = 50, add = TRUE)

  cat("\nTime @ 1 MHz (us)")
  cat("\nMode ", "Mean", "Sd")
  cat("\n", file, round(mean(bootstrap_dist), 2), round(sd(bootstrap_dist), 2), "\n")
  return(bootstrap_dist)
}


# bootstrap("dijkstra_normal_execution.csv", 1)
# dijkstra.real <- distr::Norm(mean = 315639.20, sd = 1.43) #us
# dijkstra.pred <- distr::Norm(mean = 304240.75, sd = 2.86) #us
# bootstrap("dotProduct_normal_execution.csv", 1)
# dotProduct.real <- distr::Norm(mean = 172867.80, sd = 0.58) #us
# dotProduct.pred <- distr::Norm(mean = 173392.36, sd = 1.3) #us
# bootstrap("fir_no_red_ld_normal_execution_normal_execution.csv", 1)
# fir_no_red_ld.real <- distr::Norm(mean = 675280.20, sd = 2.4) #us
# fir_no_red_ld.pred <- distr::Norm(mean = 674907.03, sd = 1.7) #us
# bootstrap("iirFilter_normal_execution_normal_execution.csv", 1)
# iirFilter.real <- distr::Norm(mean = 450178.4, sd = 1.27) #us
# iirFilter.pred <- distr::Norm(mean = 450157.03, sd = 1.175) #us
# bootstrap("lattice_synthesis_normal_execution_normal_execution.csv", 1)
# lattice_synthesis.real <- distr::Norm(mean = 861214.00, sd = 2.85) #us
# lattice_synthesis.pred <- distr::Norm(mean = 852414.79, sd = 1.07) #us
# bootstrap("jpeg_cosine_transform_normal_execution_normal_execution.csv", 1)
# jpeg_cosine_transform.real <- distr::Norm(mean = 508658.4, sd = 1.24) #us
# jpeg_cosine_transform.pred <- distr::Norm(mean = 36694.95, sd = 0.80) #us

# Clock is set 1MHz (1 x 10^6 cycle per second)
# 1 us: 1 cycle
# 1 ms: 1000 cycle
# 1 s:  1000000 cycle
bootstrap("bitcount/bitcount_normal_execution_50sample.csv", 1)
bitcount.real <- distr::Norm(mean = 6150038, sd = 13.43) #us
bitcount.pred <- distr::Norm(mean = 6145405, sd = 2.84)  #us

bootstrap("crc/crc_normal_execution_50sample.csv", 1)
crc.real <- distr::Norm(mean = 79927.33, sd = 0.28) #us
crc.pred <- distr::Norm(mean = 79952.75, sd = 0.30) #us

bootstrap("embench_ver2/dijkstra_normal_execution_normal_execution_ver2.csv", 1)
dijkstra.real <- distr::Norm(mean = 315693.0, sd = 0.99) #us
dijkstra.pred <- distr::Norm(mean = 304260.7, sd = 1.46) #us

bootstrap("embench_ver2/dotproduct_normal_execution_normal_execution_ver2.csv", 1)
dotProduct.real <- distr::Norm(mean = 386047.0, sd = 0.95) #us
dotProduct.pred <- distr::Norm(mean = 386399.2, sd = 2.62) #us

bootstrap("embench_ver2/fir_filter_normal_execution_normal_execution_ver2.csv", 1)
fir_filter.real <- distr::Norm(mean = 767670.8, sd = 1.91) #us
fir_filter.pred <- distr::Norm(mean = 765498.9, sd = 4.37) #us

bootstrap("embench_ver2/fir_no_red_normal_execution_normal_execution_ver2.csv", 1)
fir_no_red_ld.real <- distr::Norm(mean = 7282946, sd = 19.03) #us
fir_no_red_ld.pred <- distr::Norm(mean = 7277968, sd = 3.54) #us

bootstrap("embench_ver2/iir_filter_normal_execution_normal_execution_ver2.csv", 1)
iirFilter.real <- distr::Norm(mean = 450209.8, sd = 1.57) #us
iirFilter.pred <- distr::Norm(mean = 450157.0, sd = 1.19) #us

bootstrap("embench_ver2/jpeg_cosine_filter_normal_execution_normal_execution_ver2.csv", 1)
jpeg_cosine_transform.real <- distr::Norm(mean = 271552.4, sd = 0.6) #us
jpeg_cosine_transform.pred <- distr::Norm(mean = 249696.7, sd = 0.91) #us

bootstrap("embench_ver2/lattice_sythesis_filter_normal_execution_normal_execution_ver2.csv", 1)
lattice_synthesis.real <- distr::Norm(mean = 861073.2, sd = 2.92) #us
lattice_synthesis.pred <- distr::Norm(mean = 852414.8, sd = 0.99) #us

real <- c(distr::r(bitcount.real), distr::r(crc.real))
prediction <- c(distr::r(bitcount.pred), distr::r(crc.pred))

# cat("\nTime @ 1 MHz (us)")
# cat("\nMode ", "Mean", "Sd")
# cat("\n", .function$name, distr::mean(path.timing.mixture), distr::sd(path.timing.mixture))

