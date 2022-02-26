# Title     : R functions of LLVM instructions
# Created by: enes, gokcin
# Created on: 1/21/21
library("binaryLogic")
library("rlang")
options(useFancyQuotes = FALSE)

rm(list = setdiff(ls(), lsf.str()))
sym <- env()
global <- env()
stack <- env()
heap <- env()
nv <- env()
typ <- env()
memptrs <- env("heap" = 0, "stack" = 0, "global" = 0)

false <- 0
true <- 1
null <- NULL

printbits <- function(raw) {
  R <- if (.Platform$endian == "little") rev else identity
  print(R(as.integer(intToBits(raw))))
}

# bitwise operations
# ######################################################################################################################
# shl <- function(type, op1, op2) {
#   bitCount <- as.integer(regmatches(type, regexpr("(?<=i)(\\d+)", type, perl = TRUE)))
#   if (op2 >= bitCount) {
#     return("undefined") # undefined
#   }
#   res <- bitwShiftL(op1, op2)
#   if (res >= (2^bitCount)) {
#     res <- 0
#   }
#   return(res)
# }

# shl using "binaryLogic"
shl <- function(type, op1, op2) {
  bitCount <- as.integer(regmatches(type, regexpr("(?<=i)(\\d+)", type, perl = TRUE)))

  # LLVM Semantics:  If op2 is (statically or dynamically) equal to or larger than the number of bits in op1, this instruction returns a poison value.
  if (op2 >= bitCount) {
    return("undefined") # undefined
  }
  res <- as.double(shiftLeft(as.binary(op1, n = bitCount), op2))
  if (res >= (2^bitCount)) {
    res <- 0
  }
  return(res)
}
# ######################################################################################################################
# lshr <- function(type, op1, op2) {
#   bitCount <- as.integer(regmatches(type, regexpr("(?<=i)(\\d+)", type, perl = TRUE)))
#   if (op2 >= bitCount) {
#     return("undefined") # undefined
#   }
#   res <- bitwShiftR(op1, op2)
#   res <- res %% (2^bitCount - 1)
#   return(res)
# }

# lshr using "binaryLogic"
lshr <- function(type, op1, op2) {
  bitCount <- as.integer(regmatches(type, regexpr("(?<=i)(\\d+)", type, perl = TRUE)))

  # LLVM Semantics: If op2 is (statically or dynamically) equal to or larger than the number of bits in op1, this instruction returns a poison value.
  if (op2 >= bitCount) {
    return("undefined") # undefined
  }

  res <- as.double(shiftRight(as.binary(op1, signed = TRUE, size = bitCount / 8), op2))
  return(res)
}

# ######################################################################################################################
# ashr <- function(type, op1, op2) {
#   bitCount <- as.integer(regmatches(type, regexpr("(?<=i)(\\d+)", type, perl = TRUE)))
#   if (op2 >= bitCount) {
#     return("undefined") # undefined
#   }
#   res <- op1 / (2^op2)
#   if (!as.integer(res)) {
#     res <- 0
#   }
#   return(res)
# }

# ashr using "binaryLogic"
ashr <- function(type, op1, op2) {
  bitCount <- as.integer(regmatches(type, regexpr("(?<=i)(\\d+)", type, perl = TRUE)))

  # LLVM Semantics: If op2 is (statically or dynamically) equal to or larger than the number of bits in op1, this instruction returns a poison value.
  if (op2 >= bitCount) {
    return("undefined") # undefined
  }

  # LLVM Semantics: This instruction always performs an arithmetic shift right operation, The most significant bits of the result will be filled with the sign bit of op1.
  sign <- switchEndianess(fillUpToBit(as.binary(as.binary(op1, signed = TRUE, size = bitCount / 8)[1]), n = bitCount))
  res <- op1

  for (v in seq(op2)){
    res <- as.binary(lshr(type, res, 1), signed = TRUE, size = bitCount / 8)
    res <- res | sign
  }

  res <- as.integer(res)
  return(res)
}

# ######################################################################################################################
# and <- function(op1, op2) {
#   return(bitwAnd(op1, op2))
# }

# and using "binaryLogic"
and <- function(op1, op2) {
  return(as.integer(as.binary(op1, signed = TRUE, size = 4) & as.binary(op2, signed = TRUE, size = 4))) # bit size may be needed for byte size of signed numbers
}

# ######################################################################################################################
# or <- function(op1, op2) {
#   return(bitwOr(op1, op2))
# }

# or using "binaryLogic"
or <- function(op1, op2) {
  return(as.integer(as.binary(op1, signed = TRUE, size = 4) | as.binary(op2, signed = TRUE, size = 4))) # bit size may be needed for byte size of signed numbers
}

# ######################################################################################################################
# xor <- function(op1, op2) {
#   return(bitwXor(op1, op2))
# }

xor <- function(op1, op2) {
  return(as.integer(base::xor(as.binary(op1, signed = TRUE, size = 4) ,as.binary(op2, signed = TRUE, size = 4)))) # bit size may be needed for byte size of signed numbers
}

# convertion operations
# trunc
trunc <- function(from, value, to) {
  toBitCount <- as.integer(regmatches(to, regexpr("(?<=i)(\\d+)", to, perl = TRUE)))
  #return(as.integer(as.raw(as.integer(intToBits(value)))[1:toBitCount]))
  return(as.integer(binaryLogic::as.binary(value) & binaryLogic::as.binary((2^toBitCount) - 1)))
}

# zext
zext <- function(from, value, to) value

# fpext
fpext <- function(from, value, to) value

bitstoint <- function(bits) { # bit list to int
  sum <- 0
  for (i in seq_along(bits)) {
    sum <- sum + (2^(i - 1) * bits[i])
  }
  return(sum)
}

# sext
sext <- function(from, value, to) {
  # LLVM sext semantics: When sign extending from i1, the extension always results in -1 or 0.
  if (from == "i1") {
    if (value == 1) return(-1)
    return(0)
  }

  toBitCount <- as.integer(regmatches(to, regexpr("(?<=i)(\\d+)", to, perl = TRUE)))
  fromBitCount <- as.integer(regmatches(from, regexpr("(?<=i)(\\d+)", from, perl = TRUE)))

  if (is(value, "Distribution")) { # generate a random number
    warning(paste("non-deterministic choice"))
    value <- q(value)(1)
  }

  sign <- as.integer(intToBits(value))[fromBitCount]
  a <- list(rep(sign, toBitCount - fromBitCount))[[1]]
  b <- as.integer(intToBits(value))[1:fromBitCount]
  bits <- append(b, a)
  return(bitstoint(bits))
}

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

isVector <- function(t) {
  return(grepl("^<[1-9]+ x (i[1-9]{1,2}|double[*]{0,1}|float[*]{0,1}|i[1-9]{1,2}\\*)>[*]{0,1}$", t))
}

getVectorSize <- function(v) {
  return(gsub(pattern = "<([1-9]+) x (i[1-9]{1,2}|double[*]{0,1}|float[*]{0,1}|i[1-9]{1,2}\\*)>.*", "\\1", v))
}

getVectorType <- function(v) {
  return(gsub(pattern = "<[1-9]+ x (i[1-9]{1,2}|double[*]{0,1}|float[*]{0,1}|i[1-9]{1,2}\\*)>.*", "\\1", v))
}

bitcast <- function(from, value, to) {
  isv_from <- isVector(from)
  isv_to <- isVector(to)
  # if from or to type is a vector
  if (isv_from || isv_to) {

    # if "from" type is a vector
    if (isv_from) {
      from_size <- getVectorSize(from)
      from_type <- getVectorType(from)
      from <- from_type
    }
    fromBitCount <- as.integer(regmatches(to, regexpr("(?<=i)(\\d+)", from, perl = TRUE)))
    # if "to" type is a vector
    if (isv_to) {
      to_size <- getVectorSize(to)
      to_type <- getVectorType(to)
      to <- to_type
    }
    toBitCount <- as.integer(regmatches(to, regexpr("(?<=i)(\\d+)", to, perl = TRUE)))

    if (toBitCount > fromBitCount && isv_from) {
      parsedAddrList <- regmatches(value, gregexpr("(\\w+)", value))
      region <- parsedAddrList[[1]][[1]]
      addr <- as.integer(parsedAddrList[[1]][[2]])
      # create a new binary which size equal to "to type bit count"
      retValue <- as.binary(-1, size = toBitCount / 8) # size = byte
      for (i in 0:from_size-1) {
        vector_element<-eval.parent(parse(text=paste0(region,"$",addr+i)))
        retValue[(i*fromBitCount)+1:fromBitCount*(i+1)] <- as.binary(vector_element)
      }
      return(as.integer(retvalue))
    }
  }
  return(value)
}

extractelement <- function(type, addr, index) {
  if (!isVector(type)) {
    warning("extractelement called for non vector type!!")
  }
  parsedAddrList <- regmatches(addr, gregexpr("(\\w+)", addr))
  region <- parsedAddrList[[1]][[1]]
  return(eval.parent(parse(text = paste0(region, "$", dQuote(index)))))
}

insertelement <- function(type, addr, element, index) {
  if (!isVector(type)) {
    warning("insertelement called for non vector type!!")
  }
  parsedAddrList <- regmatches(addr, gregexpr("(\\w+)", addr))
  region <- parsedAddrList[[1]][[1]]
  eval.parent(parse(text = paste0(region, "$", dQuote(index), "<-", element)))
  return(addr) # return vector itself
}

fptoui <- function(from, value, to) {
  toBitCount <- as.integer(regmatches(to, regexpr("(?<=i)(\\d+)", to, perl = TRUE)))
  if (value > (2^toBitCount)) return("undefined") # return poison value

  value <- as.numeric(value)
  signs <- sign(value)
  value[signs < 0] <- value[signs < 0] + 2^toBitCount

  return(ceiling(value))
}

fptosi <- function(from, value, to) {
  toBitCount <- as.integer(regmatches(to, regexpr("(?<=i)(\\d+)", to, perl = TRUE)))

  lowerLimit <- (-2^(toBitCount - 1))
  upperLimit <- (2^(toBitCount - 1)) - 1

  if (value > upperLimit || value < lowerLimit) return("undefined")
  return(as.integer(value))
}

uitofp <- function(from, value, to) {
  if (value < 0) {
    fromBitCount <- as.integer(regmatches(from, regexpr("(?<=i)(\\d+)", from, perl = TRUE)))
    value <- value + (2^fromBitCount)
  }
  return(as.double(value))
}

sitofp <- function(from, value, to) {
  return(as.double(value))
}

sitofp <- function(from, value, to) {
  return(as.double(value))
}

resolveType <- function(type) {

  if (length(grep("\\*$", type, perl = TRUE))) return("1") # if type is a pointer, return size of a one mem loc
  if (isVector(type)) {
    return(getVectorSize(type))
  }
  while (length(grep("(%struct\\..*)|\\[\\d+ x (%struct\\..*)\\]", type, perl = TRUE))) { # the case where there is no `struct`
    structname <- regmatches(type, regexpr("(%struct\\.[a-zA-Z0-9_%-]+)", type, perl = TRUE))
    type <- gsub(structname, paste0("[", typ[[structname]], "]"), type)
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
  # if(isVector(type)){
  #   parsedAddrList <- regmatches(val, gregexpr("(\\w+)", val))
  #   src_region <- parsedAddrList[[1]][[1]]
  #   src_addr <- as.integer(parsedAddrList[[1]][[2]])
  #
  #   size<-as.integer(getVectorSize(type))
  #   # store all vector elements to destination
  #   for(i in 0:(size-1)){
  #     element<-eval.parent(parse(text=paste0(src_region,"$",dQuote(src_addr+i))))
  #     insertelement(type,ptr,element,i)
  #   }
  # }
  eval.parent(str2expression(paste0(eval.parent(str2expression(deparse(substitute(ptr)))), "<-", deparse(substitute(val)))))
}

load <- function(ptr) {
  return(eval.parent(str2expression(ptr)))
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

memory <- function(...) alloca(null, ...)




