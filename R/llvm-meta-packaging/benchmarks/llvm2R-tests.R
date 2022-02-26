assert <- function(var, value, message) {
  if (var != value) message(message)
}

make.timer <- function() {
  start <- proc.time()

  f <- function() {
    return(proc.time() - start)
  }

  return(f)
}

timer <- make.timer()

print("*/*/*/*/*/*/*/* START TESTS */*/*/*/*/*/*/*")

# memcmp tests
# greater
source("./R/meta.R")
sym$.str.1 <- galloc("[7 x i8]", 97, 98, 99, 100, 101, 102, 0)
sym$.str <- galloc("[7 x i8]", 65, 66, 67, 68, 69, 70, 0)
sym$ret <- memcmp(sym$.str.1, sym$.str, 5)
ret(sym$ret)
assert(sym$"ret", 1, "memcmp-test-greater")
# equal
source("./R/meta.R")
sym$.str.1 <- galloc("[7 x i8]", 97, 98, 99, 100, 101, 102, 0)
sym$.str <- galloc("[7 x i8]", 97, 98, 99, 100, 101)
sym$ret <- memcmp(sym$.str.1, sym$.str, 6)
ret(sym$ret)
assert(sym$"ret", 0, "memcmp-test-equal")
# less
source("./R/meta.R")
sym$.str.1 <- galloc("[7 x i8]", 95, 98, 99, 100, 101, 102, 0)
sym$.str <- galloc("[7 x i8]", 97, 98, 99, 100, 101, 102, 0)
sym$ret <- memcmp(sym$.str.1, sym$.str, 5)
ret(sym$ret)
assert(sym$"ret", -1, "memcmp-test-less")


# TODO: Array Tests

### array.ll
source("./R/meta.R")
# global
sym$"__const.main.vals" <- galloc("[4 x i32]", 2, 4, 8, 16)
# local
sym$"retval" <- alloca("i32")
sym$"vals" <- alloca("[4 x i32]")
sym$"x" <- alloca("i32")
store(0, sym$"retval")
sym$"0" <- bitcast("[4 x i32]*", sym$"vals", "i8*")
memcpy(sym$"0", bitcast("[4 x i32]*", sym$"__const.main.vals", "i8*"), "[4 x i32]")
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
ret(sym$"7")
assert(sym$"7", 9, "array.ll")

### array1.ll
source("./R/meta.R")
# global
sym$"nums" <- galloc("[3 x i64]", 1, 2, 3)
# local
sym$"0" <- load(gep("[3 x i64]", sym$"nums", 0, 0))
ret(sym$"0") # 1
assert(sym$"0", 1, "array1.ll")

### array2.ll
source("./R/meta.R")
# global
sym$"nums" <- galloc("[3 x i64]", 1, 2, 3, 1)
sym$"i" <- galloc("i64", 1)
# local
sym$"0" <- load(sym$"i")
sym$"arrayidx" <- gep("[3 x i32]", sym$"nums", 0, sym$"0")
sym$"1" <- load(sym$"arrayidx")
ret(sym$"1") # 2
assert(sym$"1", 2, "array2.ll")

### array3.ll
source("./R/meta.R")
# global
sym$"nums" <- galloc("[3 x [3 x i64]]", 1, 2, 3, 2, 3, 4, 3, 4, 5)
sym$"i" <- galloc("i64", 2)
#local
sym$"0" <- load(sym$"i")
sym$"arrayidx" <- gep("[3 x [3 x i64]]", sym$"nums", 0, sym$"0")
sym$"1" <- load(sym$"i")
sym$"arrayidx1" <- gep("[3 x i64]", sym$"arrayidx", 0, sym$"1")
sym$"2" <- load(sym$"arrayidx1")
ret(sym$"2") # 5
assert(sym$"2", 5, "array3.ll")

### array4.ll
source("./R/meta.R")
# global
sym$"nums" <- galloc("[3 x [3 x i64]]", 1, 2, 3, 2, 3, 4, 3, 4, 5)
sym$"i" <- galloc("i64", 1)
# local
sym$"0" <- load(sym$"i")
sym$"arrayidx" <- gep("[3 x [3 x i64]]", sym$"nums", 0, sym$"0")
sym$"1" <- load(sym$"i")
sym$"add" <- add(sym$"1", 1)
sym$"arrayidx1" <- gep("[3 x i64]", sym$"arrayidx", 0, sym$"add")
sym$"2" <- load(sym$"arrayidx1")
ret(sym$"2") # 4
assert(sym$"2", 4, "array4.ll")

### array4.ll
source("./R/meta.R")
# global
sym$"arr" <- galloc("[2 x [3 x [4 x i32]]]", 1, 2, 3, 4, 5, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4)
sym$"i" <- galloc("i32", 0)
sym$"k" <- galloc("i32", 0)
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
assert(sym$"conv", 5, "array5.ll")

## TODO:STRUCT TESTS
### struct1.ll
source("./R/meta.R")
# global
typ$"%struct.Foo" <- "i32, i32"
sym$"foo" <- galloc("%struct.Foo", 0, 1)
# local
sym$"0" <- load(gep("%struct.Foo", sym$foo, 0, 1))
ret(sym$"0") # 1
assert(sym$"0", 1, "struct1.ll")

### struct2.ll
source("./R/meta.R")
# global
typ$"%struct.Foo" <- "i32, i32, i32"
sym$"foo" <- galloc("[3 x %struct.Foo]", 0, 1, 0, 2, 3, 0, 4, 5, 0)
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
assert(sym$"1", 5, "struct2.ll")

### struct3.ll
source("./R/meta.R")
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
assert(sym$"2", 4, "struct3.ll")

### struct4.ll
source("./R/meta.R")
# global
typ$"%struct._str" <- "i32, i32*"
sym$"s" <- galloc("[2 x %struct._str]", 0, null, 0, null)
# local
sym$"retval" <- alloca("i32")
sym$"x" <- alloca("i32")
store(0, sym$"retval")
store(3, gep("[2 x %struct._str]", sym$"s", 0, 0, 0))
sym$"0" <- load(gep("[2 x %struct._str]", sym$"s", 0, 0, 0))
sym$"conv" <- sext("i32", sym$"0", "i64")
sym$"mul" <- mul(4, sym$"conv")
sym$"call" <- malloc(sym$"mul")
sym$"1" <- bitcast("i8*", sym$"call", "i32*")
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
assert(sym$"9", 12, "struct4.ll")

### struct5.ll
source("./R/meta.R")
# global
typ$"%struct.Foo" <- "i32, i32, %struct.Bar"
typ$"%struct.Bar" <- "i32, i32"
sym$"foo" <- galloc("%struct.Foo", 0, 1, 2, 3)
# local
sym$"0" <- load(gep("%struct.Foo", sym$"foo", 0, 1))
ret(sym$"0") # 1
assert(sym$"0", 1, "struct5.ll")

### struct6.ll
source("./R/meta.R")
# global
typ$"%struct.S" <- "[2 x i32]"
sym$"__const.main.buf" <- galloc("%struct.S", 0, 1)
# local
sym$"retval" <- alloca("i32")
sym$"x" <- memory(5, 6, "enes")
sym$"buf" <- alloca("%struct.S")
sym$"p" <- alloca("%struct.S*")
store(0, sym$"retval")
sym$"0" <- bitcast("%struct.S*", sym$"buf", "i8*")
memcpy(sym$"0", sym$"__const.main.buf", "%struct.S")
store(sym$"buf", sym$"p")
sym$"1" <- load(sym$"p")
sym$"data" <- gep("%struct.S", sym$"1", 0, 0)
sym$"arraydecay" <- gep("[2 x i32]", sym$"data", 0, 0)
sym$"add.ptr" <- gep("i32", sym$"arraydecay", 1)
sym$"2" <- load(sym$"add.ptr")
ret(sym$"2") # 1
assert(sym$"2", 1, "struct6.ll")

### struct7.ll
source("./R/meta.R")
# global
typ$"%struct.S" <- "[2 x i32]"
sym$"buf" <- galloc("%struct.S", 0, 1)
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
assert(sym$"1", 3, "struct7.ll")

### struct8.ll
source("./R/meta.R")
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
sym$"0" <- load(sym$"s")
sym$"Z" <- gep("%struct.ST", sym$"0", 0, 2)
sym$"B" <- gep("%struct.RT", sym$"Z", 0, 1)
sym$"arrayidx" <- gep("[3 x [2 x i32]]", sym$"B", 0, 2)
sym$"arrayidx1" <- gep("[2 x i32]", sym$"arrayidx", 0, 1)
sym$"1" <- load(sym$"arrayidx1")
store(sym$"1", sym$"i")
sym$"2" <- load(sym$"i")
ret(sym$"2") # 2
assert(sym$"2", 2, "struct8.ll")

# TODO: POINTER TESTS
# pointer1.ll
source("./R/meta.R")
# global
sym$"b" <- galloc("i32", 5)
sym$"a" <- galloc("i32*", sym$"b")
# local
sym$"0" <- load(sym$a)
sym$"1" <- load(sym$"0")
ret(sym$"1") # 5
assert(sym$"1", 5, "pointer1.ll")

# pointer2.ll
source("./R/meta.R")
# global
typ$"%struct.Foo" <- "i32, i32, %struct.Bar"
typ$"%struct.Bar" <- "i32, i32"
sym$"b" <- galloc("i32", 5)
sym$"a" <- galloc("i32*", sym$"b")
sym$"foo" <- galloc("%struct.Foo", 0, 1, 5, 3)
# local
sym$"0" <- load(sym$a)
sym$"1" <- load(sym$"0")
store(sym$"1", gep("%struct.Foo", sym$foo, 0, 0))
sym$"2" <- load(gep("%struct.Foo", sym$foo, 0, 1))
ret(sym$"2") # 1
assert(sym$"2", 1, "pointer2.ll")

# pointer3.ll
source("./R/meta.R")
# global
sym$"c" <- galloc("i32", 5)
sym$"b" <- galloc("i32*", sym$"c")
sym$"a" <- galloc("i32**", sym$"b")
# local
sym$"0" <- load(sym$a)
sym$"1" <- load(sym$"0")
sym$"2" <- load(sym$"1")
ret(sym$"2") # 5
assert(sym$"2", 5, "pointer3.ll")

# pointer4.ll
source("./R/meta.R")
# global
typ$"%struct.Foo" <- "i32, i32, %struct.Bar"
typ$"%struct.Bar" <- "i32, i32, i32*"
sym$"b" <- galloc("i32", 5)
sym$"a" <- galloc("i32*", sym$"b")
sym$"foo" <- galloc("%struct.Foo", 0, 1, 5, 3, sym$"b")
# local
sym$"%0" <- load(gep("%struct.Foo", sym$"foo", 0, 2, 2))
ret(sym$"%0") # global$0
assert(sym$"%0", "global$\"0\"", "pointer4.ll")

# TODO: LOCAL TESTS
# local1.ll
source("./R/meta.R")
# global
sym$"__const.index_first.nums" <- galloc("[3 x i32]", 1, 2, 3)
# local
sym$"nums" <- alloca("[3 x i32]")
sym$"n" <- alloca("i32")
sym$"0" <- bitcast("[3 x i32]*", sym$nums, "i8*")
memcpy(sym$"0", sym$"__const.index_first.nums", "[3 x i32]")
sym$"arrayidx" <- gep("[3 x i32]", sym$"nums", 0, 2)
sym$"1" <- load(sym$"arrayidx")
sym$"add" <- add(sym$"1", 2)
store(sym$"add", sym$"n")
sym$"2" <- load(sym$"n")
ret(sym$"2") # 5
assert(sym$"2", 5, "local1.ll")

# local2.ll
source("./R/meta.R")
# global
sym$"__const.index_first.nums" <- galloc("[3 x i64]", 1, 2, 3)
# local
sym$nums <- alloca("[3 x i64]")
sym$i <- alloca("i32")
sym$"0" <- bitcast("[3 x i64]*", sym$"nums", "i8*")
memcpy(sym$"0", bitcast("[3 x i64]*", sym$"__const.index_first.nums", "i8*"), "[3 x i64]")
store(2, sym$i)
sym$"1" <- load(sym$i)
sym$arrayidx <- gep("[3 x i64]", sym$nums, 0, sym$"1")
sym$"2" <- load(sym$arrayidx)
ret(sym$"2") # 3
assert(sym$"2", 3, "local2.ll")

# local3.ll
source("./R/meta.R")
# global
sym$"__const.index_i2.nums" <- galloc("[3 x [3 x i64]]", 1, 2, 3, 2, 3, 4, 3, 4, 5)
# local
sym$"nums" <- alloca("[3 x [3 x i32]]")
sym$"i" <- alloca("i64")
sym$"i1" <- alloca("i64")
sym$"0" <- bitcast("[3 x [3 x i64]]*", sym$"nums", "i8*")
memcpy(sym$"0", bitcast("[3 x i64]*", sym$"__const.index_i2.nums", "i8*"), "[3 x [3 x i64]]")
store(2, sym$"i")
store(1, sym$"i1")
sym$"1" <- load(sym$"i")
sym$"arrayidx" <- gep("[3 x [3 x i64]]", sym$"nums", 0, sym$"1")
sym$"2" <- load(sym$"i")
sym$"arrayidx2" <- gep("[3 x i64]", sym$"arrayidx", 0, sym$"2")
sym$"3" <- load(sym$"arrayidx2")
ret(sym$"3") # 5
assert(sym$"3", 5, "local3.ll")

# local4.ll
source("./R/meta.R")
# global
typ$"%struct.Foo" <- "i32, i32"
sym$"__const.main.foo" <- galloc("%struct.Foo", 0, 1)
# local
sym$"retval" <- alloca("i32")
sym$"foo" <- alloca("%struct.Foo")
sym$"bar" <- alloca("%struct.Foo*")
store(0, sym$"retval")
sym$"0" <- bitcast("%struct.Foo*", sym$"foo", "i8*")
memcpy(sym$"0", bitcast("%struct.Foo*", sym$"__const.main.foo", "i8*"), "%struct.Foo")
sym$"a" <- gep("%struct.Foo", sym$"foo", 0, 0)
store(2, sym$"a")
store(sym$"foo", sym$"bar")
sym$"1" <- load(sym$"bar")
sym$"b" <- gep("%struct.Foo", sym$"1", 0, 1)
sym$"2" <- load(sym$"b")
ret(sym$"2") # 1
assert(sym$"2", 1, "local4.ll")

# local5.ll
source("./R/meta.R")
# global
# local
sym$"b" <- alloca("i32")
sym$"a" <- alloca("i32*")
store(5, sym$"b")
store(sym$"b", sym$"a")
sym$"0" <- load(sym$"a")
sym$"1" <- load(sym$"0")
ret(sym$"1") # 5
assert(sym$"1", 5, "local5.ll")

# local6.ll
source("./R/meta.R")
# global
typ$"%struct.Foo" <- "i32, i32, %struct.Bar"
typ$"%struct.Bar" <- "i32, i32"
sym$"__const.main.foo" <- galloc("%struct.Foo", 0, 1, 5, 3)
# local
sym$"retval" <- alloca("i32")
sym$"b" <- alloca("i32")
sym$"a" <- alloca("i32*")
sym$"foo" <- alloca("%struct.Foo")
store(0, sym$"retval")
store(5, sym$"b")
store(sym$b, sym$"a")
sym$"0" <- bitcast("%struct.Foo*", sym$"foo", "i8*")
memcpy(sym$"0", bitcast("%struct.Foo*", sym$"__const.main.foo", "i8*"), "%struct.Foo")
sym$"1" <- load(sym$"a")
sym$"2" <- load(sym$"1")
sym$"a1" <- gep("%struct.Foo", sym$"foo", 0, 0)
store(sym$"2", sym$"a1")
sym$"bar" <- gep("%struct.Foo", sym$"foo", 0, 2)
sym$"c" <- gep("%struct.Bar", sym$"bar", 0, 0)
sym$"3" <- load(sym$"c")
ret(sym$"3") # 5
assert(sym$"3", 5, "local6.ll")

# local7.ll
source("./R/meta.R")
# global
sym$"__const.main.arr" <- galloc("[2 x [3 x [4 x i32]]]", 1, 2, 3, 4, 1, 9, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4)
# local
sym$"retval" <- alloca("i32")
sym$"arr" <- alloca("[2 x [3 x [4 x i32]]]")
sym$"i" <- alloca("i32")
sym$"k" <- alloca("i32")
store(0, sym$"retval")
sym$"0" <- bitcast("[2 x [3 x [4 x i32]]]*", sym$"arr", "i8*")
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
ret(sym$"4") # 9
assert(sym$"4", 9, "local7.ll")

# TODO: MALLOC TESTS
# malloc1.ll
source("./R/meta.R")
# local
typ$"%struct.Foo" <- "i32"
sym$"foo" <- alloca("%struct.Foo*")
sym$"call" <- malloc(4)
sym$"0" <- bitcast("i8*", sym$"call", "%struct.Foo*")
store(sym$"0", sym$"foo")
sym$"1" <- load(sym$"foo")
sym$"A" <- gep("%struct.Foo", sym$"1", 0, 0)
store(12, sym$"A")
sym$"2" <- load(sym$"foo")
sym$"3" <- bitcast("%struct.Foo*", sym$"2", "i8*")
free(sym$"3")
ret(NULL) # void

# malloc2.ll
source("./R/meta.R")
# global
# local
sym$"retval" <- alloca("i32")
sym$"i" <- alloca("i32*")
sym$"ret" <- alloca("i32")
store(0, sym$"retval")
sym$"call" <- malloc(20)
sym$"0" <- bitcast("i8*", sym$"call", "i32*")
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
sym$"6" <- bitcast("i32*", sym$"5", "i8*")
free(sym$"6")
sym$"7" <- load(sym$"ret")
ret(sym$"7") # 24
assert(sym$"7", 24, "malloc2.ll")

# malloc3.ll
source("./R/meta.R")
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
sym$"0" <- bitcast("i8*", sym$"call", "%struct.s2*")
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
sym$"6" <- bitcast("%struct.s2*", sym$"5", "i8*")
free(sym$"6")
sym$"arrayidx3" <- gep("[2 x i32]", sym$"a", 0, 1)
sym$"7" <- load(sym$"arrayidx3")
ret(sym$"7") # 3
assert(sym$"7", 3, "malloc3.ll")

# TODO: BIT OPERATION TESTS

# shl
assert(shl("i32", 4, 2), 16, "shl -> i32, 4, 2")
assert(shl("i4", 8, 1), 0, "shl -> i4, 8, 1")
assert(shl("i32", 1, 10), 1024, "shl -> i32, 1, 10")
# llvm says undefined
assert(shl("i32", 1, 32), 0, "shl -> i32, 1, 32")

# lshr
assert(lshr("i32", 4, 1), 2, "lshr -> i32, 4, 1")
assert(lshr("i32", 4, 2), 1, "lshr -> i32, 4, 2")
assert(lshr("i8", 4, 3), 0, "lshr -> i8, 4, 3")
assert(lshr("i8", -2, 1), 127, "lshr -> i8, -2, 1")
# llvm says undefined
assert(lshr("i32", 1, 32), 0, "lshr -> i32, 1, 32")
assert(lshr("i64", 8, 1), "4", "lshr -> i64, 8, 1")
assert(lshr("i64", 4, 1), "2", "lshr -> i64, 4, 1")
assert(lshr("i64", 2, 1), "1", "lshr -> i64, 2, 1")
assert(lshr("i64", 1, 1), "0", "lshr -> i64, 1, 1")


# ashr
assert(ashr("i64", 4, 1), 2, "ashr -> i32, 4, 1")
assert(ashr("i32", 4, 2), 1, "ashr -> i32, 4, 2")
assert(ashr("i8", 4, 3), 0, "ashr -> i8, 4, 3")
assert(ashr("i8", -2, 1), -1, "ashr -> i8, -2, 1")
# llvm says undefined
assert(ashr("i32", 1, 32), 0, "ashr -> i32, 1, 32")

# and
assert(and(15, 40), 8, "and -> 15, 40")
assert(and(4, 8), 0, "and -> 4, 8")

# or
assert(or(15, 40), 47, "or -> 15, 40")
assert(or(4, 8), 12, "or -> 4, 8")

# xor
assert(xor(15, 40), 39, "xor -> 15, 40")
assert(xor(4, 8), 12, "xor -> 4, 8")

# trunc
assert(trunc("i32", 257, "i8"), 1, "trunc -> i32, 257, i8")
assert(trunc("i32", 123, "i1"), 1, "trunc -> i32, 257, i1")
assert(trunc("i32", 122, "i1"), 0, "trunc -> i32, 122, i1")

# zext
assert(zext("i32", 25, "i64"), 25, "zext -> i32, 25, i64")

# sext
assert(sext("i8", -1, "i16"), 65535, "sext -> i8, -1, i16")
assert(sext("i1", 1, "i32"), -1, "sext -> i1, 1, i32") # 4294967295 ?= -1
assert(sext("i1", 0, "i32"), 0, "sext -> i1, 0, i32")

# bitcast
assert(bitcast("i8", 255, "i8"), 255, "bitcast -> i8, 255, i8")
sym$"x" <- 10
assert(bitcast("i32*", sym$"x", "sint*"), sym$"x", "bitcast -> i32*, sym$\"x\", sint*")

# fptoui
assert(fptoui("double", 123.0, "i32"), 123, "fptoui -> double, 123.0, i32")
# llvm says undefined
assert(fptoui("float", 1.0e+300, "i1"), 1, "fptoui -> float, 1.0e+300, i1")
# llvm says undefined
assert(fptoui("float", 1.04e+17, "i8"), 0, "fptoui -> float, 1.04e+17, i8")

# fptosi
assert(fptosi("double", -123.0, "i32"), -123, "fptosi -> double, -123.0, i32")
# llvm says undefined
assert(fptosi("float", 1.0e-247, "i1"), 0, "fptosi -> float, 1.0e-247, i1")
# llvm says undefined
assert(fptosi("float", 1.04e+17, "i8"), 0, "fptosi -> float, 1.04e+17, i8")

# uitofp
assert(uitofp("i32", 257, "float"), 257.0, "uitofp -> i32, 257, float")
assert(uitofp("i8", -1, "double"), 255, "uitofp -> i8, -1, double")

# sitofp
assert(sitofp("i32", 257, "float"), 257.0, "sitofp -> i32, 257, float")
assert(sitofp("i8", -1, "double"), -1.0, "sitofp -> i8, -1, double")

2^29 == lshr("i32", 2^30, 1)
0 == shl("i32", 2^31, 1)
2^29 == shl("i32", 2^28, 1)
0 == shl("i32", 2^63, 1)
2^31 - 1 == lshr("i32", -2, 1)
2^29 == ashr("i32", 2^30, 1)
and(15, 40) == 8
and(-2, 4) == 4
and(-2, -1) == -2
or(15, 40) == 47
or(4, 8) == 12
or(-2, -3) == -1
or(-2, -1) == -1
xor(15, 40) == 39
xor(4, 8) == 12
trunc("i32", 257, "i8") == 1
trunc("i32", 256, "i8") == 0
trunc("i32", 123, "i1") == 1
trunc("i32", 122, "i1") == 0
trunc("i32", 3, "i1") == 1
trunc("i32", -2, "i1") == 0
fptosi("double", -123.0, "i32") == -123
fptosi("float", 1.5, "i8") == 1
fptoui("double", 123.0, "i32") == 123
fptoui("double", 123.5, "i32")

cat("*/*/*/*/*/*/*/* END TESTS */*/*/*/*/*/*/*\nTime elapsed:", timer())