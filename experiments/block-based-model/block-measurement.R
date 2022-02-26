library(distr)

LPM_CURRENT <- 200000 # nA
BLOCK_COUNT <- 1
BOOTSTRAP_COUNT<- 10000
PRECISION_LOOP_COUNT<-1000
forloop<-distr::Norm(mean=2372454050,sd=24171259) # ns

energy_trace <- read.csv("experiments/block-based-model/.energytrace/EnergyTrace_checkpoint_experiment.csv", header = TRUE, sep = ";")
names(energy_trace) <- list("Time(ns)", "Current(nA)", "Voltage(mV)", "Energy(uJ)")

energy_trace <- energy_trace[energy_trace$`Current(nA)` != "0",] # remove initial 0 current

time_list <- as.double(energy_trace$`Time(ns)`)
current_list <- as.double(energy_trace$`Current(nA)`)

block_list <- list()
block_counter <- 0
block_start <- time_list[[1]]
block_finish <- 0

lpm <- 0
for (i in seq_along(current_list)) {
  if (current_list[[i]] < LPM_CURRENT) {
    # LPM start time
    if (!lpm) {

      block_finish <- time_list[[i]]
      b_name <- paste0("block_", block_counter)

      block_list[[b_name]] <- append(block_list[[b_name]], (block_finish - block_start))
      block_counter <- block_counter + 1
      if (block_counter == BLOCK_COUNT) {
        block_counter <- 0
      }
    }
    lpm <- 1
  }else {
    # LPM end time
    if (lpm) {
      block_start <- time_list[[i]]
    }
    lpm <- 0
  }
}
forloop<-distr::Norm(mean=2372454050,sd=24171259) # ns
block_dist_list<-list()
for(i in 1:BLOCK_COUNT){
  bootstrap_dist<-vector()
  bb<-block_list[[i]] # ns
  x_bar<-mean(bb)
  #cat("block_",i,"sample mean: ",x_bar,"\n\t")
  n<-length(bb)
  for(j in 1:BOOTSTRAP_COUNT){
    bootstrap_dist<-append(bootstrap_dist,mean(sample(bb, n, replace = TRUE)))
  }
  se <- sd(bootstrap_dist) # se (standard error) is sd of sampling distribution
  mb <- mean(bootstrap_dist) # mean of the boot would be similar to sample mean
  #cat("sd : ",se)
  #cat("\nbs mean : ",mb,"\n")
  population_distr <- distr::Norm(x_bar, se)
  dist<-population_distr-forloop
  dist<-dist/PRECISION_LOOP_COUNT # for 1 block
  dist<-dist/1000 # ns to us
  block_dist_list[[i]]<-dist
}
plot(population_distr, to.draw.arg = "d", bty = "7",
     panel.first = grid(lwd = 1), lwd = 1, vertical = FALSE,
     col.points = c("red", "black"), cex.points = 1.8, col = "red")
hist(bootstrap_dist, prob = TRUE, breaks = 100, add = TRUE)