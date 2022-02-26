set.seed(100)
SAMPLE_SIZE <- 100
CAPACITOR_SIZE <- 10^-3 # F
CAPACITOR_VOLTAGE <- 3.3 # V
CLOCK <- 32768 # Hz

COMPUTE_TOTAL_ENERGY <- 0.610 # J
COMPUTE_TOTAL_TIME <- 0.43 # s

time_per_cycle <- 1 / CLOCK # s
compute_total_cycle <- COMPUTE_TOTAL_TIME / time_per_cycle # cycles
compute_energy_per_cycle <- COMPUTE_TOTAL_ENERGY / compute_total_cycle # J

capacitor_total_energy <- (CAPACITOR_SIZE * (CAPACITOR_VOLTAGE^2)) / 2 # J
capacitor_total_cycle <- capacitor_total_energy / compute_energy_per_cycle # cycles

sd <- capacitor_total_cycle * 10 / 100 # 10% deviation 

v <- rnorm(SAMPLE_SIZE, mean = capacitor_total_cycle, sd = sd)
v <- as.integer(v)
v <- as.character(v)

data <- paste0("struct{__nv int index;int data[", SAMPLE_SIZE, "];}power_failure_simulator ={0,{")
for (sample in v) {
  data <- paste0(data, sample, ",")
}
data <- paste0(data, "}};")


fileConn <- file("pf_distribution.h")
writeLines(data, fileConn)
close(fileConn)


