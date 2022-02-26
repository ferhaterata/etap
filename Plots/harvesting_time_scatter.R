# Title     : TODO
# Objective : TODO
# Created by: gokci
# Created on: 3.08.2021

# Libraries
library(ggplot2)
library(dplyr)
library(egg)
library(ggthemes)
crc1_100cm <- read.csv("../experiments/profiling-eren/crc_50mF(x1)/CRC_50mF_100cm_50sample_PF_info.csv")
# crc100_100cm<-read.csv("../experiments/profiling-eren/crc_50mF(x100)/crc_50mF_100cm_PF_info.csv")
dijk1_100cm <- read.csv("../experiments/profiling-eren/Dijkstra_50mF(x1)/Dijkstra_50mF_100cm_50sample_PF_info.csv")
dijk100_100cm <- read.csv("../experiments/profiling-eren/Dijkstra_50mF(x100)/dijkstra_50mF_100cm_PF_info.csv")
fir_100cm <- read.csv("../experiments/profiling-eren/fir_no_red_50mF/fir_no_red_50mF_100cm_PF_info.csv")

crc1_120cm <- read.csv("../experiments/profiling-eren/crc_50mF(x1)/CRC_50mF_120cm_50sample_PF_info.csv")
crc100_120cm <- read.csv("../experiments/profiling-eren/crc_50mF(x100)/crc_50mF_120cm_PF_info.csv")
dijk1_120cm <- read.csv("../experiments/profiling-eren/Dijkstra_50mF(x1)/Dijkstra_50mF_120cm_50sample_PF_info.csv")
dijk100_120cm <- read.csv("../experiments/profiling-eren/Dijkstra_50mF(x100)/dijkstra_50mF_120cm_PF_info.csv")
fir_120cm <- read.csv("../experiments/profiling-eren/fir_no_red_50mF/fir_no_red_50mF_120cm_PF_info.csv")

crc1_140cm <- read.csv("../experiments/profiling-eren/crc_50mF(x1)/CRC_50mF_140cm_50sample_PF_info.csv")
crc100_140cm <- read.csv("../experiments/profiling-eren/crc_50mF(x100)/crc_50mF_140cm_PF_info.csv")
dijk1_140cm <- read.csv("../experiments/profiling-eren/Dijkstra_50mF(x1)/Dijkstra_50mF_140cm_50sample_PF_info.csv")
dijk100_140cm <- read.csv("../experiments/profiling-eren/Dijkstra_50mF(x100)/dijkstra_50mF_140cm_PF_info.csv")
fir_140cm <- read.csv("../experiments/profiling-eren/fir_no_red_50mF/fir_no_red_50mF_140cm_PF_info.csv")


BOOTSTRAP_COUNT <- 1000


data_120cm <- c(crc1_120cm$off.time..s., crc100_120cm$off.time..s., dijk1_120cm$off.time..s., dijk100_120cm$off.time..s., fir_120cm$off.time..s.)
bootstrap_dist_120cm <- vector()
n <- length(data_120cm)
for (j in 1:BOOTSTRAP_COUNT) {
  bootstrap_dist_120cm <- append(bootstrap_dist_120cm, mean(sample(data_120cm, n, replace = TRUE)))
}
data_120cm <- bootstrap_dist_120cm
histdf_120cm <- data.frame(x = bootstrap_dist_120cm)


data_140cm <- c(crc1_140cm$off.time..s., crc100_140cm$off.time..s., dijk1_140cm$off.time..s., dijk100_140cm$off.time..s., fir_140cm$off.time..s.)
bootstrap_dist_140cm <- vector()
n <- length(data_140cm)
for (j in 1:BOOTSTRAP_COUNT) {
  bootstrap_dist_140cm <- append(bootstrap_dist_140cm, mean(sample(data_140cm, n, replace = TRUE)))
}
data_140cm <- bootstrap_dist_140cm
histdf_140cm <- data.frame(x = bootstrap_dist_140cm)


data_100cm <- c(crc1_100cm$off.time..s., dijk1_100cm$off.time..s., dijk100_100cm$off.time..s., fir_100cm$off.time..s.)
bootstrap_dist_100cm <- vector()
n <- length(data_100cm)
for (j in 1:BOOTSTRAP_COUNT) {
  bootstrap_dist_100cm <- append(bootstrap_dist_100cm, mean(sample(data_100cm, n, replace = TRUE)))
}
data_100cm <- bootstrap_dist_100cm
histdf_100cm <- data.frame(value = bootstrap_dist_100cm)

data_all <- data.frame(value100 = bootstrap_dist_100cm,
                       value120 = bootstrap_dist_120cm,
                       value140 = bootstrap_dist_140cm)

round(mean(bootstrap_dist_100cm), 2)
round(sd(bootstrap_dist_100cm), 2)
cat("\n")
round(mean(bootstrap_dist_120cm), 2)
round(sd(bootstrap_dist_120cm), 2)
cat("\n")
round(mean(bootstrap_dist_140cm), 2)
round(sd(bootstrap_dist_140cm), 2)

# Plot
library(extrafont)
library(remotes)
# remotes::install_version("Rttf2pt1", version = "1.3.8")

# font_import(paths = "/home/ferhat/.local/share/fonts/source-code-pro")
# font_import(paths = "/home/ferhat/.local/share/fonts/fira-sans")

p1 <- ggplot(data_all, aes(x = as.numeric(row.names(histdf_100cm)), y = value100)) +
  # geom_line(aes(y = value100), colour = '#B85450') +
  # geom_point(aes(y = value100), colour = alpha('#B85450', 1)) +
  # geom_line(aes(y = value120), colour = '#3333FF') +
  # geom_point(aes(y = value120), colour = alpha('#3333FF', 1)) +
  geom_line(aes(y = value140), colour = '#67AB9F') +
  geom_point(aes(y = value140), colour = alpha('#67AB9F', 1)) +
  ylab("") +
  xlab("") +
  # scale_y_continuous(breaks = scales::pretty_breaks(n = 6), limits = c(5.8, 6.9)) + # 11
  # scale_y_continuous(breaks = scales::pretty_breaks(n = 6), limits = c(9.7, 10.8)) + # 11
  scale_y_continuous(breaks = scales::pretty_breaks(n = 6), limits = c(18.1, 19.2)) + # 11
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
        panel.background = element_blank(), axis.line = element_blank(), axis.ticks = element_line(colour = "black", size = 1), axis.ticks.length = unit(2, units = "mm")) +
  theme(legend.position = "bottom", axis.text = element_text(family = "Source Code Pro", color = "black", face = "bold", size = 25), text = element_text(family = "Source Code Pro", color = "black", face = "bold", size = 25))

# theme_economist()
#   theme_wsj()

p1
# ggsave("harvesting_figure_scatter_100cm.svg", p1, height = 3, width = 16)
# ggsave("harvesting_figure_scatter_120cm.svg", p1, height = 3, width = 16)
ggsave("harvesting_figure_scatter_140cm.svg", p1, height = 3, width = 16)
