################################################################################
rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
library("rlang")
options(useFancyQuotes = FALSE)

# <result> = add <ty> <var1>, <var2>gg
add <- function(var1, var2) var1 + var2
sub <- function(var1, var2) var1 - var2
mul <- function(var1, var2) var1 * var2
div <- function(var1, var2) var1 / var2
rem <- function(var1, var2) var1 %% var2

foo <- function(p1, p2) {
  p1name <- deparse(substitute(p1))
  p2name <- deparse(substitute(p2))

  # The real function runs a simulation, but
  # here we just confirm the object names
  # and values passed as args
  cat("passed", p1name, "with value", p1, "\n")
  cat("passed", p2name, "with value", p2, "\n")
}


ret <- function(value) {
  print(value)
  if (is.numeric(value)) value <- distr::DiscreteDistribution(value)
  return(value)
}

sext <- function(value) value
zext <- function(value) value
# always returns pointer
bitcast <- function(pointer) pointer


# Memory is allocated; a pointer is returned. The allocated memory is
# uninitialized, and loading from uninitialized memory produces an undefined
# value. The operation itself is undefined if there is insufficient stack space
# for the allocation.’alloca’d memory is automatically released when the
# function returns. The ‘alloca’ instruction is commonly used to represent
# automatic variables that must have an address available. When the function
# returns (either with the ret or resume instructions), the memory is reclaimed.
# Allocating zero bytes is legal, but the returned pointer may not be unique.
# The order in which memory is allocated (ie., which way the stack grows) is
# not specified.
make.alloca <- function() {
  location <- -1

  # Env: Varable -> Location
  # Store: Location -> Value
  f <- function(type) {
    location <<- location + 1
    if (type == "int" || type == "float")
      eval.parent(str2expression(paste0("\"", location, "\" <- 0")))
    else if (type == "int*" || type == "float*")
      eval.parent(str2expression(paste0("\"", location, "\" <- \"null\"")))
    else if (type == "struct" || type == "array")
      eval.parent(str2expression(paste0("\"", location, "\" <- env()")))
    else if (type == "struct*" || type == "array*")
      eval.parent(str2expression(paste0("\"", location, "\" <- \"null\"")))
    return(paste0("`", location, "`"))
  }

  return(f)
}

# %ptr = alloca i32                             ; yields i32*:ptr
# %ptr = alloca i32, i32 4                      ; yields i32*:ptr
# %ptr = alloca i32, i32 4, align 1024          ; yields i32*:ptr
# %ptr = alloca i32, align 1024                 ; yields i32*:ptr
alloca <- make.alloca()

# %ptr = alloca i                               ; yields i32*:ptr
# store i32 3, i32* %ptr                        ; yields void
# %val = load i32, i32* %ptr                    ; yields i32:val = i32 3
load <- function(ptr) {
  eval.parent(str2expression(ptr))
}

# The contents of memory are updated to contain <value> at the location specified
# by the <pointer> operand.
# store <ty> <value>, <ty>* <pointer>
store <- function(val, ptr) {
  # print(ptr)
  if (substr(ptr, 1, 4) == "heap") {
    if (is.environment(eval.parent(str2expression(paste(ptr)))))
      ptr <- paste0(ptr, "$`0`")
  }
  # print(ptr)
  eval.parent(str2expression(paste(ptr, "<-", deparse(substitute(val)))))
}

# The ‘getelementptr’ instruction is used to get the address of a subelement of
# an aggregate data structure. It performs address calculation only and does
# not access memory. The instruction can also be used to calculate a vector of
# such addresses.
gep <- function(pointer, base, ...) {
  indices <- list(...)
  if (length(indices) == 0) { # base pointer case (e.g. pointer arithmetics on arrays)
    if (!length(grep(".*\\$\\\".*?\\\"$", pointer))) # the case where there is no `$`
      return(paste0(pointer, "$", dQuote(base)))
    index <- paste0(gsub("(.*\\$)\\\"(.*?)\\\"$", "\\2+", pointer), base)
    last <- eval(str2expression(index))
    pointer <- gsub("(.*\\$)\\\"(.*?)\\\"$", paste0("\\1", dQuote(last)), pointer)
    return(pointer)
  }
  # the normal case
  ptr <- base
  for (index in seq_along(indices)) {
    i <- indices[[index]]
    if (is(i, "Distribution")) i <- q(i)(1) # generate a random number
    if (index == 1)
      ptr <- paste0(pointer, "$", dQuote(ptr + i))
    else ptr <- paste0(ptr, "$", dQuote(i))
  }
  return(ptr)
}

memcpy <- function(destPtr, srcPtr) {
  eval.parent(str2expression(paste0(destPtr, " <- env_clone(", srcPtr, ")"))) # clones the environment
}

memmve <- function(destPtr, srcPtr) {
  eval.parent(str2expression(paste0(destPtr, " <- env_clone(", srcPtr, ")"))) # clones the environment
}

ptr <- function(element)
  eval(deparse(substitute(element)))

heap <- rlang::env()

make.heap <- function(method) {
  location <- -1

  malloc <- function() {
    location <<- location + 1
    eval.parent(str2expression(paste0("heap$\"", location, "\" <- env()")))
    return(paste0("heap$\"", location, "\""))
  }

  free <- function(ptr) {
    # print(ptr)
    # print(nchar(ptr))
    index <- substr(ptr, 7, nchar(ptr) - 1)
    # print(index)
    eval.parent(str2expression(paste0("remove(envir=heap, \"", index, "\")")))
  }

  if (method == "malloc")
    return(malloc)
  if (method == "free")
    return(free)

  stop("unknown method llvm::malloc!")
}

malloc <- make.heap("malloc")
free <- make.heap("free")

false <- 0
true <- 1

eq <- "eq"
ne <- "ne"
ugt <- "ugt"
uge <- "uge"
ult <- "ult"
ule <- "ule"
sgt <- "sgt"
sge <- "sge"
slt <- "slt"
sle <- "sle"


# https://llvm.org/docs/LangRef.html#icmp-instruction
icmp <- function(cond, left, right) {
  # EXAMPLE ------------------------------
  # F(x ≤ 3) = F(x ≤ 3)
  # F(x < 3) = F(x ≤ 2)
  # F(x = 3) = F(x ≤ 3) - F(x ≤ 2)
  # F(x ≠ 3) = 1 - F(x ≤ 3) + F(x ≤ 2)
  # F(x > 3) = 1 - F(x ≤ 3)
  # F(x ≥ 3) = 1 - F(x < 3) = 1 - F(x ≤ 2)
  # --------------------------------------
  cmp <- left - right;
  if (is.numeric(cmp)) cmp <- distr::DiscreteDistribution(cmp);
  cmp.true <- cmp; cmp.false <- cmp
  # F(x ≤ 0) = F(x ≤ 0)
  if (cond == sle || cond == ule) {
    mass <- distr::p(cmp)(0)
    if (1 > mass && mass > 0) {
      cmp.true <- distr::Truncate(cmp, lower = -Inf, upper = 0)
      cmp.false <- distr::Truncate(cmp, lower = 1, upper = Inf)
    }
    return(c(mass, cmp.true, cmp.false))
  }
  # F(x < 0) = F(x ≤ -1)
  if (cond == slt || cond == ult) {
    mass <- distr::p(cmp)(-1)
    if (1 > mass && mass > 0) {
      cmp.true <- distr::Truncate(cmp, lower = -Inf, upper = -1)
      cmp.false <- distr::Truncate(cmp, lower = 0, upper = Inf)
    }
    return(c(mass, cmp.true, cmp.false))
  }
  # F(x = 0) = F(x ≤ 0) - F(x ≤ -1)
  if (cond == eq) {
    mass <- distr::p(cmp)(0) - distr::p(cmp)(-1)
    if (1 > mass && mass > 0) {
      cmp.true <- distr::DiscreteDistribution(0)
      support <- distr::support(cmp)
      prob <- distr::prob(cmp)[[match(0, distr::support(cmp))]] / (length(support) - 1)
      distribute <- function(x) x + prob
      probs <- lapply(distr::prob(cmp)[-match(0, support)], FUN = distribute)
      cmp.false <- distr::DiscreteDistribution(supp = distr::support(cmp)[distr::support(cmp) != 0], prob = unlist(probs))
    }
    return(c(mass, cmp.true, cmp.false))
  }
  # F(x ≠ 0) = 1 - F(x ≤ 0) + F(x ≤ -1)
  if (cond == ne) {
    mass <- 1 - distr::p(cmp)(0) + distr::p(cmp)(-1)
    if (1 > mass && mass > 0) {
      cmp.false <- distr::DiscreteDistribution(0)
      support <- distr::support(cmp)
      prob <- distr::prob(cmp)[[match(0, distr::support(cmp))]] / (length(support) - 1)
      distribute <- function(x) x + prob
      probs <- lapply(distr::prob(cmp)[-match(0, support)], FUN = distribute)
      cmp.true <- distr::DiscreteDistribution(supp = distr::support(cmp)[distr::support(cmp) != 0], prob = unlist(probs))
    }
    return(c(mass, cmp.true, cmp.false))
  }
  # F(x > 0) = 1 - F(x ≤ 0)
  if (cond == sgt || cond == ugt) {
    mass <- 1 - distr::p(cmp)(0)
    if (1 > mass && mass > 0) {
      cmp.true <- distr::Truncate(cmp, lower = 1, upper = Inf)
      cmp.false <- distr::Truncate(cmp, lower = -Inf, upper = 0)
    }
    return(c(mass, cmp.true, cmp.false))
  }
  # F(x ≥ 0) = 1 - F(x < 0) = 1 - F(x ≤ -1)
  if (cond == sge || cond == uge) {
    mass <- 1 - distr::p(cmp)(0)
    if (1 > mass && mass > 0) {
      cmp.true <- distr::Truncate(cmp, lower = 0, upper = Inf)
      cmp.false <- distr::Truncate(cmp, lower = -Inf, upper = -0.1)
    }
    return(c(mass, cmp.true, cmp.false))
  }
  stop("unknown cond in llvm::icmp!")
}

n <- distr::DiscreteDistribution(supp = 1:4)
v.cmp <- icmp(slt, n, 2)

# x {2,3,4,5}
x <- distr::DiscreteDistribution(supp = 2:5)
plot(x)
# x > 3 {4,5}
x.T <- distr::DiscreteDistribution(supp = 4:5)
plot(x.T)
x.T <- distr::Truncate(x, lower = 4, upper = 5)
plot(x.T)
# x <= 3 {2,3}
x.F <- distr::DiscreteDistribution(supp = 2:3)
plot(x.F)
x.F <- distr::Truncate(x, lower = 2, upper = 3)
plot(x.F)
# y {4,5,6,7}
y <- distr::DiscreteDistribution(supp = 4:7)
plot(y)
# (x > y) -> (x - y > 0)

mindistr <- distr::Minimum(x.T, y)
plot(mindistr)

maxdistr <- distr::Maximum(x.T, y)
plot(maxdistr)

maxdistr <- distr::Maximum(y, x.T)
plot(maxdistr)

cmp <- x.T - y # Convolution (dynamic dispatch to convolution)
cmp <- x - y
plot(cmp)
x.T <- cmp - y
plot(x.T)
# P(cmp > 0) = 1 - P(cmp <= 0) = 1 - F(cmp)
t.p <- 1 - p(cmp)(0) # probability
f.p <- 1 - t.p


1 / 16
5 * 1 / 2 * 1 / 4 # intuituion

7 / 16

oeq <- "oeq"
ogt <- "ogt"
oge <- "oge"
olt <- "olt"
ole <- "ole"
one <- "one"
ord <- "ord"
ueq <- "ueq"
une <- "une"
uno <- "uno"

# https://llvm.org/docs/LangRef.html#fcmp-instruction
fcmp <- function(cond, left, right) {
  # EXAMPLE ------------------------------
  # F(x ≤ 3) = F(x ≤ 3.01)
  # F(x < 3) = F(x ≤ 2.99)
  # F(x = 3) = F(x ≤ 3.01) - F(x ≤ 2.99)
  # F(x ≠ 3) = 1 - F(x = 3) = 1 - F(x ≤ 3.01) + F(x ≤ 2.99)
  # F(x > 3) = 1 - F(x ≤ 3) = 1 - F(x ≤ 3.01)
  # F(x ≥ 3) = 1 - F(x < 3) = 1 - F(x ≤ 2.99)
  # --------------------------------------
  delta <- 0.01
  cmp <- left - right;
  if (is.numeric(cmp)) cmp <- distr::DiscreteDistribution(cmp)
  cmp.true <- cmp; cmp.false <- cmp
  # F(x ≤ 0) = F(x ≤ 0.01)
  if (cond == ule || cond == ole) {
    mass <- distr::p(cmp)(delta)
    if (1 > mass && mass > 0) {
      cmp.true <- distr::Truncate(cmp, lower = -Inf, upper = 0)
      cmp.false <- distr::Truncate(cmp, lower = 0, upper = Inf)
    }
    return(c(mass, cmp.true, cmp.false))
  }
  # F(x < 0) = F(x ≤ -0.01)
  if (cond == ult || cond == olt) {
    mass <- distr::p(cmp)(-delta)
    if (1 > mass && mass > 0) {
      cmp.true <- distr::Truncate(cmp, lower = -Inf, upper = 0)
      cmp.false <- distr::Truncate(cmp, lower = 0, upper = Inf)
    }
    return(c(mass, cmp.true, cmp.false))
  }
  # F(x = 0) = F(x ≤ 0.01) - F(x ≤ -0.01)
  if (cond == ueq || cond == oeq) {
    cmp.true <- distr::DiscreteDistribution(0)
    cmp.false <- cmp
    return(c(distr::p(cmp)(delta) - distr::p(cmp)(-delta), cmp.true, cmp.false))
  }
  # F(x ≠ 0) = 1 - F(x = 0) = 1 - F(x ≤ 0.01) + F(x ≤ -0.01)
  if (cond == une || cond == one) {
    cmp.false <- distr::DiscreteDistribution(0)
    cmp.true <- cmp
    return(c(1 - distr::p(cmp)(delta) + distr::p(cmp)(-delta), cmp.true, cmp.false))
  }
  # F(x > 0) = 1 - F(x ≤ 0) = 1 - F(x ≤ 0.01)
  if (cond == ugt || cond == ogt) {
    mass <- 1 - distr::p(cmp)(delta)
    if (1 > mass && mass > 0) {
      cmp.true <- distr::Truncate(cmp, lower = 0, upper = Inf)
      cmp.false <- distr::Truncate(cmp, lower = -Inf, upper = 0)
    }
    return(c(mass, cmp.true, cmp.false))
  }
  # F(x ≥ 0) = 1 - F(x < 0) = 1 - F(x ≤ -0.01)
  if (cond == uge || cond == oge) {
    mass <- 1 - distr::p(cmp)(-delta)
    if (1 > mass && mass > 0) {
      cmp.true <- distr::Truncate(cmp, lower = 0, upper = Inf)
      cmp.false <- distr::Truncate(cmp, lower = -Inf, upper = 0)
    }
    return(c(mass, cmp.true, cmp.false))
  }
  # FALSE
  if (cond == false) {
    return(c(0.00, cmp.true, cmp.false))
  }
  # TRUE
  if (cond == true) {
    return(c(1.00, cmp.true, cmp.false))
  }
  stop("unknown cond in llvm::fcmp!")
}

n <- Unif(1, 4)
v.cmp <- fcmp(ule, n, 2)

# https://llvm.org/docs/LangRef.html#br-instruction
br <- function(iftrue, iffalse, cond) {
  t_name <- deparse(substitute(iftrue))
  if (missing(iffalse)) { #unconditional branch
    eval.parent(str2expression(paste0(.block$name, "_", t_name, " <- round(1.00)")))
  } else { #conditional branch
    f_name <- deparse(substitute(iffalse))
    c_name <- deparse(substitute(cond))
    eval.parent(str2expression(paste0(.block$name, "_", t_name, " <- ", cond[1])))
    eval.parent(str2expression(paste0(.block$name, "_", f_name, " <- 1 - ", cond[1])))
    if (length(cond) > 1) { # this for those cases where phi being used before br.
      eval.parent(str2expression(paste0(c_name, ".true <- ", c_name, "[[2]]")))
      eval.parent(str2expression(paste0(c_name, ".false <- ", c_name, "[[3]]")))
    }
  }
  eval.parent(str2expression(paste0(.block$name, " <- T")))
  for (pred in .block$preds) {
    eval.parent(str2expression(paste0(pred, " <- F")))
  }
}

block.this <- env(
  name = "entry",
  preds = list("if.end"),
  succs = list("if.then", "if.end3"),
  insts = list(
    list("p.retval <- alloca(\"int\")", ""),
    list("p.n.addr <- alloca(\"int\")", ""),
    list("p.x <- alloca(\"int\")", ""),
    list("p.xp <- alloca(\"int*\")", ""),
    list("store(n, p.n.addr)", "n <- load(p.n.addr)"),
    list("v.0 <- load(p.n.addr)", "store(v.0, p.n.addr)"),
    list("store(v.0, p.x)", "v.0 <- load(p.x)"),
    list("store(p.x, p.xp)", "p.x <- load(p.xp)"),
    list("v.1 <- load(p.n.addr)", "store(v.1, p.n.addr)"),
    list("v.cmp <- icmp(sgt, v.1, 1)", ""),
    # list("entry_if.then <- round(v.cmp, 2); entry_if.end3 <- round(1 - v.cmp, 2); entry <- T", "")))
    list("br(if.then, if.end, v.cmp)", "")))

entry <- F; if.then <- F; if.then2 <- F; if.end <- F; if.end3 <- F; return <- F
v.1 <- DiscreteDistribution(supp = 1:4)
v.cmp <- icmp(sgt, v.1, 1)
br(if.then, if.end, v.cmp)
br(if.end3)

rollback <- function() { }


U1 <- Unif(Min = 0, Max = 1)
U3 <- distr::convpow(U1, N = 3)

conv <- function(var1, var2) {
  if (is.character(var2) && var2 == "void")
    return(var2)
  if (is.numeric(var2)) var2 <- DiscreteDistribution(var2)
  if (is(var1, "Distribution")) {
    return(var1 + var2)
  }
  else return(var2)
}

mix <- function(var1, var2) {
  if (is.character(var2) && var2 == "void")
    return(var2)
  if (is.numeric(var2)) var2 <- DiscreteDistribution(var2)
  if (is(var1, "Distribution")) {
    return(UnivarMixingDistribution(var1, var2))
  }
  else return(var2)
}

energy <- env()

E <- function(inst) {
  inst <- deparse(substitute(inst))
  if (inst %in% names(energy))
    return(energy[[inst]])
  else if ("default" %in% names(energy))
    return(energy$default)
  else return(0)
}

timing <- env()

T <- function(inst) {
  inst <- deparse(substitute(inst))
  if (inst %in% names(timing))
    return(timing[[inst]])
  else if ("default" %in% names(timing))
    return(timing$default)
  else return(0)
}

################################################################################
rm(list = setdiff(ls(), lsf.str()))
######
# array1.ll
######
c.nums <- env("0" = 1, "1" = 2, "2" = 3) # create a global value
######
v.0 <- load(gep(ptr(c.nums), 1))
v.0 <- load(gep(ptr(c.nums), 0, 1))
v.0 <- load(gep(ptr(c.nums), 0, 0))
ret(v.0)
# 1

rm(list = setdiff(ls(), lsf.str()))
######
# array2.ll
######
c.nums <- env("0" = 1, "1" = 2, "2" = 3) # create a global value
c.i <- 1
######
v.0 <- load(ptr(c.i))
p.arrayidx <- gep(ptr(c.nums), 0, v.0)
v.1 <- load(p.arrayidx)
ret(v.1)
# 2

rm(list = setdiff(ls(), lsf.str()))
######
# array3.ll
######
c.nums <- env("0" = list("0" = 1, "1" = 2, "2" = 3),
              "1" = list("0" = 2, "1" = 3, "2" = 4),
              "2" = list("0" = 3, "1" = 4, "2" = 5))
# create a global value
c.i <- 2
######
v.0 <- load(ptr(c.i))
p.arrayidx <- gep(ptr(c.nums), 0, v.0)
v.1 <- load(ptr(c.i))
p.arrayidx1 <- gep(p.arrayidx, 0, v.1)
v.2 <- load(p.arrayidx1)
ret(v.2)
# 5

rm(list = setdiff(ls(), lsf.str()))
######
# array4.ll
######
c.nums <- env("0" = list("0" = 1, "1" = 2, "2" = 3),
              "1" = list("0" = 2, "1" = 3, "2" = 4),
              "2" = list("0" = 3, "1" = 4, "2" = 5)) # create a global value
c.i <- 1
######
v.0 <- load(ptr(c.i))
p.arrayidx <- gep(ptr(c.nums), 0, v.0)
v.1 <- load(ptr(c.i))
p.arrayidx1 <- gep(p.arrayidx, 0, v.1)
v.2 <- load(p.arrayidx1)
ret(v.2)
# 3

rm(list = setdiff(ls(), lsf.str()))
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
v.0 <- load(ptr(c.i))
v.idxprom <- sext(v.0)
p.arrayidx <- gep(ptr(c.arr), 0, v.idxprom)
v.1 <- load(ptr(c.i))
v.add <- add(v.1, 1)
v.idxprom1 <- sext(v.add)
p.arrayidx2 <- gep(p.arrayidx, 0, v.idxprom1)
v.2 <- load(ptr(c.k))
v.idxprom3 <- sext(v.2)
p.arrayidx4 <- gep(p.arrayidx2, 0, v.idxprom3)
v.3 <- load(p.arrayidx4)
v.conv <- sext(v.3)
ret(v.conv)
# 5

################################################################################
rm(list = setdiff(ls(), lsf.str()))
alloca <- make.alloca()
######
# local1.ll
######
c.__const.index_first.nums <- env("0" = 1, "1" = 2, "2" = 3) # create a global value
######
p.nums <- alloca("array")
p.n <- alloca("int")
p.0 <- bitcast(p.nums)
memcpy(p.0, ptr(c.__const.index_first.nums))
p.arrayidx <- gep(p.nums, 0, 2)
v.1 <- load(p.arrayidx)
v.add <- add(v.1, 2)
store(v.add, p.n)
v.2 <- load(p.n)
ret(v.2)
# 5

rm(list = setdiff(ls(), lsf.str()))
alloca <- make.alloca()
######
# local2.ll
######
c.__const.index_i.nums <- env("0" = 1, "1" = 2, "2" = 3) # create a global value
######
p.nums <- alloca("array")
p.i <- alloca("int")
p.0 <- bitcast(p.nums)
memcpy(p.0, ptr(c.__const.index_i.nums))
store(2, p.i)
v.1 <- load(p.i)
p.arrayidx <- gep(p.nums, 0, v.1)
v.2 <- load(p.arrayidx)
ret(v.2)
# 3

rm(list = setdiff(ls(), lsf.str()))
alloca <- make.alloca()
######
# local3.ll
######
c.__const.index_i2.nums <- env("0" = list("0" = 1, "1" = 2, "2" = 3),
                               "1" = list("0" = 2, "1" = 3, "2" = 4),
                               "2" = list("0" = 3, "1" = 4, "2" = 5))
######
p.nums <- alloca("array")
p.i <- alloca("int")
p.i1 <- alloca("int")
p.0 <- bitcast(p.nums)
memcpy(p.0, ptr(c.__const.index_i2.nums))
store(2, p.i)
store(1, p.i1)
v.1 <- load(p.i)
p.arrayidx <- gep(p.nums, 0, v.1)
v.2 <- load(p.i)
p.arrayidx2 <- gep(p.arrayidx, 0, v.2)
v.3 <- load(p.arrayidx2)
ret(v.3)
# 5

rm(list = setdiff(ls(), lsf.str()))
alloca <- make.alloca()
######
# local4.ll
######
c.__const.main.foo <- env("0" = 0, "1" = 1) # create a global value
######
p.retval <- alloca("int") # alloca i32
p.foo <- alloca("struct") #alloca %struct.foo
p.bar <- alloca("struct*") # alloca %struct.foo*
store(0, p.retval)
p.0 <- bitcast(p.foo)
memcpy(p.0, ptr(c.__const.main.foo))
p.a <- gep(p.foo, 0, 0)
store(2, p.a)
store(p.foo, p.bar)
p.1 <- load(p.bar)
p.b <- gep(p.1, 0, 1)
v.2 <- load(p.b)
ret(v.2)
# 1

rm(list = setdiff(ls(), lsf.str()))
alloca <- make.alloca()
######
# local5.ll
######
p.b <- alloca("int") # alloca i32
p.a <- alloca("int*") # alloca i32*
store(5, p.b)
store(p.b, p.a) # i32* %b, i32** %a
p.0 <- load(p.a) # i32** %a -> i32*
v.1 <- load(p.0) # i32* %0 -> i32
ret(v.1)
# 5


rm(list = setdiff(ls(), lsf.str()))
alloca <- make.alloca()
######
# local6.ll
######
c.__const.main.foo <- env("0" = 0, "1" = 1, "2" = list("0" = 5, "1" = 3)) #alloca %struct.foo
######
p.retval <- alloca("int") # alloca i32
p.b <- alloca("int") # alloca i32
p.a <- alloca("int*") # alloca i32*
p.foo <- alloca("struct") #alloca %struct.foo
store(0, p.retval)
store(5, p.b)
store(p.b, p.a) # i32* %b, i32** %a
p.0 <- bitcast(p.foo)
memcpy(p.0, ptr(c.__const.main.foo))
p.1 <- load(p.a) # i32*, i32** %a
v.2 <- load(p.1)
p.a1 <- gep(p.foo, 0, 0)
store(v.2, p.a1)
p.bar <- gep(p.foo, 0, 2)
p.c <- gep(p.bar, 0, 0)
v.3 <- load(p.c)
ret(v.3)
# 5

################################################################################
rm(list = setdiff(ls(), lsf.str()))
alloca <- make.alloca()
######
# struct2.ll
######
c.foo <- env("0" = list("0" = 0, "1" = 1, "2" = 0),
             "1" = list("0" = 2, "1" = 3, "2" = 0),
             "2" = list("0" = 4, "1" = 5, "2" = 0)) # create a global value
######
i <- 2 # function's formal parameter; assume its value is 2
i <- DiscreteDistribution(supp = 0:2) # REVIEW: generate random number; actually a better way is to execute here probabilistically
p.i.addr <- alloca("int") # alloca i32
store(i, p.i.addr)
v.0 <- load(p.i.addr)
v.idxprom <- sext(v.0)
p.arrayidx <- gep(ptr(c.foo), 0, v.idxprom)
p.b <- gep(p.arrayidx, 0, 1)
v.1 <- load(p.b)
ret(v.1)
# 5

rm(list = setdiff(ls(), lsf.str()))
alloca <- make.alloca()
######
# struct3.ll
######
i <- 2 # function's formal parameter; assume its value is 2
p.i.addr <- alloca("int")
p.foo <- alloca("array")
store(i, p.i.addr)
v.0 <- load(p.i.addr)
v.idxprom <- sext(v.0)
p.arrayidx <- gep(p.foo, 0, v.idxprom)
p.b <- gep(p.arrayidx, 0, 1)
store(4, p.b)
v.1 <- load(p.i.addr)
v.idxprom1 <- sext(v.1)
p.arrayidx2 <- gep(p.foo, 0, v.idxprom1)
p.b3 <- gep(p.arrayidx2, 0, 1)
v.2 <- load(p.b3)
ret(v.2)
# 4

# Types
# ################
# struct.S <- type { [2 x i32] }
#
# Symbol / Names             # we use lvalue of (<-) assingment operator of R
# #################
# @buf    "@buf"::global$"0" # implicit pointer
# retv    "retv"::stack$"0"
# p          "S"::stack$"1"
# call    "call"::stack$"2"
# nv        "nv"::stack$"3"
# 0          "0"::stack$"4"
#
# Global                     # global storage
# #################
# i32        "0"::0          # i32 0
# i32        "1"::1          # i32 1
# ?          "2"::?
#
# Stack                      # local stroage
# #################
# i32        "0"::0          # %retval = alloca i32, align
# struct S*  "1"::global$"0" # %p = alloca %struct.s*; store %struct.S* @buf, %struct.S** %p
# i8*        "2"::heap$"0"   # %call = call noalias i8* @malloc(i64 2)
# i8*        "3"::nv$"0"     # %nv = nvmalloc(sizeof(int)*2)
# struct S*  "4"::"1"        # %0 = load %struct.S*, %struct.S** %p
# ?          "5"::?
#
# Heap                       # dynamic strog
# #################
# i32        "0"::0
# i32        "1"::0
# ?          "2"::?
#
# Non-Volatile               # persistent memory region (new storage device)
# #################
# i32        "0"::0
# i32        "1"::0
# ?          "2"::?

rm(list = setdiff(ls(), lsf.str()))
alloca <- make.alloca()
######
# struct7.ll
######
c.buf <- env("0" = list("0" = 0, "1" = 1))
######
p.retval <- alloca("int")
p.p <- alloca("struct*")
store(0, p.retval)
store(ptr(c.buf), p.p)
store(3, gep(ptr(c.buf), 0, 0, 1))
p.0 <- load(p.p)
p.data <- gep(p.0, 0, 0)
p.arraydecay <- gep(p.data, 0, 0) # TODO: current model has some issues for array decays.
p.add.ptr <- gep(p.arraydecay, 1)
v.1 <- load(p.add.ptr)
ret(v.1)
# 3

rm(list = setdiff(ls(), lsf.str()))
alloca <- make.alloca()
######
# struct8.ll
######
c.st <- env("0" = list("0" = list("0" = 0,
                                  "1" = list("0" = list("0" = 0, "1" = 0),
                                             "1" = list("0" = 0, "1" = 0),
                                             "2" = list("0" = 0, "1" = 0)),
                                  "2" = 0),
                       "1" = 0,
                       "2" = list("0" = 0,
                                  "1" = list("0" = list("0" = 0, "1" = 0),
                                             "1" = list("0" = 0, "1" = 0),
                                             "2" = list("0" = 0, "1" = 0)),
                                  "2" = 0)),
            "1" = list("0" = list("0" = 0,
                                  "1" = list("0" = list("0" = 0, "1" = 0),
                                             "1" = list("0" = 0, "1" = 0),
                                             "2" = list("0" = 0, "1" = 0)),
                                  "2" = 0),
                       "1" = 0,
                       "2" = list("0" = 0,
                                  "1" = list("0" = list("0" = 0, "1" = 0),
                                             "1" = list("0" = 0, "1" = 0),
                                             "2" = list("0" = 0, "1" = 0)),
                                  "2" = 0)))

######
p.s <- alloca("struct*")
p.i <- alloca("int")
store(gep(ptr(c.st), 0, 1), p.s)
p.0 <- load(p.s)
p.arrayidx <- gep(p.0, 1)
p.Z <- gep(p.arrayidx, 0, 2)
p.B <- gep(p.Z, 0, 1)
p.arrayidx1 <- gep(p.B, 0, 2)
p.arrayidx2 <- gep(p.arrayidx1, 0, 1)
v.1 <- load(p.arrayidx2)
store(v.1, p.i)
v.2 <- load(p.i)
ret(v.2)

################################################################################

##### Example: malloc1.ll #####
rm(list = setdiff(ls(), lsf.str()))
heap <- env()
##### Example: malloc1.ll #####
#
alloca <- make.alloca()
#
p.foo <- alloca("struct*")
p.call <- malloc()
p.0 <- bitcast(p.call)
store(p.0, p.foo)
p.1 <- load(p.foo)
p.A <- gep(p.1, 0, 0)
store(12, p.A)
p.2 <- load(p.foo)
p.3 <- bitcast(p.2)
free(p.3)
ret("void")
#"void"

rm(list = setdiff(ls(), lsf.str()))
malloc <- make.heap("malloc")
free <- make.heap("free")
heap <- env()
##### Example: malloc2.ll #####
#
alloca <- make.alloca()
#
p.retval <- alloca("int")
p.i <- alloca("int*")
p.ret <- alloca("int")
store(0, p.retval)
p.call <- malloc()
p.0 <- bitcast(p.call)
store(p.0, p.i)
p.1 <- load(p.i)
store(12, p.1)
p.2 <- load(p.i)
p.add.ptr <- gep(p.2, 1)
store(24, p.add.ptr)
p.3 <- load(p.i)
p.arrayidx <- gep(p.3, 1)
v.4 <- load(p.arrayidx)
store(v.4, p.ret)
p.5 <- load(p.i)
p.6 <- bitcast(p.5)
v.7 <- load(p.ret)
ret(v.7)
# 24

##### Example: malloc3.ll #####
rm(list = setdiff(ls(), lsf.str()))
malloc <- make.heap("malloc")
free <- make.heap("free")
heap <- env()
alloca <- make.alloca()
##### Example: malloc3.ll #####
p.retval <- alloca("int")
p.data <- alloca("struct")
p.sp <- alloca("struct*")
p.a <- alloca("array")
store(0, p.retval)
p.call <- malloc()
p.0 <- bitcast(p.call)
store(p.0, p.sp)
p.1 <- load(p.sp)
p.p <- gep(p.1, 0, 0)
store(p.data, p.p)
p.2 <- load(p.sp)
p.p1 <- gep(p.2, 0, 0)
p.3 <- load(p.p1)
p.d <- gep(p.3, 0, 0)
store(3, p.d)
p.d2 <- gep(p.data, 0, 0)
v.4 <- load(p.d2)
p.arrayidx <- gep(p.a, 0, 1)
store(v.4, p.arrayidx)
p.arrayidx3 <- gep(p.a, 0, 1)
v.5 <- load(p.arrayidx3)
ret(v.5)
# 3

##### Example: struct4.ll #####
rm(list = setdiff(ls(), lsf.str()))
malloc <- make.heap("malloc")
free <- make.heap("free")
heap <- env()
alloca <- make.alloca()
##### Example: struct4.ll #####
c.s <- env("0" = list("0" = 0, "1" = "null"), "1" = list("0" = 0, "1" = "null"))
#####
p.retval <- alloca("int")
p.x <- alloca("int")
store(0, p.retval)
store(3, gep(ptr(c.s), 0, 0, 0))
v.0 <- load(gep(ptr(c.s), 0, 0, 0))
v.conv <- sext(v.0)
v.mul <- mul(4, v.conv)
p.call <- malloc()
p.1 <- sext(p.call)
store(p.1, gep(ptr(c.s), 0, 0, 1))
p.2 <- load(gep(ptr(c.s), 0, 0, 1))
p.arrayidx <- gep(p.2, 0)
store(2, p.arrayidx)
p.3 <- load(gep(ptr(c.s), 0, 0, 1))
p.arrayidx1 <- gep(p.3, 1)
store(5, p.arrayidx1)
p.4 <- load(gep(ptr(c.s), 0, 0, 1))
p.arrayidx2 <- gep(p.4, 2)
store(7, p.arrayidx2)
p.5 <- load(gep(ptr(c.s), 0, 0, 1))
p.arrayidx3 <- gep(p.5, 1)
v.6 <- load(p.arrayidx3)
p.7 <- load(gep(ptr(c.s), 0, 0, 1))
p.arrayidx4 <- gep(p.7, 2)
v.8 <- load(p.arrayidx4)
v.add <- add(v.6, v.8)
store(v.add, p.x)
v.9 <- load(p.x)
.ret <- ret(v.9); entry <- T
# 12

################################################################################

rm(list = setdiff(ls(), lsf.str()))
malloc <- make.heap("malloc")
free <- make.heap("free")
heap <- env()
alloca <- make.alloca()
######
# swap::swap.ll
######
c.x <- 3
c.y <- 5
######
xp <- DiscreteDistribution(3)
yp <- DiscreteDistribution(5)
######
v.0 <- load(ptr(xp))
v.1 <- load(ptr(yp))
store(v.1, ptr(xp))
store(v.0, ptr(yp))
.ret <- ret("void")


rm(list = setdiff(ls(), lsf.str()))
malloc <- make.heap("malloc")
free <- make.heap("free")
heap <- env()
alloca <- make.alloca()
######
# swap::main.ll
######
c.x <- 3
c.y <- 5
######
p.xp.addr.i <- alloca("int*")
p.yp.addr.i <- alloca("int*")
p.temp.i <- alloca("int")
p.retval <- alloca("int")
store(0, p.retval)
store(ptr(c.x), p.xp.addr.i)
store(ptr(c.y), p.yp.addr.i)
p.0 <- load(p.xp.addr.i)
v.1 <- load(p.0)
store(v.1, p.temp.i)
p.2 <- load(p.yp.addr.i)
v.3 <- load(p.2)
p.4 <- load(p.xp.addr.i)
store(v.3, p.4)
v.5 <- load(p.temp.i)
p.6 <- load(p.yp.addr.i)
store(v.5, p.6)
v.7 <- load(ptr(c.x))
.ret <- ret(v.7)
# 5

rm(list = setdiff(ls(), lsf.str()))
malloc <- make.heap("malloc")
free <- make.heap("free")
heap <- env()
alloca <- make.alloca()
######
# sort::printArray.ll (first iteration)
######
arr <- "null"
size <- 0
#####
# entry
p.arr.addr <- alloca("int*")
p.size.addr <- alloca("int")
p.i <- alloca("int")
store(ptr(arr), p.arr.addr)
store(size, p.size.addr)
store(0, p.i)
entry_for.cond <- 1.00; entry <- T

# for.cond
v.0 <- load(p.i)
v.1 <- load(p.size.addr)
v.cmp <- sub(v.0, v.1)
if (is.numeric(v.cmp)) v.cmp <- DiscreteDistribution(v.cmp)
v.cmp <- p(v.cmp)(-1)
for.cond_for.body <- round(v.cmp, 2)
for.cond_for.end <- round(1 - v.cmp, 2)
for.cond <- T; for.inc <- F; entry <- F

rm(list = setdiff(ls(), lsf.str()))
malloc <- make.heap("malloc")
free <- make.heap("free")
heap <- env()
alloca <- make.alloca()
##########
c.buf <- env("0" = list("0" = 0, "1" = 1))
##########
p.retval <- alloca("int")
p.i <- alloca("int")
p.q <- alloca("int*")
p.p <- alloca("struct*")
store(0, p.retval)
store(3, p.i)
store("null", p.q)
v.0 <- load(gep(ptr(c.buf), 0, 0, 1))

store(p.i, p.q)

store(ptr(c.buf), p.p)
p.1 <- load(p.p)
p.data <- gep(p.1, 0, 0)
p.arrayidx <- gep(p.data, 0, 1)
v.2 <- load(p.arrayidx)

p.3 <- load(p.q)
v.4 <- load(p.3)
p.5 <- load(p.p)
p.data3 <- gep(p.5, 0, 0)
p.arrayidx4 <- gep(p.data3, 0, 0)
store(v.4, p.arrayidx4)

v.6 <- load(gep(ptr(c.buf), 0, 0, 0))
.ret <- ret(v.6)


