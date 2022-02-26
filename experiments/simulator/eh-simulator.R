# Created by: gokcin
# Created on: 23.02.2021
set.seed(100)

CHARGE_TIME <- 1000000
SAMPLE_SIZE <- 100

sd <- CHARGE_TIME * 10 / 100 # 10% deviation

v <- rnorm(SAMPLE_SIZE, mean = CHARGE_TIME, sd = sd)
v <- as.integer(v)
v <- as.character(v)

data <- paste0("struct{ __nv int index;int data[", SAMPLE_SIZE, "];}energy_harvester_simulator ={0,{")
for (sample in v) {
  data <- paste0(data, sample, ",")
}
data <- paste0(data, "}};")


fileConn <- file("eh_distribution.h")
writeLines(data, fileConn)
close(fileConn)
