# Sampling ADD instruction

Sample the instructions wrt. addressing modes

measure the energy consumption "E_total"

```c
// start the energy profiling here 
while(1000){
    ...
  __asm__ __volatile__ (" ADD R3,0(R15)");
}
// stop the energy profiling on halt
```

measure the energy consumption "E_overhead"

```c
// start the energy profiling here 
while(1000){ 
 ; // noop instruction
}
// stop the energy profiling on halt
```

E_ADD = (E_total - E_while_overhead - `E_startup_overhead`) / 1000

Repeat 100.

uj (one decimal precision)

1. create a vector from samples

```r
add <- c(11.3, 12.5, ...)
```

2. fit a normal distribution

```r
## reproducible example
set.seed(0); x <- rnorm(100)
## using MASS

library(MASS)
fit <- fitdistr(x, "normal")
class(fit)
# [1] "fitdistr"

para <- fit$estimate
#         mean            sd 
#-0.0002000485  0.9886248515 

hist(x, prob = TRUE)
curve(dnorm(x, para[1], para[2]), col = 2, add = TRUE)

## Using fitdistrplus::fitdist

library(fitdistrplus)
FIT <- fitdist(x, "norm")    ## note: it is "norm" not "normal"
class(FIT)
# [1] "fitdist"

plot(FIT)    ## use method `plot.fitdist`
```