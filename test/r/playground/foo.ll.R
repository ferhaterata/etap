entry <- list(
  name = "entry",
  insts = list(
    "retval <- Unif(-1000,1000)",
    "x.addr <- Unif(-1000,1000)",
    "y.addr <- Unif(-1000,1000)",
    "a <- Unif(-1000,1000)",
    "x.addr <- x",
    "y.addr <- y",
    "v0 <- x.addr",
    "v1 <- y.addr",
    "add <- v1 + 6.000000e+00",
    "cmp <- v0 - add; cmp <- p(cmp)(0)",
    "entry_if.then <- round(cmp, 2); entry_if.end4 <- round(1 - cmp, 2)"))

if.then <- list(
  name = "if.then",
  insts = list(
    "v2 <- y.addr",
    "mul <- 2.000000e+00 * v2",
    "a <- mul",
    "v3 <- a",
    "cmp1 <- v3 - -2.000000e+00; cmp1 <- 1 - p(cmp1)(0)",
    "if.then_if.then2 <- round(cmp1, 2); if.then_if.end <- round(1 - cmp1, 2)"))

if.then2 <- list(
  name = "if.then2",
  insts = list(
    "v4 <- x.addr",
    "v5 <- y.addr",
    "mul3 <- v4 * v5",
    "retval <- mul3",
    "if.then2_return <- 1.00"))

if.end <- list(
  name = "if.end",
  insts = list(
    "if.end_if.end4 <- 1.00"))

if.end4 <- list(
  name = "if.end4",
  insts = list(
    "v6 <- x.addr",
    "retval <- v6",
    "if.end4_return <- 1.00"))

return <- list(
  name = "return",
  insts = list(
    "v7 <- retval",
    "ret <- v7"))

entry$pred <- list()
entry$succ <- list(if.then, if.end4)

if.then$pred <- list(entry)
if.then$succ <- list(if.then2, if.end)

if.then2$pred <- list(if.then)
if.then2$succ <- list(return)

if.end$pred <- list(if.then)
if.end$succ <- list(if.end4)

if.end4$pred <- list(if.end, entry)
if.end4$succ <- list(return)

return$pred <- list(if.end4, if.then2)
return$succ <- list()


foo <- list(
  name = "foo",
  formals = "x <- Norm(mean=11, sd=1); y <- Norm(mean=5, sd=1);",
  blocks = list(entry, if.then, if.then2)
)

entry$

#--------------------------
#cat(str(foo))
foo$blocks[[1]]$insts
foo$blocks[[1]]$succ[[1]]$name
#--------------------------
library("distr")
library("distrEx")
#--------------------------
# Path 1
#--------------------------
eval(parse(text = foo$formals))
for (inst in entry$blocks[[1]]$insts) {
  eval(parse(text = inst))
}

for (inst in foo$blocks[[2]]$insts) {
  eval(parse(text = inst))
}

for (inst in foo$blocks[[3]]$insts) {
  eval(parse(text = inst))
}
#--------------------------
distrEx::E(mul)

