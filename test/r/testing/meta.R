library("rlang")
options(useFancyQuotes = FALSE)

# <result> = add <ty> <var1>, <var2>gg
add <- function(var1, var2) var1 + var2
sub <- function(var1, var2) var1 - var2
mul <- function(var1, var2) var1 * var2
div <- function(var1, var2) var1 / var2
rem <- function(var1, var2) var1 %% var2

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
  if (is.numeric(cmp)) cmp <- distr::DiscreteDistribution(cmp);
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
  eval.parent(str2expression(paste0(.block$name, " <- TRUE")))
  for (pred in .block$preds) {
    eval.parent(str2expression(paste0(pred, " <- FALSE")))
  }
}

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

