# Vectorization
# its goal is simply to calculate the square of every element in the random vector data
N <- 1E6
data <- sample(1:30, size = N, replace = T)

# first approach: set up a for loop
system.time({
  data_sq1 <- numeric(N)
  for (j in 1:N) {
    data_sq1[j] <- data[j]^2
  }
})
# second approach: apply the square operator on the data vector directly
system.time(data_sq2 <- data^2)

##############################################

# Use of built-in functions
# a simple example of how to calculate the sums of the rows of the random matrix
data <- rnorm(1E4 * 1000)
dim(data) <- c(1E4, 1000)
# apply() -> margin = 1 represents row operation, sum = function
system.time(data_sum1 <- apply(data, 1, sum))
# rowSums() -> built-in version of the same problem
system.time(data_sum2 <- rowSums(data))


##############################################

# Preallocating memory
# to generate a series of random numbers, where each vector element is defined
# as the value of the previous element +/- a random integer between -5 to 5

# every time a vector is resized, the program needs to perform extra steps
# include copying the vector to a larger or smaller memory block and deleting the old vector.
# These steps are not needed if the memory is preallocated.
N <- 1E4
data_series1 <- 1

# first approach: bypasses the preallocation of the vector's memory, that is,
# it starts with a vector of a single elemet and appends a new element at each iteration.
system.time({
  for (j in 2:N) {
    data_series1 <- c(data_series1,
                      data_series1[j - 1] + sample(-5:5, size = 1))
  }
})

# second approach: preallocates the memory by declaring a numeric vector of size N
# The preallocated space, as represented by the vector's index, is filled in at every iteration.
data_series2 <- numeric(N)
data_series2[1] <- 1
system.time({
  for (j in 2:N) {
    data_series2[j] <- data_series2[j - 1] + sample(-5:5, size = 1)
  }
})

# Does apply offer performance advantages over looping?
# to generate a list of normally distributed random vectors
# whose sizes are also randomly set to values between 1 and 30
N <- 1E5
data <- sample(1:30, size = N, replace = T)
data_rand1 <- list()
# first approach: use for loop
system.time(for (i in 1:N) data_rand1[[i]] <- rnorm(data[i]))

# second approach: use lapply()
system.time(data_rand2 <- lapply(data, rnorm))

# first approach's preallocated version
data_rand3 <- vector("list", N)
system.time(for (i in 1:N) data_rand3[[i]] <- rnorm(data[i]))


# microbenchmark(data_rand2 <- lapply(data, rnorm),
#                for (i in 1:N) data_rand3[[i]] <- rnorm(data[i]))


##############################################

# Use of simpler data structures
# applying a matrix operation on a data.frame is slower than on a matrix.
# One of the reasons is that most matrix operations first coerce the data.frame into a matrix
# before performing the computation.
# for this reason, where possible, one should use a matrix in place of a data.frame

# perform row summation on a matrix and its equivalent data.frame representation

# matrix representation
data <- rnorm(1E4 * 1000)
dim(data) <- c(1E4, 1000)
system.time(data_rs1 <- rowSums(data))

# data.frame representation
data_df <- data.frame(data)
system.time(data_rs2 <- rowSums(data_df))

# data.frame subsetting using logical conditions
data <- rnorm(1E5 * 1000)
dim(data) <- c(1E5, 1000)
data_df <- data.frame(data)
system.time(data_df[data_df$X100 > 0 & data_df$X200 < 0,])

# subsetting using which function
system.time(data_df[which(data_df$X100 > 0 & data_df$X200 < 0),])


##############################################

# Use of hash tables for frequent lookups on large data
# an alternative to lists that offers a more optimized data lookup is a hash table.
# In R, this is available from the CRAN package hash. A hash table's lookup incurs O(1).

# simulating 1000 lookups from a random list
data <- rnorm(1E6)
data_ls <- as.list(data)
names(data_ls) <- paste("V", c(1:1E6), sep = "")
index_rand <- sample(1:1E6, size = 1000, replace = T)
index <- paste("V", index_rand, sep = "")
list_comptime <- sapply(index, FUN = function(x) {
  system.time(data_ls[[x]])[3] })
sum(list_comptime)

library(hash)
data_h <- hash(names(data_ls), data)
hash_comptime <- sapply(index, FUN = function(x) {
  system.time(data_h[[x]])[3] })
sum(hash_comptime)


# using compiled code
# calculate the moving average of a numeric series
mov.avg <- function(x, n = 20) {
  total <- numeric(length(x) - n + 1)
  for (i in 1:n) {
    total <- total + x[i:(length(x) - n + i)]
  }
  total / n
}

# compile before execution
library(compiler)
mov.avg.compiled0 <- cmpfun(mov.avg, options = list(optimize = 0))
mov.avg.compiled1 <- cmpfun(mov.avg, options = list(optimize = 1))
mov.avg.compiled2 <- cmpfun(mov.avg, options = list(optimize = 2))
mov.avg.compiled3 <- cmpfun(mov.avg, options = list(optimize = 3))

library(microbenchmark)
x <- runif(100)
bench <- microbenchmark(mov.avg(x), mov.avg.compiled0(x),
                        mov.avg.compiled1(x),
                        mov.avg.compiled2(x),
                        mov.avg.compiled3(x))

# The compiler package provides different functions to compile
# different types of R code:
# • cmpfun() compiles an R function.
# • compile() compiles an R expression.
# • cmpfile() compiles an R expression stored in a file.


#just in time compilation
# when JIT compilation is enabled, R will automatically compile any code that is executed
# without explicitly having called one of the compile functions.

# to activate JIT compilation use enableJIT() function
enableJIT(level = 3)
# 0: It disables JIT
# 1: It compiles functions before their first use
# 2: In addition, it compiles functions before they are duplicated.
#   This is useful for some packages like lattice that store functions in lists
# 3: It compiles loops before they are executed *******

# uncompiled mov.avg() function
microbenchmark(mov.avg(x))


# using compiled languages
# In order to compile the examples in this chapter, a set of development tools,
# including a C/C++ compiler are needed.
library(inline)

# example of how to implement mov.avg() in C using inline package:
mov.avg.inline <- cfunction(
  sig = signature(x = "numeric", n = "integer"),
  body = "
  SEXP x2 = PROTECT(coerceVector(x, REALSXP));
  SEXP n2 = PROTECT(coerceVector(n, INTSXP));
  double *x_p = REAL(x2);
  int n_val = asInteger(n2);
  int x_len = length(x2);
  int res_len = x_len - n_val + 1;
  SEXP res = PROTECT(allocVector(REALSXP, res_len));
  double *res_p = REAL(res);
  for (int i = 0; i < res_len; i++) {
    res_p[i] = 0;
  }
  for (int j = 0; j < n_val; j++) {
    for (int k = 0; k < res_len; k++) {
      res_p[k] += x_p[j + k];
    }
  }
  for (int l = 0; l < res_len; l++) {
    res_p[l] /= n_val;
  }
  UNPROTECT(3);
  return res;
  ",
  language = "C"
)

x <- runif(100)
all(mov.avg(x, 20) == mov.avg.inline(x, 20))

microbenchmark(mov.avg(x, 20), mov.avg.inline(x, 20))
y <- runif(1e7)
microbenchmark(mov.avg(y, 20), mov.avg.inline(y, 20))