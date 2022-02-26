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
  memory::reserve(N)
  for (i in 1:N) memory::add(data[i])
  for (i in 1:N) a <- memory::get(i)
}

memory::clear()
system.time(vect())


# second approach



