rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
options("StartupBanner" = "off")
library(distr)
distroptions("WarningArith" = FALSE)

set.seed(100)
BOOTSTRAP_COUNT <- 10000

bootstrap <- function(file, precision_count, col_name = "executionTime.s.") {
  prof <- read.csv(file)

  timing <- prof[[col_name]] * 1000000  # s to us
  timing <- timing / precision_count
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

  plot(population_distr, to.draw.arg = "d", bty = "7",
       panel.first = grid(lwd = 1), lwd = 1, vertical = FALSE,
       col.points = c("red", "black"), cex.points = 1.8, col = "red")
  hist(bootstrap_dist, prob = TRUE, breaks = 50, add = TRUE)

  cat("\nTime @ 1 MHz (us)")
  cat("\nMode ", "Mean", "Sd")
  cat("\n", file, col_name, round(mean(bootstrap_dist), 2), round(sd(bootstrap_dist), 2), "\n")
  return(bootstrap_dist)
}

# CRC -------------------------------------------------------------------------
# bootstrap("crc/CRC_50sample_1mF_60cm_Intermittent.csv", 1)
# bootstrap("crc/CRC_50sample_1mF_70cm_Intermittent.csv", 1)
# bootstrap("crc/CRC_50sample_1mF_80cm_Intermittent.csv", 1)
# -----------------------------------------------------------------------------

# Bitcount --------------------------------------------------------------------
# bootstrap("bitcount/40cm_bitcount_1mF_50sample_Intermittent.csv",1)
# bootstrap("bitcount/60cm_bitcount_1mF_50sample_Intermittent.csv",1)
# bootstrap("bitcount/80cm_bitcount_1mF_50sample_Intermittent.csv",1)
# # -----------------------------------------------------------------------------
#
# bootstrap("dijkstra_normal_execution.csv", 1)
# bootstrap("dotProduct_normal_execution.csv", 1)
# bootstrap("fir_no_red_ld_normal_execution_normal_execution.csv", 1)
# bootstrap("iirFilter_normal_execution_normal_execution.csv", 1)
# bootstrap("jpeg_cosine_transform_normal_execution_normal_execution.csv", 1)
# bootstrap("lattice_synthesis_normal_execution_normal_execution.csv", 1)
#
# bootstrap("embench_ver2/dijkstra_normal_execution_normal_execution_ver2.csv", 1)
# bootstrap("embench_ver2/dotproduct_normal_execution_normal_execution_ver2.csv", 1)
# bootstrap("embench_ver2/fir_filter_normal_execution_normal_execution_ver2.csv", 1)
# bootstrap("embench_ver2/fir_no_red_normal_execution_normal_execution_ver2.csv", 1)
# bootstrap("embench_ver2/iir_filter_normal_execution_normal_execution_ver2.csv", 1)
# bootstrap("embench_ver2/jpeg_cosine_filter_normal_execution_normal_execution_ver2.csv", 1)
# bootstrap("embench_ver2/lattice_sythesis_filter_normal_execution_normal_execution_ver2.csv", 1)

# bootstrap("CRC_PF_info/crc_1mF_60cm_PF_info.csv", 1, "on.time..s.")
# bootstrap("CRC_PF_info/crc_1mF_60cm_PF_info.csv", 1, "off.time..s.")
# bootstrap("CRC_PF_info/crc_1mF_70cm_PF_info.csv", 1, "on.time..s.")
# bootstrap("CRC_PF_info/crc_1mF_70cm_PF_info.csv", 1, "off.time..s.")
# bootstrap("CRC_PF_info/crc_1mF_80cm_PF_info.csv", 1, "on.time..s.")
# bootstrap("CRC_PF_info/crc_1mF_80cm_PF_info.csv", 1, "off.time..s.")

#
# bootstrap("checkpoint_1000sample.csv", 1)
# bootstrap("restore_1000sample.csv", 1)
# bootstrap("Addressing-Modes/000_MovR7R8_1000x200sample.csv", 200)
# bootstrap("Addressing-Modes/001_MovR71(R8)_1000x200sample.csv", 200)
# bootstrap("Addressing-Modes/010_Mov1(R7)R8_1000x200sample.csv", 200)
# bootstrap("Addressing-Modes/011_Mov1(R7)1(R8)_1000x200sample.csv", 200)
# bootstrap("Addressing-Modes/100_Mov@R8R7_1000x200sample.csv", 200)
# bootstrap("Addressing-Modes/101_Mov@R81(R7)_1000x200sample.csv", 200)
# bootstrap("Addressing-Modes/110_Mov#20R7_1000x200sample.csv", 200)
# bootstrap("Addressing-Modes/111_Mov@R81R7-111_1000x200sample.csv", 200)
# bootstrap("Addressing-Modes/00_PUSHR8_1000x200sample.csv", 200)
# bootstrap("Addressing-Modes/01_PUSH1(R8)_1000x200sample.csv", 200)
# bootstrap("Addressing-Modes/10_PUSH@R8_1000x200sample.csv", 200)
bootstrap("experiments/profiling-eren/Addressing-Modes/11_PUSH#20_1000x200sample.csv", 200)

# opar <- par()
#
# figure <- paste0("instructions.svg")
# svg(figure, width = 10.5, height = 3.5)
# par(mfrow = c(1, 3))
#
# data <- bootstrap("experiments/profiling-eren/Addressing-Modes/000_MovR7R8_1000x200sample.csv", 200)
# model <- distr::Norm(mean = mean(data), sd = sd(data))
# q1 <- distr::q(model)(.025)
# mn <- distrEx::E(model)
# q2 <- distr::q(model)(.975)
# rnd <- round(c(q1, mn, q2), 2)
# lab <- paste0("95% Confidence Interval (", rnd[1], ", ", rnd[2], ", ", rnd[3], ")")
# plot(model, to.draw.arg = "d", bty = "7",
#      panel.first = grid(lwd = 1), lwd = 1, vertical = FALSE,
#      col.points = c("red", "black"), cex.points = 1.8, col = "red")
# hist(data, prob = TRUE, breaks = 50, add = TRUE)
# abline(v = c(q1, mn, q2), col = c("skyblue", "coral", "skyblue"))
#
# data <- bootstrap("experiments/profiling-eren/Addressing-Modes/001_MovR71(R8)_1000x200sample.csv", 200)
# model <- distr::Norm(mean = mean(data), sd = sd(data))
# q1 <- distr::q(model)(.025)
# mn <- distrEx::E(model)
# q2 <- distr::q(model)(.975)
# rnd <- round(c(q1, mn, q2), 2)
# lab <- paste0("95% Confidence Interval (", rnd[1], ", ", rnd[2], ", ", rnd[3], ")")
# plot(model, to.draw.arg = "d", bty = "7",
#      panel.first = grid(lwd = 1), lwd = 1, vertical = FALSE,
#      col.points = c("red", "black"), cex.points = 1.8, col = "red")
# hist(data, prob = TRUE, breaks = 50, add = TRUE)
# abline(v = c(q1, mn, q2), col = c("skyblue", "coral", "skyblue"))
#
# data <- bootstrap("experiments/profiling-eren/Addressing-Modes/11_PUSH#20_1000x200sample.csv", 200)
# model <- distr::Norm(mean = mean(data), sd = sd(data))
# q1 <- distr::q(model)(.025)
# mn <- distrEx::E(model)
# q2 <- distr::q(model)(.975)
# rnd <- round(c(q1, mn, q2), 2)
# lab <- paste0("95% Confidence Interval (", rnd[1], ", ", rnd[2], ", ", rnd[3], ")")
# plot(model, to.draw.arg = "d", bty = "7",
#      panel.first = grid(lwd = 1), lwd = 1, vertical = FALSE,
#      col.points = c("red", "black"), cex.points = 1.8, col = "red")
# hist(data, prob = TRUE, breaks = 50, add = TRUE)
# abline(v = c(q1, mn, q2), col = c("skyblue", "coral", "skyblue"))
#
# suppressWarnings(par(opar))
# dev.off()
# browseURL(paste0('file://', file.path(getwd(), figure)))
