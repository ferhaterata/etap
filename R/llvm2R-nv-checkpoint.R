# Title     : llvm2R-nv-checkpoint.R
# Objective : Development of checkpoint and restore methods
# Created by: enesvarcan
# Created on: 23.01.2021

### Idea
# The idea is to copy all memory content (stack, heap, global, memptrs) into the non-volatile memory to keep the data.

### Implementation
source("./R/llvm2R-functions.R")

checkpoint <- function() {
  memelements <- c(substitute(global), substitute(heap), substitute(memptrs), substitute(stack), substitute(sym), substitute(typ))

  for (i in memelements) {
    nv[[toString(i)]] <- env_clone(eval(i))
  }
}

restore <- function() {
  memelements <- c(substitute(global), substitute(heap), substitute(memptrs), substitute(stack), substitute(sym), substitute(typ))

  for (i in memelements) {
    eval.parent(str2expression(paste0(deparse(i), "<- env_clone(nv[[", dQuote(toString(i)), "]])")))
  }
}

### Example program

## struct8.ll
source("./R/llvm2R-functions.R")
# global
typ$"%struct.ST" <- "%struct.RT, i32, %struct.RT"
typ$"%struct.RT" <- "i32, [3 x [2 x i32]], i32"
sym$"st" <- galloc("[2 x %struct.ST]", 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0)
# local
sym$"retval" <- alloca("i32")
sym$"s" <- alloca("%struct.ST*")
sym$"i" <- alloca("i32")
store(0, sym$"retval")
store(2, gep("[2 x %struct.ST]", sym$"st", 0, 1, 2, 1, 2, 1))
store(gep("[2 x %struct.ST]", sym$"st", 0, 1), sym$"s")
checkpoint()
sym$"0" <- load(sym$"s")
sym$"Z" <- gep("%struct.ST", sym$"0", 0, 2)
sym$"B" <- gep("%struct.RT", sym$"Z", 0, 1)
sym$"arrayidx" <- gep("[3 x [2 x i32]]", sym$"B", 0, 2)
sym$"arrayidx1" <- gep("[2 x i32]", sym$"arrayidx", 0, 1)
### POWER FAILURE ###
restore()
sym$"0" <- load(sym$"s")
sym$"Z" <- gep("%struct.ST", sym$"0", 0, 2)
sym$"B" <- gep("%struct.RT", sym$"Z", 0, 1)
sym$"arrayidx" <- gep("[3 x [2 x i32]]", sym$"B", 0, 2)
sym$"arrayidx1" <- gep("[2 x i32]", sym$"arrayidx", 0, 1)
sym$"1" <- load(sym$"arrayidx1")
store(sym$"1", sym$"i")
sym$"2" <- load(sym$"i")
ret(sym$"2") # 2
if (sym$"2" != 2) message("TEST - Wrong ret value for: struct8.ll\n")