Rcpp::sourceCpp("R/llvm-meta-packaging/llvm/src/meta.cpp")

library(microbenchmark)  # let's compare performances

library(binaryLogic)
# shl using "binaryLogic"
shl_old <- function(type, op1, op2) {
  bitCount <- as.integer(regmatches(type, regexpr("(?<=i)(\\d+)", type, perl = TRUE)))

  # LLVM Semantics:  If op2 is (statically or dynamically) equal to or larger than the number of bits in op1, this instruction returns a poison value.
  if (op2 >= bitCount) {
    return("undefined") # undefined
  }
  res <- as.double(binaryLogic::shiftLeft(binaryLogic::as.binary(op1, n = bitCount), op2))
  if (res >= (2^bitCount)) {
    res <- 0
  }
  return(res)
}

microbenchmark::microbenchmark(
  for (i in 1:100)
    shl("i32", 2^31, 1)
  ,
  for (i in 1:100)
    shl_old("i32", 2^31, 1)
)

# trunc
trunc_old <- function(from, value, to) {
  toBitCount <- as.integer(regmatches(to, regexpr("(?<=i)(\\d+)", to, perl = TRUE)))
  #return(as.integer(as.raw(as.integer(intToBits(value)))[1:toBitCount]))
  return(as.integer(binaryLogic::as.binary(value) & binaryLogic::as.binary((2^toBitCount) - 1)))
}

trunc("i16", 206, "i8")
trunc_old("i16", 206, "i8")

microbenchmark::microbenchmark(
  for (i in 1:100)
    trunc("i32", 150, "i8")
  ,
  for (i in 1:100)
    trunc_old("i32", 150, "i8")
)


# benchmark for cast and mask
library(Rcpp)
Rcpp::cppFunction('long a1(long x){
  x = (short)x;
  return x;
}')

Rcpp::cppFunction('long a2(long x){
  return x & 0xFFFF;
}')

Rcpp::cppFunction('unsigned int a3(unsigned int x){
  return (unsigned char)x;
}')

Rcpp::cppFunction('unsigned int a4(unsigned int x){
  return x & 0xFF;
}')

library(microbenchmark)
microbenchmark::microbenchmark(
  for (i in 1:1000) {
    a1(100)
  },
  for (i in 1:1000) {
    a2(100)
  }
)

microbenchmark::microbenchmark(
  for (i in 1:1000) {
    a3(-150)
  },
  for (i in 1:1000) {
    a4(-150)
  }
)

microbenchmark::microbenchmark(
  for (i in 1:100) {
    my_norm(mean = 2, sd = 0.1)
  },
  for (i in 1:100) {
    distr::Norm(mean = 2, sd = 0.1)
  }
)

microbenchmark::microbenchmark(
{ v <- vector(); for (i in 1:100000) { v[i] <- i; } }
  ,
{ v2 <- vector(); length(v2) <- 100000; for (i in 1:100000) { v2[i] <- i; } }
)
