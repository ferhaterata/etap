# Title     : TODO
# Objective : TODO
# Created by: gokcin
# Created on: 13.04.2021

library("ggplot2")


data <- read.csv("experiments/tasks/evaluation/table4.csv")
data["diffrencePercent"] <- data$Difference / data$ActualMeasurement * 100
data["diffrencePercent"] <- round(data["diffrencePercent"], 4)
data["ActualMean"] <- data["ActualMean"] / 1000
data["ActualSd"] <- data["ActualSd"] / 1000
data["PredictionMean"] <- data["PredictionMean"] / 1000
data["PredSd"] <- data["PredSd"] / 1000


# abs <- abs(data["diffrencePercent"]$diffrencePercent)
# m <- mean(abs)
df <- data[1:5]
df <- data.frame(
  "benchmark" = rep(data$BenchmarkAndDistance, each = 2),
  "real" = c(data$ActualMean[1], data$PredictionMean[1],
             data$ActualMean[2], data$PredictionMean[2],
             data$ActualMean[3], data$PredictionMean[3],
             data$ActualMean[4], data$PredictionMean[4],
             data$ActualMean[5], data$PredictionMean[5],
             data$ActualMean[6], data$PredictionMean[6],
             data$ActualMean[7], data$PredictionMean[7],
             data$ActualMean[8], data$PredictionMean[8],
             data$ActualMean[9], data$PredictionMean[9],
             data$ActualMean[10], data$PredictionMean[10],
             data$ActualMean[11], data$PredictionMean[11],
             data$ActualMean[12], data$PredictionMean[12]),
  "sup" = c("Actual", "Prediction"),
  "sd" = c(data$ActualSd, data$PredSd)
)
opar <- par()
timingPlot <- paste0("experiments/tasks/evaluation/IntermittentExecution.pdf")
dir.create(dirname(timingPlot), showWarnings = FALSE, recursive = TRUE)
pdf(timingPlot, width = 7, height = 4)
par(mfrow = c(1, 1))
ggplot(df, aes(x = benchmark, y = real, fill = sup)) +
  geom_bar(stat = "identity", position = position_dodge()) +
  geom_errorbar(aes(ymin = real - 2*1.96*sd*1.5, ymax = real + 2*1.96*sd*1.5), width = .2,
                position = position_dodge(.9)) +scale_fill_brewer(palette="Paired")+
  xlab("")+ ylab("Time (s)")+ theme(legend.title = element_blank())+
  theme(legend.position = c(0, 1), legend.justification = c(-4.5, 1.3))+
  theme(axis.text.x = element_text(angle = 45, vjust = 0.3, hjust=0.5))
suppressWarnings(par(opar))
dev.off()

