Rcpp::sourceCpp("R/memory-packaging/memory/src/memory.cpp")

N <- 1E4
data <- sample(1:1000, size = N, replace = T)
rnd_index <- floor(runif(N, min = 1, max = 1E4))

# first approach
envir <- function() {
  mem <- new.env(hash = TRUE, size = N)
  for (i in 1:N) mem[[toString(i)]] <- data[i]
  for (i in 1:N) a <- mem[[toString(rnd_index[i])]]
}

system.time(envir())


vect <- function() {
  reserve(N)
  for (i in 1:N) add(data[i])
  for (i in 1:N) a <- get(i)
}

clear()
system.time(vect())


# second approach



