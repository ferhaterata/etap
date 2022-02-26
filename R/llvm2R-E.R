{ # # Title     : llvm2R-E.R
  # # Objective : To test cases and seek for alternate solutions
  # # Created by: enes
  # # Created on: 12/25/20
  #
  # rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
  # ##### R functions in meta.R with examples #####
  # ### list
  # # arguments can be value or tag=value
  # l <- list(`a` = 10, `1` = 4, `x` = "1")
  # ## accessing elements
  # # elements can be accessed using listname[tag/index] or listname$tag
  # l[1] # using index -> output: 10
  # l[3] # using index -> output: "1"
  # l$`1` # using tag -> output: 4
  # l["x"] # using tag -> output: "1"
  # l[l$x] # output: "4"
  # l[eval(str2expression(l$x))] # output: 10
  # # [[]] and [] are both valid extracing operators
  # # $ can be used only if the list is named
  # names(l) # get names in a named object -> output: "a" "1" "x"
  #
  # ### env
  # # always creates a child of the current environment
  # e <- env()
  # # assigning elements into env
  # e$a <- "hello"
  # e$b <- 3
  # # binding environments
  # n <- e
  # n$a <- "hi" # both value of 'a' in enviroment e and n are changed
  # n <- env_clone(e) # can be used for hard copy
  # n$a <- "hello" # e will be unchanged
  # # environments can be created using a list
  # z <- as.environment(l)
  #
  # ### eval
  # # evaluates an unevaluated expression
  # uexpr <- str2expression("123 + 95")
  # print(uexpr)
  # print(eval(uexpr))
  #
  # ### substitute
  # # can change values in an expression
  # e <- env()
  # e$a <- 2
  # e$s <- substitute(a + b)
  # print(eval(s))
  #
  # # get symbol as string
  # a <- deparse(substitute(a + b, env = e))
  #
  # ### deparse
  # # turn unevaluated expr into string
  # str <- deparse(uexpr)
  #
  # ### parse
  # # turn strings into unevaluated expr
  # sum <- "321 + 453"
  # uexpr <- parse(text = sum)
  # # a more convenient way
  # uexpr <- str2expression("1337 %% 808")
  # print(eval(uexpr))
  #
  # ### s/dQuote
  # # put quotes around strings
  # print(sQuote(a))
  # print(dQuote(a))
  #
  # ##### end #####
  #
  # ##### Instructions #####
  # options(useFancyQuotes = FALSE)
  #
  # ret <- function(value) print(value)
  # bitcast <- function(pointer) pointer
  # sext <- function(value) value
  #
  # alloca <- function(type, name) {
  #   # alloca instruction allocates memory and always returning a pointer to allocated space
  #   # this function creates a variable (allocates memory) and a pointer (returns pointer)
  #   if (type == "ptr") {
  #     eval.parent(str2expression(paste0("p.", name, " <- 0")))
  #     eval.parent(str2expression(paste0("p.p.", name, " <- \"p.", name, "\""))) # pointer to the pointer
  #   }
  #
  #   if (type == "int") {
  #     eval.parent(str2expression(paste0("v.", name, " <- 0")))
  #     eval.parent(str2expression(paste0("p.", name, " <- \"v.", name, "\""))) # pointer to the value
  #   }
  #
  #   if (type == "struct" || type == "array") {
  #     eval.parent(str2expression(paste0("v.", name, " <- env()")))
  #     eval.parent(str2expression(paste0("p.", name, " <- \"v.", name, "\""))) # pointer to the environment
  #   }
  # }
  #
  # store <- function(val, ptr) {
  #   eval.parent(str2expression(paste(ptr, "<-", deparse(substitute(val), width.cutoff = 500)))) # deparse parses max 500 chars(?)
  # }
  #
  # load <- function(ptr) {
  #   eval(str2expression(ptr))
  # }
  #
  # gep <- function(ptr, index) {
  #   paste0(ptr, "$", dQuote(index))
  # }
  #
  # memcpy <- function(destPtr, srcPtr) {
  #   eval.parent(str2expression(paste(destPtr, "<- env_clone(", srcPtr, ")"))) # clones the environment
  # }
  #
  # make.alloca <- function() {
  #   location <- -1
  #
  #   f <- function(type) {
  #     location <<- location + 1
  #
  #     if (type == "int" || type == "float")
  #       eval.parent(str2expression(paste0("\"", location, "\" <- 0")))
  #     else if (type == "int*" || type == "float*")
  #       eval.parent(str2expression(paste0("\"", location, "\" <- \"null\"")))
  #     else if (type == "struct" || type == "array")
  #       eval.parent(str2expression(paste0("\"", location, "\" <- env()")))
  #     else if (type == "struct*" || type == "array*")
  #       eval.parent(str2expression(paste0("\"", location, "\" <- \"null\"")))
  #     else if (substr(type, 0, 6) == "malloc") {
  #       size <- eval(str2expression(substr(type, 7, nchar(type))))
  #       eval.parent(str2expression(paste0("\"", location, "\" <- malloc(", size, ")")))
  #     }
  #     return(paste0("`", location, "`"))
  #   }
  #
  #   return(f)
  # }
  #
  # malloc <- function(size) {
  #   e <- env()
  #   for (i in 0:(size - 1)) {
  #     eval(str2expression(paste0("e$`", i, "` <- 0")))
  #   }
  #   return(e)
  # }
  #
  # free <- function(ptr) {
  #   eval.parent(str2expression(paste0(eval.parent(str2expression(deparse(substitute(ptr)))), " <- env()")))
  #   #eval.parent(str2expression(paste0("rm(", ptr, ")")))
  # }
  #
  # ptr <- function(element)
  #   eval(deparse(substitute(element)))
  #
  # rm(list = setdiff(ls(), lsf.str()))
  # # TODO: MALLOC AND FREE
  # ##### Example: malloc1.ll #####
  # #
  # alloca <- make.alloca()
  # #
  # p.foo <- alloca("struct*")
  # p.call <- alloca("malloc(4)")
  # p.0 <- bitcast(p.foo)
  # store(p.0, ptr(p.foo))
  # p.1 <- load(ptr(p.foo))
  # p.A <- gep(p.1, 0)
  # store(12, p.A)
  # p.2 <- load(ptr(p.foo))
  # p.3 <- bitcast(p.2)
  # free(p.3)
  # p.4 <- alloca("int")
  # ret("void")
  # #"void"
  #
  # rm(list = setdiff(ls(), lsf.str()))
  # ##### Example: malloc2.ll #####
  # #
  # alloca <- make.alloca()
  # #
  # p.1 <- alloca("int*")
  # p.2 <- alloca("malloc(5)")
  # p.3 <- bitcast(p.2)
  # store(p.3, ptr(p.1))
  # p.4 <- load(ptr(p.1))
  # store(12, p.4)
  # p.5 <- load(ptr(p.1))
  # p.6 <- gep(p.5, 1)
  # store(24, p.6)
  # p.7 <- load(ptr(p.1))
  # p.8 <- bitcast(p.7)
  # free(p.8)
  # ret("void")
  # #void
  #
  # ' examples
  # alloca("struct", "foo")
  # store(p.foo, env("0" = 1,"1" = 2))
  # v.bar <- load(p.foo)
  # p.b <- gep(p.foo, 1)
  # v.baz <- load(p.foo)
  # v.quud <- load(p.b)
  # alloca("struct", "x")
  # store(p.x, env("0" = 100, "1" = 43))
  # memcpy(p.foo, p.x)'
  #
  # rm(list = setdiff(ls(), lsf.str()))
  # ######
  # # local4.ll - Converted using the functions above.
  # ######
  # ### Allocate global variables
  # alloca("struct", "c.__const.main.foo")
  # store(env("0" = 0, "1" = 1), p.c.__const.main.foo)
  # ######
  # alloca("int", "retval")
  # alloca("struct", "foo")
  # alloca("ptr", "bar")
  # store(0, p.retval)
  # p.0 <- bitcast(p.foo)
  # memcpy(p.0, p.c.__const.main.foo)
  # p.a <- gep(p.foo, 0)
  # store(2, p.a)
  # store(p.foo, p.p.bar)
  # p.1 <- load(p.p.bar) # type check must be done, this loads into a pointer
  # p.b <- gep(p.1, 1)
  # v.2 <- load(p.b) # this loads into an integer
  # ret(v.2)
  # # 1
  #
  # ##### Other Examples #####
  # rm(list = setdiff(ls(), lsf.str()))
  # ######
  # # array3.ll
  # ######
  # alloca("array", "c.nums")
  # alloca("int", "c.i")
  # store(env("0" = list("0" = 1, "1" = 2, "2" = 3),
  #           "1" = list("0" = 2, "1" = 3, "2" = 4),
  #           "2" = list("0" = 3, "1" = 4, "2" = 5)), p.c.nums)
  # store(2, p.c.i)
  # ######
  # v.0 <- load(p.c.i)
  # p.arrayidx <- gep(p.c.nums, v.0)
  # v.1 <- load(p.c.i)
  # p.arrayidx1 <- gep(p.arrayidx, v.1)
  # v.2 <- load(p.arrayidx1)
  # ret(v.2)
  # # 5
  #
  # rm(list = setdiff(ls(), lsf.str()))
  # ######
  # # struct2.ll
  # ######
  # alloca("struct", "c.foo")
  # store(env("0" = list("0" = 0, "1" = 1, "2" = 0),
  #           "1" = list("0" = 2, "1" = 3, "2" = 0),
  #           "2" = list("0" = 4, "1" = 5, "2" = 0)), p.c.foo)
  # ######
  # alloca("int", "f.i") # function parameter
  # store(2, p.f.i) # assume its value is 2
  # alloca("int", "i.addr")
  # store(v.f.i, p.i.addr)
  # v.0 <- load(p.i.addr)
  # v.idxprom <- sext(v.0)
  # p.arrayidx <- gep(p.c.foo, v.idxprom)
  # p.b <- gep(p.arrayidx, 1)
  # v.1 <- load(p.b)
  # ret(v.1)
  # # 5
  #
  # rm(list = setdiff(ls(), lsf.str()))
  # ######
  # # pointer6.ll
  # #####
  # #####
  # alloca("int", "value")
  # alloca("ptr", "ptr")
  # store(5, p.value)
  # store(p.value, p.p.ptr)
  # p.0 <- load(p.p.ptr)
  # p.add.ptr <- gep(p.0, 1)
  # store(p.add.ptr, p.p.ptr)
  # p.1 <- load(p.p.ptr)
  # v.2 <- load(p.1)
  # ret(v.2)
}

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
# @buf*      "0"::"1"        # implicit pointer of a global variable (????)
# struct S   "1"::"2"        # @buf = global %struct.S { [2 x i32] [i32 0, i32 1] }
# int[2]     "2"::"3"        # [2 x i32]
# int        "3"::4          # i32 0
# int        "4"::5          # i32 1
# ?          "5"::?
#
# Stack                      # local storage
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


#struct X = type [2 x [3 x [2 x i32]]] X[0][1][1][0]
# "-1"::"0" # struct X
# "0"::"1" # struct A
# "1"::"2" # struct B1
# "3"::0
# "4"::0
# "5"::"6" # struct C2
# "6"::0
# "7"::0
# "8"::"9" # struct C3
# "10"::0
# "11"::0
# "12"::"13" # struct B2
# "13"::"14" # struct C1
# "14"::0
# "15"::0
# "16"::"17" # struct C2
# "18"::0
# "19"::0
# "20"::"21" # struct C3
# "21"::0
# "22"::0

# New Memory Model: functions
################################################################################
rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
library("rlang")
options(useFancyQuotes = FALSE)

printbits <- function(raw) {
  R <- if (.Platform$endian == "little") rev else identity
  print(R(as.integer(intToBits(raw))))
}

# bitwise operations
shl <- function(type, op1, op2) {
  bitCount <- as.integer(regmatches(type, regexpr("(?<=i)(\\d+)", type, perl = TRUE)))
  if (op2 >= bitCount) {
    return("undefined") # undefined
  }
  res <- bitwShiftL(op1, op2)
  if (res >= (2^bitCount)) {
    res <- 0
  }
  return(res)
}

# shl examples
shl("i32", 4, 2) # 16
shl("i4", 8, 1)  # 0
shl("i32", 1, 10) # 1024
shl("i32", 1, 32) # NULL


lshr <- function(type, op1, op2) {
  bitCount <- as.integer(regmatches(type, regexpr("(?<=i)(\\d+)", type, perl = TRUE)))
  if (op2 >= bitCount) {
    return("undefined") # undefined
  }
  res <- bitwShiftR(op1, op2)
  res <- res %% (2^bitCount - 1)
  return(res)
}

# lshr examples
lshr("i32", 4, 1) # 2
lshr("i32", 4, 2) # 1
lshr("i8", 4, 3) # 0
lshr("i8", -2, 1) # 127 | 0x7F
lshr("i32", 1, 32) # NULL

ashr <- function(type, op1, op2) {
  bitCount <- as.integer(regmatches(type, regexpr("(?<=i)(\\d+)", type, perl = TRUE)))
  if (op2 >= bitCount) {
    return("undefined") # undefined
  }
  res <- op1 / (2^op2)
  if (!as.integer(res)) {
    res <- 0
  }
  return(res)
}

# ashr examples
ashr("i32", 4, 1) # 2
ashr("i32", 4, 2) # 1
ashr("i8", 4, 3) # 0
ashr("i8", -2, 1) # -1
ashr("i32", 1, 32) # NULL

# bitwise and
and <- function(op1, op2) {
  return(bitwAnd(op1, op2))
}

# and examples
and(15, 40) # 8
and(4, 8) # 0

# bitwise or
or <- function(op1, op2) {
  return(bitwOr(op1, op2))
}

# or examples
or(15, 40) # 47
or(4, 8) # 12

# bitwise xor
xor <- function(op1, op2) {
  return(bitwXor(op1, op2))
}

# xor examples
xor(15, 40) # 39
xor(4, 8) # 12

# convertion operations
# trunc
trunc <- function(from, value, to) {
  toBitCount <- as.integer(regmatches(to, regexpr("(?<=i)(\\d+)", to, perl = TRUE)))
  #return(as.integer(as.raw(as.integer(intToBits(value)))[1:toBitCount]))
  return(as.integer(packBits(intToBits(value) & intToBits((2^toBitCount) - 1), type = "integer")))
}

# trunc examples
trunc(257, "i8") # 1
trunc(123, "i1") # 1
trunc(122, "i1") # 0

# zext
zext <- function(from, value, to) value

# sext
sext <- function(from, value, to) {
  toBitCount <- as.integer(regmatches(to, regexpr("(?<=i)(\\d+)", to, perl = TRUE)))
  fromBitCount <- as.integer(regmatches(from, regexpr("(?<=i)(\\d+)", from, perl = TRUE)))
  sign <- as.integer(intToBits(value))[fromBitCount]
  a <- list(rep(sign, toBitCount - fromBitCount))[[1]]
  b <- as.integer(intToBits(value))[1:fromBitCount]
  bits <- append(b, a)
  return(bitstoint(bits))
}

sext("i8", -1, "i16") # 65535
sext("i1", TRUE, "i64") # 2147483648 == -1
sext("i1", FALSE, "i32") # 0

bitstoint <- function(bits) { # bit list to int
  sum <- 0
  for (i in seq_along(bits)) {
    sum <- sum + (2^(i - 1) * bits[i])
  }
  return(sum)
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

# always returns pointer
# <result> = bitcast <ty> <value> to <ty2>             ; yields ty2
bitcast <- function(from, value, to) value

# <result> = fptoui <ty> <value> to <ty2>             ; yields ty2
fptoui <- function(from, value, to) {
  toBitCount <- as.integer(regmatches(to, regexpr("(?<=i)(\\d+)", to, perl = TRUE)))
  if (value > (2^toBitCount)) return("undefined") # return poison value

  value <- as.numeric(value)
  signs <- sign(value)
  value[signs < 0] <- value[signs < 0] + 2^toBitCount

  return(ceiling(value))
}

# <result> = fptosi <ty> <value> to <ty2>             ; yields ty2
fptosi <- function(from, value, to) {
  toBitCount <- as.integer(regmatches(to, regexpr("(?<=i)(\\d+)", to, perl = TRUE)))

  lowerLimit <- (-2^(toBitCount - 1))
  upperLimit <- (2^(toBitCount - 1)) - 1

  if (value > upperLimit || value < lowerLimit) return("undefined")
  return(as.integer(value))
}

# <result> = uitofp <ty> <value> to <ty2>             ; yields ty2
uitofp <- function(from, value, to) {
  if(value < 0){
    fromBitCount <- as.integer(regmatches(from, regexpr("(?<=i)(\\d+)", from, perl = TRUE)))
    value <- value + (2^fromBitCount)
  }
  return(as.double(value))
}

# <result> = sitofp <ty> <value> to <ty2>             ; yields ty2
sitofp <- function(from, value, to) {
  return(as.double(value))
}

resolveType <- function(type) {
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

make.alloca <- function() {
  location <- 0

  f <- function(type) {
    firstptr <- location
    if (length(grep("(\\[.*\\])", type)) && substr(type, nchar(type), nchar(type)) != "*") {
      if (length(grep("(%struct\\..*)", type))) {
        type <- base::sub("(%struct\\..*)", paste0(calcSize(resolveType(regmatches(type, regexpr("%struct\\..+(?<![\\]\\)*])", type, perl = TRUE)))), "]"), type)
      }
      size <- calcSize(type) # array type
    }
    else if (length(grep("(%struct\\..*)", type)) && substr(type, nchar(type), nchar(type)) != "*") {
      size <- calcSize(resolveType(type)) # resolve struct type
    }else {
      size <- 1 # atomic type
    }

    for (i in (0:(size - 1))) {
      eval.parent(str2expression(paste0("stack$", dQuote(location), "<-0")))
      location <<- location + 1
    }
    return(paste0("stack$", dQuote(firstptr)))
  }

  return(f)
}

gep <- function(type, addr, ...) {
  t <- type
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
      if (length(grep("(\\[.*\\])", t)) && substr(t, nchar(t), nchar(t)) != "*") {
        replaceStr <- paste("(", indices[[i]], ") x ")
        calcStr <- t
        if (length(grep("(%struct\\..*)", t))) {
          calcStr <- base::sub("(%struct\\..*)", paste0(calcSize(resolveType(regmatches(t, regexpr("%struct\\..+(?<![\\]\\)*])", t, perl = TRUE)))), "]"), t)
        }
        calcStr <- base::sub("(\\d+) x ", replaceStr, calcStr)
        typeSize <- calcSize(calcStr) + typeSize
        t <- base::sub("\\d+ x ", "", t)
        t <- substr(t, 2, nchar(t) - 1)
      }
      else if (length(grep("(%struct\\..*)", t)) && substr(t, nchar(t), nchar(t)) != "*") {
        t <- typ[[t]]
        s <- trimws(strsplit(t, ",")[[1]])
        index <- 0
        while (index < indices[[i]]) {
          typeSize <- typeSize + calcSize(resolveType(s[[index + 1]]))
          index <- index + 1
        }
        t <- s[[indices[[i]] + 1 ]]
      }  else {
        typeSize <- calcSize(t) + typeSize
      }
    }
  }

  addr <- addr + typeSize
  return(paste0(region, "$", dQuote(addr)))
}

store <- function(val, ptr) {
  eval(str2expression(paste0(eval(str2expression(deparse(substitute(ptr)))), "<-", deparse(substitute(val)))))
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

  # destAddr <- eval(str2expression(deparse(substitute(destPtr))))
  # srcAddr <- eval(str2expression(deparse(substitute(srcPtr))))
  #cat(destAddr, srcAddr)

  for (i in 0:(size - 1)) {
    d <- as.integer(destAddr) + i
    s <- as.integer(srcAddr) + i
    eval.parent(str2expression(paste0(destRegion, "$", dQuote(toString(d)), " <- ", eval(str2expression(paste0(srcRegion, "$", dQuote(toString(s))))))))
  }
}

make.malloc <- function() {
  location <- -1

  f <- function(size) {
    firstptr <- location + 1
    location <<- location + size


    return(paste0("heap$", dQuote(firstptr)))
  }

  return(f)
}

free <- function(ptr) { }

# New Memory Model: alloca & gep tests
rm(list = setdiff(ls(), lsf.str()))
options(useFancyQuotes = FALSE)
sym <- env()
global <- env()
stack <- env()
heap <- env()
nv <- env()
typ <- env()
alloca <- make.alloca()
malloc <- make.malloc()
typ$"%struct.ST" <- "%struct.RT, i32, %struct.RT"
typ$"%struct.RT" <- "i32, [3 x [2 x i32]], %struct.CT"
typ$"%struct.CT" <- "i64, [3 x [2 x i64]]"

# alloca tests
sym$"rt1" <- alloca("%struct.RT") # Struct RT rt;
sym$"rt2" <- alloca("%struct.RT") # Struct RT rt;
sym$"arr1" <- alloca("[2 x [3 x [4 x i32]]]")
sym$"i" <- alloca("i32")
sym$"p" <- alloca("%struct.RT*")
sym$"a2" <- alloca("[2 x [3 x i32]]")
sym$"x" <- alloca("i32")

a2 <- gep("[2 x [3 x i32]]", sym$a2, 0)
a2 <- gep("[2 x [3 x i32]]", sym$a2, 0, 1)
a2 <- gep("[2 x [3 x i32]]", sym$a2, 0, 1, 2)

sym$"st1" <- alloca("%struct.ST")
structtest <- gep("%struct.ST", sym$st1, 0, 1)
structtest <- gep("%struct.ST", sym$st1, 0, 2, 2)
structtest <- gep("%struct.ST", sym$st1, 0, 2, 2, 1, 2, 1)


structtest <- gep("%struct.RT", sym$rt1, 0)
structtest <- gep("%struct.RT", sym$rt1, 0, 1)
structtest <- gep("%struct.RT", sym$rt1, 0, 2)
structtest <- gep("%struct.RT", sym$rt1, 0, 2, 1, 2, 1)

# load and store tests
store(6, sym$i)
store(sym$i, sym$x)
sym$x <- load(sym$i)

# memcpy tests
sym$"gArr" <- alloca("[5 x i32]")
sym$"lArr" <- alloca("[5 x i32]")

store(26, gep("[5 x i32]", sym$"gArr", 0, 0))
store(34, gep("[5 x i32]", sym$"gArr", 0, 4))

memcpy(sym$lArr, sym$gArr, "[5 x i32]")

# malloc tests
malloc <- make.malloc()
heap <- env()
sym$a <- malloc(20)
store(3, gep("i32", sym$a, 2))
sym$b <- malloc(3)
store(6, gep("i32", sym$b, 1))
c <- malloc(123)

### ~
start <- function() {
  rm(list = setdiff(ls(), lsf.str()))
  options(useFancyQuotes = FALSE)
  sym <<- env()
  global <<- env()
  stack <<- env()
  heap <<- env()
  nv <<- env()
  typ <<- env()
  alloca <<- make.alloca()
}

# new memory model testing


# TODO: ARRAY TESTS
### array.ll
rm(list = setdiff(ls(), lsf.str()))
options(useFancyQuotes = FALSE)
sym <- env()
global <- env()
stack <- env()
heap <- env()
nv <- env()
typ <- env()
alloca <- make.alloca()
# global
sym$"__const.main.vals" <- "global$\"0\""
global$"0" <- 2
global$"1" <- 4
global$"2" <- 8
global$"3" <- 16
# local
sym$"retval" <- alloca("i32")
sym$"vals" <- alloca("[4 x i32]")
sym$"x" <- alloca("i32")
store(0, sym$"retval")
sym$"0" <- bitcast(sym$"vals")
memcpy(sym$"0", bitcast(sym$"__const.main.vals"), "[4 x i32]")
store(0, sym$"x")
sym$"arrayidx" <- gep("[4 x i32]", sym$"vals", 0, 2)
store(3, sym$"arrayidx")
sym$"arrayidx1" <- gep("[4 x i32]", sym$"vals", 0, 0)
sym$"1" <- load(sym$"arrayidx1")
sym$"2" <- load(sym$"x")
sym$"add" <- add(sym$"2", sym$"1")
store(sym$"add", sym$"x")
sym$"arrayidx2" <- gep("[4 x i32]", sym$"vals", 0, 1)
sym$"3" <- load(sym$"arrayidx2")
sym$"4" <- load(sym$"x")
sym$"add3" <- add(sym$"4", sym$"3")
store(sym$"add3", sym$"x")
sym$"arrayidx4" <- gep("[4 x i32]", sym$"vals", 0, 2)
sym$"5" <- load(sym$"arrayidx4")
sym$"6" <- load(sym$"x")
sym$"add5" <- add(sym$"6", sym$"5")
store(sym$"add5", sym$"x")
sym$"7" <- load(sym$"x")
ret(sym$"7") # 9

### array1.ll
rm(list = setdiff(ls(), lsf.str()))
options(useFancyQuotes = FALSE)
sym <- env()
global <- env()
stack <- env()
heap <- env()
nv <- env()
typ <- env()
alloca <- make.alloca()
# global
sym$"nums" <- "global$\"0\""
global$"0" <- 1
global$"1" <- 2
global$"2" <- 3
# local
sym$"0" <- load(gep("[3 x i64]", sym$"nums", 0, 0))
ret(sym$"0") # 1

### array2.ll
rm(list = setdiff(ls(), lsf.str()))
options(useFancyQuotes = FALSE)
sym <- env()
global <- env()
stack <- env()
heap <- env()
nv <- env()
typ <- env()
alloca <- make.alloca()
# global
sym$"nums" <- "global$\"0\""
sym$"i" <- "global$\"3\""
global$"0" <- 1
global$"1" <- 2
global$"2" <- 3
global$"3" <- 1
# local
sym$"0" <- load(sym$"i")
sym$"arrayidx" <- gep("[3 x i32]", sym$"nums", 0, sym$"0")
sym$"1" <- load(sym$"arrayidx")
ret(sym$"1") # 2

### array3.ll
rm(list = setdiff(ls(), lsf.str()))
options(useFancyQuotes = FALSE)
sym <- env()
global <- env()
stack <- env()
heap <- env()
nv <- env()
typ <- env()
alloca <- make.alloca()
# global
sym$"nums" <- "global$\"0\""
sym$"i" <- "global$\"9\""
global$"0" <- 1
global$"1" <- 2
global$"2" <- 3
global$"3" <- 2
global$"4" <- 3
global$"5" <- 4
global$"6" <- 3
global$"7" <- 4
global$"8" <- 5
global$"9" <- 2
#local
sym$"0" <- load(sym$"i")
sym$"arrayidx" <- gep("[3 x [3 x i64]]", sym$"nums", 0, sym$"0")
sym$"1" <- load(sym$"i")
sym$"arrayidx1" <- gep("[3 x i64]", sym$"arrayidx", 0, sym$"1")
sym$"2" <- load(sym$"arrayidx1")
ret(sym$"2") # 5

### array4.ll
rm(list = setdiff(ls(), lsf.str()))
options(useFancyQuotes = FALSE)
sym <- env()
global <- env()
stack <- env()
heap <- env()
nv <- env()
typ <- env()
alloca <- make.alloca()
# global
sym$"nums" <- "global$\"0\""
sym$"i" <- "global$\"9\""
global$"0" <- 1
global$"1" <- 2
global$"2" <- 3
global$"3" <- 2
global$"4" <- 3
global$"5" <- 4
global$"6" <- 3
global$"7" <- 4
global$"8" <- 5
global$"9" <- 1
# local
sym$"0" <- load(sym$"i")
sym$"arrayidx" <- gep("[3 x [3 x i64]]", sym$"nums", 0, sym$"0")
sym$"1" <- load(sym$"i")
sym$"add" <- add(sym$"1", 1)
sym$"arrayidx1" <- gep("[3 x i64]", sym$"arrayidx", 0, sym$"add")
sym$"2" <- load(sym$"arrayidx1")
ret(sym$"2") # 4

### array5.ll
rm(list = setdiff(ls(), lsf.str()))
options(useFancyQuotes = FALSE)
sym <- env()
global <- env()
stack <- env()
heap <- env()
nv <- env()
typ <- env()
alloca <- make.alloca()
# global
sym$"arr" <- "global$\"0\""
sym$"i" <- "global$\"24\""
sym$"k" <- "global$\"25\""
global$"0" <- 1
global$"1" <- 2
global$"2" <- 3
global$"3" <- 4
global$"4" <- 5
global$"5" <- 2
global$"6" <- 3
global$"7" <- 4
global$"8" <- 1
global$"9" <- 2
global$"10" <- 3
global$"11" <- 4
global$"12" <- 1
global$"13" <- 2
global$"14" <- 3
global$"15" <- 4
global$"16" <- 1
global$"17" <- 2
global$"18" <- 3
global$"19" <- 4
global$"20" <- 1
global$"21" <- 2
global$"22" <- 3
global$"23" <- 4
global$"24" <- 0
global$"25" <- 0
# local
sym$"0" <- load(sym$"i")
sym$"idxprom" <- sext("i32", sym$"0", "i64")
sym$"arrayidx" <- gep("[2 x [3 x [4 x i32]]]", sym$"arr", 0, sym$"idxprom")
sym$"1" <- load(sym$"i")
sym$"add" <- add(sym$"1", 1)
sym$"idxprom1" <- sext("i32", sym$"add", "i64")
sym$"arrayidx2" <- gep("[3 x [4 x i32]]", sym$"arrayidx", 0, sym$"idxprom1")
sym$"2" <- load(sym$"k")
sym$"idxprom3" <- sext("i32", sym$"2", "i64")
sym$"arrayidx4" <- gep("[4 x i32]", sym$"arrayidx2", 0, sym$"idxprom3")
sym$"3" <- load(sym$"arrayidx4")
sym$"conv" <- sext("i32", sym$"3", "i64")
ret(sym$"conv") # 5

## TODO:STRUCT TESTS
### struct1.ll
rm(list = setdiff(ls(), lsf.str()))
options(useFancyQuotes = FALSE)
sym <- env()
global <- env()
stack <- env()
heap <- env()
nv <- env()
typ <- env()
alloca <- make.alloca()
# global
sym$foo <- "global$\"0\""
global$"0" <- 0
global$"1" <- 1
typ$"%struct.Foo" <- "i32, i32"
# local
sym$"0" <- load(gep("%struct.Foo", sym$foo, 0, 1))
ret(sym$"0") # 1

### struct2.ll
rm(list = setdiff(ls(), lsf.str()))
options(useFancyQuotes = FALSE)
sym <- env()
global <- env()
stack <- env()
heap <- env()
nv <- env()
typ <- env()
alloca <- make.alloca()
# global
sym$foo <- "global$\"0\""
global$"0" <- 0
global$"1" <- 1
global$"2" <- 0
global$"3" <- 2
global$"4" <- 3
global$"5" <- 0
global$"6" <- 4
global$"7" <- 5
global$"8" <- 0
typ$"%struct.Foo" <- "i32, i32, i32"
# local
sym$"i" <- 2 # from the metadata
sym$"i.addr" <- alloca("i32")
store(sym$"i", sym$"i.addr")
sym$"0" <- load(sym$"i.addr")
sym$"idxprom" <- sext("i32", sym$"0", "i64")
sym$"arrayidx" <- gep("[3 x %struct.Foo]", sym$foo, 0, sym$"idxprom")
sym$"b" <- gep("%struct.Foo", sym$"arrayidx", 0, 1)
sym$"1" <- load(sym$b)
ret(sym$"1") #5

### struct3.ll
rm(list = setdiff(ls(), lsf.str()))
options(useFancyQuotes = FALSE)
sym <- env()
global <- env()
stack <- env()
heap <- env()
nv <- env()
typ <- env()
alloca <- make.alloca()
# global
typ$"%struct.Foo" <- "i32, i32, i32"
# local
sym$"i" <- 2 # assume
sym$"i.addr" <- alloca("i32")
sym$"foo" <- alloca("[3 x %struct.Foo]")
store(sym$"i", sym$"i.addr")
sym$"0" <- load(sym$"i.addr")
sym$"idxprom" <- sext("i32", sym$"0", "i64")
sym$"arrayidx" <- gep("[3 x %struct.Foo]", sym$"foo", 0, sym$"idxprom")
sym$"b" <- gep("%struct.Foo", sym$arrayidx, 0, 1)
store(4, sym$"b")
sym$"1" <- load(sym$"i.addr")
sym$"idxprom1" <- sext("i32", sym$"1", "i64")
sym$"arrayidx2" <- gep("[3 x %struct.Foo]", sym$foo, 0, sym$"idxprom1")
sym$"b3" <- gep("%struct.Foo", sym$"arrayidx2", 0, 1)
sym$"2" <- load(sym$"b3")
ret(sym$"2") # 4

### struct4.ll
rm(list = setdiff(ls(), lsf.str()))
options(useFancyQuotes = FALSE)
sym <- env()
global <- env()
stack <- env()
heap <- env()
nv <- env()
typ <- env()
alloca <- make.alloca()
malloc <- make.malloc()
# global
typ$"%struct._str" <- "i32, i32*"
sym$"s" <- "global$\"0\""
global$"0" <- 0
global$"1" <- 0
global$"2" <- 0
global$"3" <- 0
# local
sym$"retval" <- alloca("i32")
sym$"x" <- alloca("i32")
store(0, sym$"retval")
store(3, gep("[2 x %struct._str]", sym$"s", 0, 0, 0))
sym$"0" <- load(gep("[2 x %struct._str]", sym$"s", 0, 0, 0))
sym$"conv" <- sext("i32", sym$"0", "i64")
sym$"mul" <- mul(4, sym$"conv")
sym$"call" <- malloc(sym$"mul") # TODO: malloc
sym$"1" <- bitcast(sym$"call")
store(sym$"1", gep("[2 x %struct._str]", sym$"s", 0, 0, 1))
sym$"2" <- load(gep("[2 x %struct._str]", sym$"s", 0, 0, 1))
sym$"arrayidx" <- gep("i32", sym$"2", 0)
store(2, sym$"arrayidx")
sym$"3" <- load(gep("[2 x %struct._str]", sym$"s", 0, 0, 1))
sym$"arrayidx1" <- gep("i32", sym$"3", 1)
store(5, sym$"arrayidx1")
sym$"4" <- load(gep("[2 x %struct._str]", sym$"s", 0, 0, 1))
sym$"arrayidx2" <- gep("i32", sym$"4", 2)
store(7, sym$"arrayidx2")
sym$"5" <- load(gep("[2 x %struct._str]", sym$"s", 0, 0, 1))
sym$"arrayidx3" <- gep("i32", sym$"5", 1)
sym$"6" <- load(sym$"arrayidx3")
sym$"7" <- load(gep("[2 x %struct._str]", sym$"s", 0, 0, 1))
sym$"arrayidx4" <- gep("i32", sym$"7", 2)
sym$"8" <- load(sym$"arrayidx4")
sym$"add" <- add(sym$"6", sym$"8")
store(sym$"add", sym$"x")
sym$"9" <- load(sym$"x")
ret(sym$"9") # 12

### struct5.ll
rm(list = setdiff(ls(), lsf.str()))
options(useFancyQuotes = FALSE)
sym <- env()
global <- env()
stack <- env()
heap <- env()
nv <- env()
typ <- env()
alloca <- make.alloca()
# global
typ$"%struct.Foo" <- "i32, i32, %struct.Bar"
typ$"%struct.Bar" <- "i32, i32"
sym$"foo" <- "global$\"0\""
global$"0" <- 0
global$"1" <- 1
global$"2" <- 2
global$"3" <- 3
# local
sym$"0" <- load(gep("%struct.Foo", sym$"foo", 0, 1))
ret(sym$"0") # 1

### struct6.ll
rm(list = setdiff(ls(), lsf.str()))
options(useFancyQuotes = FALSE)
sym <- env()
global <- env()
stack <- env()
heap <- env()
nv <- env()
typ <- env()
alloca <- make.alloca()
# global
typ$"%struct.S" <- "[2 x i32]"
sym$"__const.main.buf" <- "global$\"0\""
global$"0" <- 0
global$"1" <- 1
# local
sym$"retval" <- alloca("i32")
sym$"buf" <- alloca("%struct.S")
sym$"p" <- alloca("%struct.S*")
store(0, sym$"retval")
sym$"0" <- bitcast(sym$"buf")
memcpy(sym$"0", sym$"__const.main.buf", "%struct.S") # TODO: memcpy type??
store(sym$"buf", sym$"p")
sym$"1" <- load(sym$"p")
sym$"data" <- gep("%struct.S", sym$"1", 0, 0)
sym$"arraydecay" <- gep("[2 x i32]", sym$"data", 0, 0)
sym$"add.ptr" <- gep("i32", sym$"arraydecay", 1)
sym$"2" <- load(sym$"add.ptr")
ret(sym$"2") # 1

### struct7.ll
rm(list = setdiff(ls(), lsf.str()))
options(useFancyQuotes = FALSE)
sym <- env()
global <- env()
stack <- env()
heap <- env()
nv <- env()
typ <- env()
alloca <- make.alloca()
# global
typ$"%struct.S" <- "[2 x i32]"
sym$"buf" <- "global$\"0\""
global$"0" <- 0
global$"1" <- 1
# local
sym$"retval" <- alloca("i32")
sym$"p" <- alloca("%struct.s*")
store(0, sym$"retval")
store(sym$"buf", sym$"p")
store(3, gep("%struct.S", sym$"buf", 0, 0, 1))
sym$"0" <- load(sym$"p")
sym$"data" <- gep("%struct.S", sym$"0", 0, 0)
sym$"arraydecay" <- gep("[2 x i32]", sym$"data", 0, 0)
sym$"add.ptr" <- gep("i32", sym$"arraydecay", 1)
sym$"1" <- load(sym$"add.ptr")
ret(sym$"1") # 3

### struct8.ll
rm(list = setdiff(ls(), lsf.str()))
options(useFancyQuotes = FALSE)
sym <- env()
global <- env()
stack <- env()
heap <- env()
nv <- env()
typ <- env()
alloca <- make.alloca()
# global
typ$"%struct.ST" <- "%struct.RT, i32, %struct.RT"
typ$"%struct.RT" <- "i32, [3 x [2 x i32]], i32"
sym$"st" <- "global$\"0\""
global$"0" <- 0
global$"1" <- 0
global$"2" <- 0
global$"3" <- 0
global$"4" <- 0
global$"5" <- 0
global$"6" <- 0
global$"7" <- 0
global$"8" <- 0
global$"9" <- 0
global$"10" <- 0
global$"11" <- 0
global$"12" <- 0
global$"13" <- 0
global$"14" <- 0
global$"15" <- 0
global$"16" <- 0
global$"17" <- 0
global$"18" <- 0
global$"19" <- 0
global$"20" <- 0
global$"21" <- 0
global$"22" <- 0
global$"23" <- 0
global$"24" <- 0
global$"25" <- 0
global$"26" <- 0
global$"27" <- 0
global$"28" <- 0
global$"29" <- 0
global$"30" <- 0
global$"31" <- 0
global$"32" <- 0
global$"33" <- 0
# local
sym$"retval" <- alloca("i32")
sym$"s" <- alloca("%struct.ST*")
sym$"i" <- alloca("i32")
store(0, sym$"retval")
store(2, gep("[2 x %struct.ST]", sym$"st", 0, 1, 2, 1, 2, 1))
store(gep("[2 x %struct.ST]", sym$"st", 0, 1), sym$"s")
sym$"0" <- load(sym$"s")
sym$"Z" <- gep("%struct.ST", sym$"0", 0, 2)
sym$"B" <- gep("%struct.RT", sym$"Z", 0, 1)
sym$"arrayidx" <- gep("[3 x [2 x i32]]", sym$"B", 0, 2)
sym$"arrayidx1" <- gep("[2 x i32]", sym$"arrayidx", 0, 1)
sym$"1" <- load(sym$"arrayidx1")
store(sym$"1", sym$"i")
sym$"2" <- load(sym$"i")
ret(sym$"2") # 2

# TODO: POINTER TESTS
# pointer1.ll
rm(list = setdiff(ls(), lsf.str()))
options(useFancyQuotes = FALSE)
sym <- env()
global <- env()
stack <- env()
heap <- env()
nv <- env()
typ <- env()
# global
sym$b <- "global$\"0\""
sym$a <- "global$\"1\""
global$"0" <- 5
global$"1" <- sym$b
# local
sym$"0" <- load(sym$a)
sym$"1" <- load(sym$"0")
ret(sym$"1") # 5

# pointer2.ll
rm(list = setdiff(ls(), lsf.str()))
options(useFancyQuotes = FALSE)
sym <- env()
global <- env()
stack <- env()
heap <- env()
nv <- env()
typ <- env()
# global
typ$"%struct.Foo" <- "i32, i32, %struct.Bar"
typ$"%struct.Bar" <- "i32, i32"
sym$b <- "global$\"0\""
sym$a <- "global$\"1\""
sym$foo <- "global$\"2\""
global$"0" <- 5
global$"1" <- sym$b
global$"2" <- 0
global$"3" <- 1
global$"4" <- 5
global$"5" <- 3
# local
sym$"0" <- load(sym$a)
sym$"1" <- load(sym$"0")
store(sym$"1", gep("%struct.Foo", sym$foo, 0, 0))
sym$"2" <- load(gep("%struct.Foo", sym$foo, 0, 1))
ret(sym$"2") # 1

# pointer3.ll
rm(list = setdiff(ls(), lsf.str()))
options(useFancyQuotes = FALSE)
sym <- env()
global <- env()
stack <- env()
heap <- env()
nv <- env()
typ <- env()
# global
sym$c <- "global$\"0\""
sym$b <- "global$\"1\""
sym$a <- "global$\"2\""
global$"0" <- 5
global$"1" <- sym$c
global$"2" <- sym$b
# local
sym$"0" <- load(sym$a)
sym$"1" <- load(sym$"0")
sym$"2" <- load(sym$"1")
ret(sym$"2") # 5

# pointer4.ll
rm(list = setdiff(ls(), lsf.str()))
options(useFancyQuotes = FALSE)
sym <- env()
global <- env()
stack <- env()
heap <- env()
nv <- env()
typ <- env()
# global
typ$"%struct.Foo" <- "i32, i32, %struct.Bar"
typ$"%struct.Bar" <- "i32, i32, i32*"
sym$"@b" <- "global$\"0\""
sym$"@a" <- "global$\"1\""
sym$"@foo" <- "global$\"2\""
global$"0" <- 5
global$"1" <- sym$"@b"
global$"2" <- 0
global$"3" <- 1
global$"4" <- 5
global$"5" <- 3
global$"6" <- sym$"@b"
# local
sym$"%0" <- load(gep("%struct.Foo", sym$"@foo", 0, 2, 2))
ret(sym$"%0") # global$0

# TODO: LOCAL TESTS
# local1.ll
rm(list = setdiff(ls(), lsf.str()))
options(useFancyQuotes = FALSE)
sym <- env()
global <- env()
stack <- env()
heap <- env()
nv <- env()
typ <- env()
# global
sym$"__const.index_first.nums" <- "global$\"0\""
global$"0" <- 1
global$"1" <- 2
global$"2" <- 3
# local
sym$"nums" <- alloca("[3 x i32]")
sym$"n" <- alloca("i32")
sym$"0" <- bitcast(sym$nums)
memcpy(sym$"0", sym$"__const.index_first.nums", "[3 x i32]")
sym$"arrayidx" <- gep("[3 x i32]", sym$"nums", 0, 2)
sym$"1" <- load(sym$"arrayidx")
sym$"add" <- add(sym$"1", 2)
store(sym$"add", sym$"n")
sym$"2" <- load(sym$"n")
ret(sym$"2") # 5

# local2.c
rm(list = setdiff(ls(), lsf.str()))
options(useFancyQuotes = FALSE)
sym <- env()
global <- env()
stack <- env()
heap <- env()
nv <- env()
typ <- env()
# global
global$"0" <- 1
global$"1" <- 2
global$"2" <- 3
sym$c.nums <- "global$\"0\""
# local
sym$nums <- alloca("[3 x i64]")
sym$i <- alloca("i32")
sym$"0" <- bitcast(sym$"nums")
memcpy(sym$"0", sym$c.nums, "[3 x i64]")
store(2, sym$i)
sym$"1" <- load(sym$i)
sym$arrayidx <- gep("[3 x i64]", sym$nums, 0, sym$"1")
sym$"2" <- load(sym$arrayidx)
ret(sym$"2") # 3

# local3.ll
rm(list = setdiff(ls(), lsf.str()))
options(useFancyQuotes = FALSE)
sym <- env()
global <- env()
stack <- env()
heap <- env()
nv <- env()
typ <- env()
# global
sym$"__const.index_i2.nums" <- "global$\"0\""
global$"0" <- 1
global$"1" <- 2
global$"2" <- 3
global$"3" <- 2
global$"4" <- 3
global$"5" <- 4
global$"6" <- 3
global$"7" <- 4
global$"8" <- 5
# local
sym$"nums" <- alloca("[3 x [3 x i32]]")
sym$"i" <- alloca("i64")
sym$"i1" <- alloca("i64")
sym$"0" <- bitcast(sym$"nums")
memcpy(sym$"0", sym$"__const.index_i2.nums", "[3 x [3 x i64]]")
store(2, sym$"i")
store(1, sym$"i1")
sym$"1" <- load(sym$"i")
sym$"arrayidx" <- gep("[3 x [3 x i64]]", sym$"nums", 0, sym$"1")
sym$"2" <- load(sym$"i")
sym$"arrayidx2" <- gep("[3 x i64]", sym$"arrayidx", 0, sym$"2")
sym$"3" <- load(sym$"arrayidx2")
ret(sym$"3") # 5

# local4.ll
rm(list = setdiff(ls(), lsf.str()))
options(useFancyQuotes = FALSE)
sym <- env()
global <- env()
stack <- env()
heap <- env()
nv <- env()
typ <- env()
# global
typ$"%struct.Foo" <- "i32, i32"
sym$"__const.main.foo" <- "global$\"0\""
global$"0" <- 0
global$"1" <- 1
# local
sym$"retval" <- alloca("i32")
sym$"foo" <- alloca("%struct.Foo")
sym$"bar" <- alloca("%struct.Foo*")
store(0, sym$"retval")
sym$"0" <- bitcast(sym$"foo")
memcpy(sym$"0", sym$"__const.main.foo", "%struct.Foo")
sym$"a" <- gep("%struct.Foo", sym$"foo", 0, 0)
store(2, sym$"a")
store(sym$"foo", sym$"bar")
sym$"1" <- load(sym$"bar")
sym$"b" <- gep("%struct.Foo", sym$"1", 0, 1)
sym$"2" <- load(sym$"b")
ret(sym$"2") # 1


# local5.ll
rm(list = setdiff(ls(), lsf.str()))
options(useFancyQuotes = FALSE)
sym <- env()
global <- env()
stack <- env()
heap <- env()
nv <- env()
typ <- env()
# global
# local
sym$"b" <- alloca("i32")
sym$"a" <- alloca("i32*")
store(5, sym$"b")
store(sym$"b", sym$"a")
sym$"0" <- load(sym$"a")
sym$"1" <- load(sym$"0")
ret(sym$"1") # 5

# local6.ll
rm(list = setdiff(ls(), lsf.str()))
options(useFancyQuotes = FALSE)
sym <- env()
global <- env()
stack <- env()
heap <- env()
nv <- env()
typ <- env()
# global
typ$"%struct.Foo" <- "i32, i32, %struct.Bar"
typ$"%struct.Bar" <- "i32, i32"
sym$"__const.main.foo" <- "global$\"0\""
global$"0" <- 0
global$"1" <- 1
global$"2" <- 5
global$"3" <- 3
# local
sym$"retval" <- alloca("i32")
sym$"b" <- alloca("i32")
sym$"a" <- alloca("i32*")
sym$"foo" <- alloca("%struct.Foo")
store(0, sym$"retval")
store(5, sym$"b")
store(sym$b, sym$"a")
sym$"0" <- bitcast(sym$"foo")
memcpy(sym$"0", sym$"__const.main.foo", "%struct.Foo")
sym$"1" <- load(sym$"a")
sym$"2" <- load(sym$"1")
sym$"a1" <- gep("%struct.Foo", sym$"foo", 0, 0)
store(sym$"2", sym$"a1")
sym$"bar" <- gep("%struct.Foo", sym$"foo", 0, 2)
sym$"c" <- gep("%struct.Bar", sym$"bar", 0, 0)
sym$"3" <- load(sym$"c")
ret(sym$"3") # 5

# local7.ll
rm(list = setdiff(ls(), lsf.str()))
options(useFancyQuotes = FALSE)
sym <- env()
global <- env()
stack <- env()
heap <- env()
nv <- env()
typ <- env()
# global
sym$"__const.main.arr" <- "global$\"0\""
global$"0" <- 1
global$"1" <- 2
global$"2" <- 3
global$"3" <- 4
global$"4" <- 1
global$"5" <- 2
global$"6" <- 3
global$"7" <- 4
global$"8" <- 1
global$"9" <- 2
global$"10" <- 3
global$"11" <- 4
global$"12" <- 1
global$"13" <- 2
global$"14" <- 3
global$"15" <- 4
global$"16" <- 1
global$"17" <- 2
global$"18" <- 3
global$"19" <- 4
global$"20" <- 1
global$"21" <- 2
global$"22" <- 3
global$"23" <- 4
# local
sym$"retval" <- alloca("i32")
sym$"arr" <- alloca("[2 x [3 x [4 x i32]]]")
sym$"i" <- alloca("i32")
sym$"k" <- alloca("i32")
store(0, sym$"retval")
sym$"0" <- bitcast(sym$"arr")
memcpy(sym$"0", sym$"__const.main.arr", "[2 x [3 x [4 x i32]]]")
store(0, sym$"i")
store(1, sym$"k")
sym$"1" <- load(sym$"i")
sym$"idxprom" <- sext("i32", sym$"1", "i64")
sym$"arrayidx" <- gep("[2 x [3 x [4 x i32]]]", sym$"arr", 0, sym$"idxprom")
sym$"2" <- load(sym$"i")
sym$"add" <- add(sym$"2", 1)
sym$"idxprom1" <- sext("i32", sym$"add", "i64")
sym$"arrayidx2" <- gep("[3 x [4 x i32]]", sym$"arrayidx", 0, sym$"idxprom1")
sym$"3" <- load(sym$"k")
sym$"idxprom3" <- sext("i32", sym$"3", "i64")
sym$"arrayidx4" <- gep("[4 x i32]", sym$"arrayidx2", 0, sym$"idxprom3")
sym$"4" <- load(sym$"arrayidx4")
ret(sym$"4") # 2

# TODO: MALLOC TESTS
# malloc1.ll
rm(list = setdiff(ls(), lsf.str()))
options(useFancyQuotes = FALSE)
sym <- env()
global <- env()
stack <- env()
heap <- env()
nv <- env()
typ <- env()
malloc <- make.malloc()
alloca <- make.alloca()
# global
typ$"%struct.Foo" <- "i32"
sym$"foo" <- alloca("%struct.Foo*")
sym$"call" <- malloc(4)
sym$"0" <- bitcast(sym$"call")
store(sym$"0", sym$"foo")
sym$"1" <- load(sym$"foo")
sym$"A" <- gep("%struct.Foo", sym$"1", 0, 0)
store(12, sym$"A")
sym$"2" <- load(sym$"foo")
sym$"3" <- bitcast(sym$"2")
free(sym$"3")
ret(NULL) # void

# malloc2.ll
rm(list = setdiff(ls(), lsf.str()))
options(useFancyQuotes = FALSE)
sym <- env()
global <- env()
stack <- env()
heap <- env()
nv <- env()
typ <- env()
# global
# local
sym$"retval" <- alloca("i32")
sym$"i" <- alloca("i32*")
sym$"ret" <- alloca("i32")
store(0, sym$"retval")
sym$"call" <- malloc(20)
sym$"0" <- bitcast(sym$"call")
store(sym$"0", sym$"i")
sym$"1" <- load(sym$"i")
store(12, sym$"1")
sym$"2" <- load(sym$"i")
sym$"add.ptr" <- gep("i32", sym$"2", 1)
store(24, sym$"add.ptr")
sym$"3" <- load(sym$"i")
sym$"arrayidx" <- gep("i32", sym$"3", 1)
sym$"4" <- load(sym$"arrayidx")
store(sym$"4", sym$"ret")
sym$"5" <- load(sym$"i")
sym$"6" <- bitcast(sym$"5")
free(sym$"6")
sym$"7" <- load(sym$"ret")
ret(sym$"7") # 24

# malloc3.ll
rm(list = setdiff(ls(), lsf.str()))
options(useFancyQuotes = FALSE)
sym <- env()
global <- env()
stack <- env()
heap <- env()
nv <- env()
typ <- env()
# global
typ$"%struct.s1" <- "i32"
typ$"%struct.s2" <- "%struct.s1*"
# local
sym$"retval" <- alloca("i32")
sym$"data" <- alloca("%struct.s1")
sym$"sp" <- alloca("%struct.s2*")
sym$"a" <- alloca("[2 x i32]")
store(0, sym$"retval")
sym$"call" <- malloc(8)
sym$"0" <- bitcast(sym$"call")
store(sym$"0", sym$"sp")
sym$"1" <- load(sym$"sp")
sym$"p" <- gep("%struct.s2", sym$"1", 0, 0)
store(sym$"data", sym$"p")
sym$"2" <- load(sym$"sp")
sym$"p1" <- gep("%struct.s2", sym$"2", 0, 0)
sym$"3" <- load(sym$"p1")
sym$"d" <- gep("%struct.s1", sym$"3", 0, 0)
store(3, sym$"d")
sym$"d2" <- gep("%struct.s1", sym$"data", 0, 0)
sym$"4" <- load(sym$"d2")
sym$"arrayidx" <- gep("[2 x i32]", sym$"a", 0, 1)
store(sym$"4", sym$"arrayidx")
sym$"5" <- load(sym$"sp")
sym$"6" <- bitcast(sym$"5")
free(sym$"6")
sym$"arrayidx3" <- gep("[2 x i32]", sym$"a", 0, 1)
sym$"7" <- load(sym$"arrayidx3")
ret(sym$"7") # 3
