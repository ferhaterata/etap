library("ggplot2")
data <- read.csv("experiments/tasks/numan/table3.csv")
data["DiffPercent"] <- data["DifferenceInAverage"] / data["ActualMean"] *100
data["DiffPercent"] <- round(data["DiffPercent"], 4)
data["ActualMean"] <- data["ActualMean"] / 1000
data["ActualSd"] <- data["ActualSd"] / 1000
data["PredictionMean"] <- data["PredictionMean"] / 1000
data["PredictionSd"] <- data["PredictionSd"] / 1000
m <- mean(data$DiffPercent)


data <- data[1:5]
df <- data.frame(
  "benchmark" = rep(data$Benchmarks, each = 2),
  "real" = c(data$ActualMean[1], data$PredictionMean[1],
             data$ActualMean[2], data$PredictionMean[2],
             data$ActualMean[3], data$PredictionMean[3],
             data$ActualMean[4], data$PredictionMean[4],
             data$ActualMean[5], data$PredictionMean[5],
             data$ActualMean[6], data$PredictionMean[6],
             data$ActualMean[7], data$PredictionMean[7],
             data$ActualMean[8], data$PredictionMean[8],
             data$ActualMean[9], data$PredictionMean[9]),
  "sup" = c("Actual", "Prediction"),
  "sd" = c(data$ActualSd, data$PredictionSd)
)
opar <- par()
timingPlot <- paste0("experiments/tasks/evaluation/NormalExecution.pdf")
dir.create(dirname(timingPlot), showWarnings = FALSE, recursive = TRUE)
pdf(timingPlot, width = 7, height = 3)
par(mfrow = c(1, 1))
ggplot(df, aes(x = benchmark, y = real, fill = sup)) +
  geom_bar(stat = "identity", position = position_dodge()) +
  geom_errorbar(aes(ymin = real - 2*1.96*2000*sd, ymax = real + 2*1.96*2000*sd), width = .2,
                position = position_dodge(.9)) +scale_fill_brewer(palette="Paired")+
  xlab("")+ ylab("Time (s)")+ theme(legend.title = element_blank())+
  theme(legend.position = c(0, 1), legend.justification = c(-5, 1.3))
suppressWarnings(par(opar))
dev.off()