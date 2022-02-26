# Title     : TODO
# Objective : TODO
# Created by: gokcin
# Created on: 14.04.2021
library(distr)
library(ggplot2)
library(gridExtra)
library(egg)
BOOTSTRAP_COUNT <- 1000
crc1_100cm<-read.csv("../experiments/profiling-eren/crc_50mF(x1)/CRC_50mF_100cm_50sample_PF_info.csv")
crc100_100cm<-read.csv("../experiments/profiling-eren/crc_50mF(x100)/crc_50mF_100cm_PF_info.csv")
dijk1_100cm<-read.csv("../experiments/profiling-eren/Dijkstra_50mF(x1)/Dijkstra_50mF_100cm_50sample_PF_info.csv")
dijk100_100cm<-read.csv("../experiments/profiling-eren/Dijkstra_50mF(x100)/dijkstra_50mF_100cm_PF_info.csv")
fir_100cm<-read.csv("../experiments/profiling-eren/fir_no_red_50mF/fir_no_red_50mF_100cm_PF_info.csv")

crc1_120cm<-read.csv("../experiments/profiling-eren/crc_50mF(x1)/CRC_50mF_120cm_50sample_PF_info.csv")
crc100_120cm<-read.csv("../experiments/profiling-eren/crc_50mF(x100)/crc_50mF_120cm_PF_info.csv")
dijk1_120cm<-read.csv("../experiments/profiling-eren/Dijkstra_50mF(x1)/Dijkstra_50mF_120cm_50sample_PF_info.csv")
dijk100_120cm<-read.csv("../experiments/profiling-eren/Dijkstra_50mF(x100)/dijkstra_50mF_120cm_PF_info.csv")
fir_120cm<-read.csv("../experiments/profiling-eren/fir_no_red_50mF/fir_no_red_50mF_120cm_PF_info.csv")

crc1_140cm<-read.csv("../experiments/profiling-eren/crc_50mF(x1)/CRC_50mF_140cm_50sample_PF_info.csv")
crc100_140cm<-read.csv("../experiments/profiling-eren/crc_50mF(x100)/crc_50mF_140cm_PF_info.csv")
dijk1_140cm<-read.csv("../experiments/profiling-eren/Dijkstra_50mF(x1)/Dijkstra_50mF_140cm_50sample_PF_info.csv")
dijk100_140cm<-read.csv("../experiments/profiling-eren/Dijkstra_50mF(x100)/dijkstra_50mF_140cm_PF_info.csv")
fir_140cm<-read.csv("../experiments/profiling-eren/fir_no_red_50mF/fir_no_red_50mF_140cm_PF_info.csv")



data_100cm <- c(crc1_100cm$off.time..s.,crc100_100cm$off.time..s.,dijk1_100cm$off.time..s.,dijk100_100cm$off.time..s.,fir_100cm$off.time..s.)
bootstrap_dist_100cm <- vector()
n <- length(data_100cm)
for (j in 1:BOOTSTRAP_COUNT) {
  bootstrap_dist_100cm <- append(bootstrap_dist_100cm, mean(sample(data_100cm, n, replace = TRUE)))
}
data_100cm <- bootstrap_dist_100cm
histdf_100cm <- data.frame(x = bootstrap_dist_100cm)

data_120cm <- c(crc1_120cm$off.time..s.,crc100_120cm$off.time..s.,dijk1_120cm$off.time..s.,dijk100_120cm$off.time..s.,fir_120cm$off.time..s.)
bootstrap_dist_120cm <- vector()
n <- length(data_120cm)
for (j in 1:BOOTSTRAP_COUNT) {
  bootstrap_dist_120cm <- append(bootstrap_dist_120cm, mean(sample(data_120cm, n, replace = TRUE)))
}
data_120cm <- bootstrap_dist_120cm
histdf_120cm <- data.frame(x = bootstrap_dist_120cm)

data_140cm <- c(crc1_140cm$off.time..s.,crc100_140cm$off.time..s.,dijk1_140cm$off.time..s.,dijk100_140cm$off.time..s.,fir_140cm$off.time..s.)
bootstrap_dist_140cm <- vector()
n <- length(data_140cm)
for (j in 1:BOOTSTRAP_COUNT) {
  bootstrap_dist_140cm <- append(bootstrap_dist_140cm, mean(sample(data_140cm, n, replace = TRUE)))
}
data_140cm <- bootstrap_dist_140cm
histdf_140cm <- data.frame(x = bootstrap_dist_140cm)


p1<-ggplot(histdf_100cm, aes(x = x)) +
  geom_histogram(binwidth = 0.05,
                 color = "white", fill = "cornflowerblue", size = 0.1)+
  stat_function(fun = function(x) dnorm(x, mean = mean(data_100cm), sd = sd(data_100cm)) * 10000 * 0.05,
                color = "darkred", size = 1) +
  xlab("Harvesting Time - 100cm (s)")+ ylab("")+
  scale_x_continuous(breaks = scales::pretty_breaks(n = 5)) + theme(text = element_text(size=22))

p2<-ggplot(histdf_120cm, aes(x = x)) +
  geom_histogram(binwidth = 0.01,
                 color = "white", fill = "cornflowerblue", size = 0.1)+
  stat_function(fun = function(x) dnorm(x, mean = mean(data_120cm), sd = sd(data_120cm)) * 10000 * 0.01,
                color = "darkred", size = 1) +
  xlab("Harvesting Time - 120cm (s)")+ ylab("")+ theme(text = element_text(size=22)) +
  scale_x_continuous(breaks = scales::pretty_breaks(n = 5))

p3<-ggplot(histdf_140cm, aes(x = x)) +
  geom_histogram(binwidth = 0.05,
                 color = "white", fill = "cornflowerblue", size = 0.1)+
  stat_function(fun = function(x) dnorm(x, mean = mean(data_140cm), sd = sd(data_140cm)) * 10000 * 0.05,
                color = "darkred", size = 1) +
  xlab("Harvesting Time - 140cm (s)")+ ylab("") + theme(text = element_text(size=20)) +
  scale_x_continuous(breaks = scales::pretty_breaks(n = 5))

figure <- egg::ggarrange(p1,p2,p3 ,nrow = 1)
ggsave("../harvesting_figures.pdf", figure, height = 4, width = 15)





