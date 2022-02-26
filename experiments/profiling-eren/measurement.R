rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
options("StartupBanner" = "off")
library(distr)
distroptions("WarningArith" = FALSE)

set.seed(100)
BOOTSTRAP_COUNT <- 10000

bootstrap <- function(file, precision_count, col_name = "executionTime.s.") {
  prof <- read.csv(paste0("experiments/profiling-eren/", file), header = TRUE, sep = ",")

  timing <- prof[[col_name]] * 1000000  # s to us
  timing <- timing / precision_count
  outliers_high <- quantile(timing, .75) + 1.5 * IQR(timing)
  outliers_low <- quantile(timing, .25) - 1.5 * IQR(timing)
  timing <- timing[ timing>outliers_low]
  timing <- timing[timing<outliers_high]
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

  cat("\nTime @ 1 MHz (us)")
  cat("\nMode ", "Mean", "Sd")
  cat("\n", file,col_name, round(mean(bootstrap_dist), 2), round(sd(bootstrap_dist), 2), "\n")
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
#  bootstrap("bitcount/100cm_bitcount_50mF_50sample.csv",1)
#  bootstrap("bitcount/120cm_bitcount_50mF_50sample.csv",1)
#  bootstrap("bitcount/140cm_bitcount_50mF_50sample.csv",1)
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

# bootstrap("Dijkstra_50mF(x100)/dijkstra_50mF_100cm_PF_info.csv",1,"off.time..s.")
# bootstrap("Dijkstra_50mF(x100)/dijkstra_50mF_120cm_PF_info.csv",1,"off.time..s.")
# bootstrap("Dijkstra_50mF(x100)/dijkstra_50mF_140cm_PF_info.csv",1,"off.time..s.")
# bootstrap("Dijkstra_50mF(x100)/dijkstra_100cm_50mF_execution_time.csv",1)
# bootstrap("Dijkstra_50mF(x100)/dijkstra_120cm_50mF_execution_time.csv",1)
# bootstrap("Dijkstra_50mF(x100)/dijkstra_140cm_50mF_execution_time.csv",1)
bootstrap("Dijkstra_50mF(x1)/Dijkstra_100cm_50mF_50sample_execution_time.csv",1)
bootstrap("Dijkstra_50mF(x1)/Dijkstra_120cm_50mF_50sample_execution_time.csv",1)
bootstrap("Dijkstra_50mF(x1)/Dijkstra_140cm_50mF_50sample_execution_time.csv",1)
bootstrap("Dijkstra_50mF(x1)/Dijkstra_50mF_100cm_50sample_PF_info.csv",1,"off.time..s.")
bootstrap("Dijkstra_50mF(x1)/Dijkstra_50mF_120cm_50sample_PF_info.csv",1,"off.time..s.")
bootstrap("Dijkstra_50mF(x1)/Dijkstra_50mF_140cm_50sample_PF_info.csv",1,"off.time..s.")

# bootstrap("fir_no_red_50mF/fir_no_red_50mF_100cm_PF_info.csv",1,"off.time..s.")
# bootstrap("fir_no_red_50mF/fir_no_red_50mF_120cm_PF_info.csv",1,"off.time..s.")
# bootstrap("fir_no_red_50mF/fir_no_red_50mF_140cm_PF_info.csv",1,"off.time..s.")
# bootstrap("fir_no_red_50mF/fir_no_red_100cm_50mF_execution_time.csv",1)
# bootstrap("fir_no_red_50mF/fir_no_red_120cm_50mF_execution_time.csv",1)
# bootstrap("fir_no_red_50mF/fir_no_red_140cm_50mF_execution_time.csv",1)

bootstrap("crc_50mF(x1)/CRC_50mF_100cm_50sample_PF_info.csv", 1, "off.time..s.")
bootstrap("crc_50mF(x1)/CRC_50mF_120cm_50sample_PF_info.csv", 1, "off.time..s.")
bootstrap("crc_50mF(x1)/CRC_50mF_140cm_50sample_PF_info.csv", 1, "off.time..s.")
bootstrap("crc_50mF(x1)/CRC_100cm_50mF_50sample_execution_time.csv", 1)
bootstrap("crc_50mF(x1)/CRC_120cm_50mF_50sample_execution_time.csv", 1)
bootstrap("crc_50mF(x1)/CRC_140cm_50mF_50sample_execution_time.csv", 1)

# bootstrap("crc_50mF(x100)/crc_50mF_100cm_PF_info.csv", 1, "off.time..s.")
# bootstrap("crc_50mF(x100)/crc_50mF_120cm_PF_info.csv", 1, "off.time..s.")
# bootstrap("crc_50mF(x100)/crc_50mF_140cm_PF_info.csv", 1, "off.time..s.")
# bootstrap("crc_50mF(x100)/crc_100cm_50mF_execution_time.csv", 1)
# bootstrap("crc_50mF(x100)/crc_120cm_50mF_execution_time.csv", 1)
# bootstrap("crc_50mF(x100)/crc_140cm_50mF_execution_time.csv", 1)
#

bootstrap("CRC_PF_info/crc_1mF_60cm_PF_info.csv", 1, "on.time..s.")
bootstrap("CRC_PF_info/crc_1mF_60cm_PF_info.csv", 1, "off.time..s.")
bootstrap("CRC_PF_info/crc_1mF_70cm_PF_info.csv", 1, "on.time..s.")
bootstrap("CRC_PF_info/crc_1mF_70cm_PF_info.csv", 1, "off.time..s.")
bootstrap("CRC_PF_info/crc_1mF_80cm_PF_info.csv", 1, "on.time..s.")
bootstrap("CRC_PF_info/crc_1mF_80cm_PF_info.csv", 1, "off.time..s.")

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
# bootstrap("Addressing-Modes/11_PUSH#20_1000x200sample.csv", 200)