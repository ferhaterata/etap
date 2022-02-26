rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
n <- DiscreteDistribution(supp = 1:4)
v.i.0 <- 4 #inc
v.cmp <- v.i.0 - n;
v.cmp <- v.i.0 - n.1;
v.cmp.cond <- p(v.cmp)(-1);
plot(v.cmp)
v.cmp <- Truncate(v.cmp, lower = -Inf, upper = -1)
plot(v.cmp)
n.1 <- -v.cmp + v.i.0 # transfer knowledge back to N
plot(n.1)


# rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
library(rlang)
options(useFancyQuotes = FALSE)

global.nums <- env("0" = 1, "1" = 2, "2" = 3) # create a global value
# refs <- env() # creates environment for pointers
# refs$a <- "nums" # creates a pointer
# refs$b <- "0"  # creates a pointer
nums <- env("0" = 0, "1" = 0, "2" = 0) # allocates an array or struct
a <- deparse(substitute(nums)) # creates a pointer
b <- deparse(substitute(nums)) # creates a pointer
# malloc
eval(parse(text = paste0(a, " <- ", deparse(substitute(global.nums)))))
# pointer dereference (getelementptr)
eval(parse(text = paste0(a, "$", dQuote(1))))
# pointer dereference (getelementptr)
eval(parse(text = paste0(a, "$", dQuote(2))))
# store:  pointer, index, value
eval(parse(text = paste0(a, "$", dQuote(2), " <- ", 5)))

eval(parse(text = paste0(a, "$", dQuote(2))))

gep <- function(ref, index)
  eval(parse(text = paste0(ref, "$", dQuote(index))))

store <- function(ref, index, value)
  eval(parse(text = paste0(ref, "$", dQuote(index), " <- ", value)))

memcpy <- function(dest, src)
  eval(parse(text = paste0(dest, " <- ", deparse(substitute(src)))))

# creates a pointer
pointer <- function(reference, element)
  eval.parent(substitute(reference <- deparse(substitute(element))))

######
rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
library("rlang")
options(useFancyQuotes = FALSE)

memcpy <- function(dest, src)
  eval.parent(parse(text = paste0(dest, " <- ", src)))

# <result> = add <ty> <var1>, <var2>
add <- function(var1, var2)
  eval.parent(substitute(var1 + var2))

sext <- function(value)
  eval.parent(substitute(value))

bitcast <- function(pointer)
  eval.parent(substitute(pointer))

ptr <- function(element)
  eval.parent(deparse(substitute(element)))

# <result> = load <ty>* <pointer>
load <- function(pointer)
  eval(parse(text = paste0(pointer)))

# store <ty> <value>, <ty>* <pointer>
store <- function(value, pointer)
  eval.parent(substitute(pointer <- value))

gep <- function(pointer, index)
  paste0(pointer, "$", dQuote(index))

######
# array1.ll
######
c.nums <- env("0" = 1, "1" = 2, "2" = 3) # create a global value
######
v.0 <- load(gep(ptr(c.nums), 0))

######
# array2.ll
######
c.nums <- env("0" = 1, "1" = 2, "2" = 3) # create a global value
c.i <- 0
######
v.0 <- load(c.i)
arrayidx <- gep(ptr(c.nums), v.0)
v.1 <- load(arrayidx)

######
# array3.ll
######
c.nums <- env("0" = list("0" = 1, "1" = 2, "2" = 3),
              "1" = list("0" = 2, "1" = 3, "2" = 4),
              "2" = list("0" = 3, "1" = 4, "2" = 5)) # create a global value
c.i <- 0
######
v.0 <- load(c.i)
arrayidx <- gep(ptr(c.nums), v.0)
v.1 <- load(c.i)
arrayidx1 <- gep(arrayidx, v.1)
v.2 <- load(arrayidx1)

######
# array4.ll
######
c.nums <- env("0" = list("0" = 1, "1" = 2, "2" = 3),
              "1" = list("0" = 2, "1" = 3, "2" = 4),
              "2" = list("0" = 3, "1" = 4, "2" = 5)) # create a global value
c.i <- 0
######
v.0 <- load(c.i)
arrayidx <- gep(ptr(c.nums), v.0)
v.1 <- load(c.i)
v.add <- add(v.1, 1)
arrayidx1 <- gep(arrayidx, v.add)
v.2 <- load(arrayidx1)

######
# array5.ll
######
c.arr <- env("0" = list("0" = list("0" = 1, "1" = 2, "2" = 3, "3" = 4),
                        "1" = list("0" = 5, "1" = 2, "2" = 3, "3" = 4),
                        "2" = list("0" = 1, "1" = 2, "2" = 3, "3" = 4)),
             "1" = list("0" = list("0" = 1, "1" = 2, "2" = 3, "3" = 4),
                        "1" = list("0" = 1, "1" = 2, "2" = 3, "3" = 4),
                        "2" = list("0" = 1, "1" = 2, "2" = 3, "3" = 4))) # create a global value
c.i <- 0
c.k <- 0
######
v.0 <- load(c.i)
idxprom <- sext(v.0)
arrayidx <- gep(ptr(c.arr), idxprom)
v.1 <- load(c.i)
v.add <- add(v.1, 1)
idxprom1 <- sext(v.add)
arrayidx2 <- gep(arrayidx, idxprom1)
v.2 <- load(c.k)
idxprom3 <- sext(v.2)
arrayidx4 <- gep(arrayidx2, idxprom3)
v.3 <- load(arrayidx4)
v.conv <- sext(v.3)

######
# local1.ll
######
c.__const.index_first.nums <- env("0" = 1, "1" = 2, "2" = 3) # create a global value
######
v.nums <- env("0" = 0, "1" = 0, "2" = 0) # create a local value
v.i <- 0 # alloca
a.0 <- bitcast(ptr(v.nums))
memcpy(a.0, ptr(c.__const.index_first.nums))
store(2, v.i)
v.1 <- load(v.i)
arrayidx <- gep(ptr(v.nums), v.1)
v.2 <- load(arrayidx)

#####
nums <- array(0, dim = c(3))

three_d_array <- array(
  0,
  dim = c(4, 3, 2)
)

three_d_array[1, 3, 1] <- 5

three_d_array

x <- three_d_array[3,]

two_d_array <- array(
  0,
  dim = c(4, 3)
)

two_d_array[12] <- 12
two_d_array[11] <- 11
two_d_array

x <- two_d_array[3,]
x

options("StartupBanner" = "off")
library("distr")
library("distrEx")

getdistrOption("DistrCollapse")
getdistrOption("DistrCollapse.Unique.Warn")
getdistrOption("DistrResolution")
getdistrOption("withgaps")
getdistrOption("DefaultNrGridPoints")
getdistrOption("RtoDPQ.e")

x <- 4 + Exp(rate = 4)
x <- Binom(12, 0.7)
# x <- 5 * Pois(lambda = 1.2)
# x <- Unif(Min = 0, Max = 1)
# x <- DiscreteDistribution(supp = c(1, 0), prob = c(0.4, 0.6))
plot(x, mfColRow = FALSE, to.draw.arg = c("d", "p", "q"), bty = "7",
     panel.first = grid(lwd = 1), lwd = 1, vertical = FALSE, col.points = c("red", "black"), cex.points = 1.8)

A1 <- Norm(4, 1); A2 <- Unif(3, 4)
A1A2 <- A1 * A2
plot(A1A2)

A4 <- CompoundDistribution(SummandsDistr = Unif(3, 4), NumbOfSummandsDistr = DiscreteDistribution(c(1, 4)))
plot(A4)

lst <- list()
lst["x"] <- 5

v4 <- DiscreteDistribution(1:5)
sum <- v4 - DiscreteDistribution(supp = 1:5)
plot(sum)
mul <- sum * v4
plot(mul)

x <- DiscreteDistribution(supp = 1:5)
x.addr <- x
result <- 1
i <- 1
v2 <- x.addr
v3 <- i
sub <- v2 - v3
v4 <- DiscreteDistribution(supp = 1:5)
mul <- v4 * sub

i <- 0
v0 <- i
cmp <- v0 - 3
if (is.numeric(cmp))if (is.integer(cmp)) DiscreteDistribution(cmp) else
  cmp <- p(cmp)(-1)
print(cmp)

x <- DiscreteDistribution(supp = 0:10)
plot(x)
x.addr <- DiscreteDistribution(0)
result <- DiscreteDistribution(0)
i <- DiscreteDistribution(0)
x.addr <- x
result <- DiscreteDistribution(1)
i <- DiscreteDistribution(0)

v0 <- i
v1 <- x.addr
cmp <- v0 - v1;
cmp <- p(cmp)(-1)

v2 <- DiscreteDistribution(supp = 0:10)
v3 <- DiscreteDistribution(0)
sub <- v2 - v3
v4 <- DiscreteDistribution(1)
mul <- v4 * DiscreteDistribution(supp = 1:10, .withSim = T)
mul@.withSim <- T
plot(mul)
mul <- Norm() * Norm()
plot(mul)
result <- mul

library(igraph)

demo(package = "igraph")


library("cli")
cat(symbol$tick, " SUCCESS\n", symbol$cross, " FAILURE\n", sep = "")

## All symbols
cat(paste(format(names(symbol), width = 20),
          unlist(symbol)), sep = "\n")


options("StartupBanner" = "off")
library("distr")
library("distrEx")
X <- DiscreteDistribution(supp = c(1, 2, 3), prob = c(0.2, 0.5, 0.3))
plot(X)
plot(2 * X)
plot(2 + X)

L <- Logis(location = 1, scale = 1)
# L is a logistic distribution with location = 1 and scale = 1.
plot(L)

Z <- Norm(2, 1)
plot(abs(Z))


X <- Exp(1)
plot(X)
Y <- Exp(4)
plot(4 * Y)
X <- Exp(2)
plot(X)
2 - -6.000000e+00