Rcpp::sourceCpp("R/llvm-meta-packaging/llvm/src/meta.cpp")
options(useFancyQuotes = FALSE)

rm(list = setdiff(ls(), lsf.str()))
sym <- rlang::env()
global <- rlang::env()
stack <- rlang::env()
heap <- rlang::env()
nv <- rlang::env()
typ <- rlang::env()
memptrs <- rlang::env("heap" = 0, "stack" = 0, "global" = 0)

false <- 0
true <- 1
null <- NULL

# zext
zext <- function(from, value, to) value

# fpext
fpext <- function(from, value, to) value

# sext

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

# always returns pointer
bitcast <- function(from, value, to) value

resolveType <- function(type) {
  if (length(grep("\\*$", type, perl = TRUE))) return("1") # if type is a pointer, return size of a one mem loc

  while (length(grep("(%struct\\..*)|\\[\\d+ x (%struct\\..*)\\]", type, perl = TRUE))) { # the case where there is no `struct`
    structname <- regmatches(type, regexpr("(%struct\\.[a-zA-Z0-9_%-]+)", type, perl = TRUE))
    type <- gsub(structname, paste0("[", typ[[structname]], "]"), type)
  }
  while (length(grep("(%union\\..*)|\\[\\d+ x (%union\\..*)\\]", type, perl = TRUE))) { # the case where there is no `union`
    unionname <- regmatches(type, regexpr("(%union\\.[a-zA-Z0-9_%-]+)", type, perl = TRUE))
    type <- gsub(unionname, paste0("[", typ[[unionname]], "]"), type)
  }
  return(type)
}

calcSize <- function(typestr) {
  typestr <- gsub("i(\\d+)|double|float", "1", typestr)
  typestr <- gsub("x", '\\*', typestr)
  typestr <- gsub(",", '\\+', typestr)
  typestr <- gsub("\\[", '\\(', typestr)
  typestr <- gsub("\\]", '\\)', typestr)
  typestr <- gsub("\\w+\\*", "1", typestr)
  return(eval(str2expression(typestr)))
}

alloca <- function(type, ...) {
  values <- list(...)
  ptrLocToReturn <- memptrs$"stack" # remember first mem loc

  if (!length(values)) # if values are not pre-defined
    values <- rep(0, calcSize(resolveType(type))) # create a list with size of type and init value of 0

  for (i in values) { # insert values into the memory slots
    stack[[toString(memptrs$"stack")]] <- eval.parent(i)
    memptrs$"stack" <- memptrs$"stack" + 1
  }
  return(paste0("stack$", dQuote(toString(ptrLocToReturn))))
}

gep <- function(type, addr, ...) {
  # extract addr to be incremented and memory region
  parsedAddrList <- regmatches(addr, gregexpr("(\\w+)", addr))
  region <- parsedAddrList[[1]][[1]]
  addr <- as.integer(parsedAddrList[[1]][[2]])
  # evaluate index if its a variable
  indices <- list(...)
  typeSize <- 0
  for (i in seq_along(indices)) {
    indices[[i]] <- as.integer(eval.parent(str2expression(deparse(substitute(indices[[i]])))))
  }
  addr <- indices[[1]] + addr

  if (length(indices) > 1) {

    for (i in 2:length(indices)) {
      if (length(grep("(\\[.*\\])", type)) && substr(type, nchar(type), nchar(type)) != "*") {
        replaceStr <- paste("(", indices[[i]], ") x ")
        calcStr <- type
        if (length(grep("(%struct\\..*)", type))) {
          calcStr <- base::sub("(%struct\\..*)", paste0(calcSize(resolveType(regmatches(type, regexpr("%struct\\..+(?<![\\]\\)*])", type, perl = TRUE)))), "]"), type)
        }
        calcStr <- base::sub("(\\d+) x ", replaceStr, calcStr)
        typeSize <- calcSize(calcStr) + typeSize
        type <- base::sub("\\d+ x ", "", type)
        type <- substr(type, 2, nchar(type) - 1)
      }
      else if (length(grep("(%struct\\..*)", type)) && substr(type, nchar(type), nchar(type)) != "*") {
        type <- typ[[type]]
        s <- trimws(strsplit(type, ",")[[1]])
        index <- 0
        while (index < indices[[i]]) {
          typeSize <- typeSize + calcSize(resolveType(s[[index + 1]]))
          index <- index + 1
        }
        type <- s[[indices[[i]] + 1 ]]
      }else if (length(grep("(\\{.*\\})", type))) {
        typeSize <- typeSize + indices[[i]]
      }
      else {
        typeSize <- calcSize(type) + typeSize
      }
    }

  }

  addr <- addr + typeSize
  return(paste0(region, "$", dQuote(addr)))
}

store <- function(val, ptr) {
  eval.parent(str2expression(paste0(eval.parent(str2expression(deparse(substitute(ptr)))), "<-", deparse(substitute(val)))))
}

load <- function(ptr) {
  return(eval.parent(str2expression(ptr)))
}

memcmp <- function(ptr1, ptr2, n) {
  ptr1ParsedAddrList <- regmatches(ptr1, gregexpr("(\\w+)", ptr1))
  ptr1Region <- ptr1ParsedAddrList[[1]][[1]]
  ptr1Addr <- as.integer(ptr1ParsedAddrList[[1]][[2]])
  ptr2ParsedAddrList <- regmatches(ptr2, gregexpr("(\\w+)", ptr2))
  ptr2Region <- ptr2ParsedAddrList[[1]][[1]]
  ptr2Addr <- as.integer(ptr2ParsedAddrList[[1]][[2]])
  for (i in 0:(n - 1)) {
    p1 <- ptr1Addr + i
    p2 <- ptr2Addr + i
    x <- eval.parent(str2expression(paste0(ptr1Region, "$", dQuote(toString(p1)))))
    y <- eval.parent(str2expression(paste0(ptr2Region, "$", dQuote(toString(p2)))))
    if (x > y || is.null(y)) return(1)
    if (x < y || is.null(x)) return(-1)
  }
  return(0)
}

memcpy <- function(destPtr, srcPtr, type) {
  size <- calcSize(resolveType(type))
  destParsedAddrList <- regmatches(destPtr, gregexpr("(\\w+)", destPtr))
  destRegion <- destParsedAddrList[[1]][[1]]
  destAddr <- destParsedAddrList[[1]][[2]]
  srcParsedAddrList <- regmatches(srcPtr, gregexpr("(\\w+)", srcPtr))
  srcRegion <- srcParsedAddrList[[1]][[1]]
  srcAddr <- srcParsedAddrList[[1]][[2]]

  for (i in 0:(size - 1)) {
    d <- as.integer(destAddr) + i
    s <- as.integer(srcAddr) + i
    eval.parent(str2expression(paste0(destRegion, "$", dQuote(toString(d)), " <- ", eval(str2expression(paste0(srcRegion, "$", dQuote(toString(s))))))))
  }
}

malloc <- function(size) {
  ptrLocToReturn <- memptrs$"heap" # remember ptr location
  memptrs$"heap" <- memptrs$"heap" + size # increment the heap pointer with the size

  return(paste0("heap$", dQuote(ptrLocToReturn)))
}

free <- function(ptr) { }

galloc <- function(type, ...) {
  values <- list(...) # create a list of values from ellipsis
  ptrLocToReturn <- memptrs$"global" # remember ptr location

  for (i in values) {
    global[[toString(memptrs$"global")]] <- eval.parent(i) # insert values into global mem locs

    memptrs$"global" <- memptrs$"global" + 1 # increment the pointer
  }

  return(paste0("global$", dQuote(toString(ptrLocToReturn))))
}


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
      distribute <- function(x)x + prob
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
  if (is.numeric(cmp))cmp <- distr::DiscreteDistribution(cmp);
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
      if (length(grep("sym\\$\\\".*?\\\"", c_name))) { # sym$\"2\".true => sym$\"2.true\"
        varT <- gsub("(sym\\$\\\")(.*?)(\\\")", "\\1\\2.true\\3", c_name)
        varF <- gsub("(sym\\$\\\")(.*?)(\\\")", "\\1\\2.true\\3", c_name)
        eval.parent(str2expression(paste0(varT, " <- ", c_name, "[[2]]")))
        eval.parent(str2expression(paste0(varF, " <- ", c_name, "[[3]]")))
      } else {
        eval.parent(str2expression(paste0(c_name, ".true <- ", c_name, "[[2]]")))
        eval.parent(str2expression(paste0(c_name, ".false <- ", c_name, "[[3]]")))
      }
    }
  }
  eval.parent(str2expression(paste0(.block$name, " <- TRUE")))
  for (pred in .block$preds) {
    eval.parent(str2expression(paste0(pred, " <- FALSE")))
  }
}

memory <- function(...) alloca(null, ...)

