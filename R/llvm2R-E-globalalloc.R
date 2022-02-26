# Title     : LLVM to R - Global allocation development and test script
# Objective : Find all possible global allocation formats (arrays, strings etc.)
#             create an allocator function and test with test cases
# Created by: enes
# Created on: 1/19/21

### TODO: Global Variable Formats - examples
## TODO: Atomic Types (char, int, double)

# char x;
# @x = dso_local global i8 0, align 1

# char x = 'x';
# @x = dso_local global i8 120, align 1

# int a;
# @a = dso_local global i32 0, align 4

# double a;
# @a = dso_local global double 0.000000e+00, align 8

# long double x; // 80-bit floating-point value (X87) https://llvm.org/docs/LangRef.html#id1320
# @x = dso_local global x86_fp80 0xK00000000000000000000, align 16

## TODO: Pointers

# char* x;
# @x = dso_local global i8* null, align 8

# pointer1.ll:
# @b = dso_local global i32 5, align 4
# @a = dso_local global i32* @b, align 8

# pointer3.ll:
# @c = dso_local global i32 5, align 4
# @b = dso_local global i32* @c, align 8
# @a = dso_local global i32** @b, align 8

## TODO: Static Definitions

# int foo(){ static int a; }
# @_ZZ3foovE1a = internal global i32 0, align 4

# int foo(){ static int a = 5; }
# @_ZZ3foovE1a = internal global i32 5, align 4

# static int b = 2;
# @_ZL1b = internal global i32 2, align 4

## TODO: Arrays

# Array constants are represented with square brackets

# array.ll:
# @__const.main.vals = private unnamed_addr constant [4 x i32] [i32 2, i32 4, i32 8, i32 16], align 16

# array1.ll:
# @nums = dso_local global [3 x i64] [i64 1, i64 2, i64 3]

# array2.ll:
# @nums = dso_local global [3 x i64] [i64 1, i64 2, i64 3], align 16
# @i = dso_local global i64 1, align 8

# array3.ll:
# @nums = dso_local global [3 x [3 x i64]] [[3 x i64] [i64 1, i64 2, i64 3], [3 x i64] [i64 2, i64 3, i64 4], [3 x i64] [i64 3, i64 4, i64 5]], align 16
# @i = dso_local global i64 2, align 8

# array4.ll:
# @arr = dso_local global [2 x [3 x [4 x i32]]] [[3 x [4 x i32]] [[4 x i32] [i32 1, i32 2, i32 3, i32 4], [4 x i32] [i32 5, i32 2, i32 3, i32 4], [4 x i32] [i32 1, i32 2, i32 3, i32 4]], [3 x [4 x i32]] [[4 x i32] [i32 1, i32 2, i32 3, i32 4], [4 x i32] [i32 1, i32 2, i32 3, i32 4], [4 x i32] [i32 1, i32 2, i32 3, i32 4]]], align 16
# @i = dso_local global i32 0, align 4
# @k = dso_local global i32 0, align 4

# int x[3];
# @x = dso_local global [3 x i32] zeroinitializer, align 4

# int x[3][2][6];
# @x = dso_local global [3 x [2 x [6 x i32]]] zeroinitializer, align 16

## TODO: Structs

# Structure constants are represented with braces

# local4.ll:
# @__const.main.foo = private unnamed_addr constant %struct.Foo { i32 0, i32 1 }, align 4

# local6.ll:
# %struct.Foo = type { i32, i32, %struct.Bar }
# %struct.Bar = type { i32, i32 }
# @__const.main.foo = private unnamed_addr constant %struct.Foo { i32 0, i32 1, %struct.Bar { i32 5, i32 3 } }, align 4

# malloc4.ll:
# @buf = dso_local global %struct.S { [2 x i32] [i32 0, i32 1] }, align 4

# struct1.ll:
# @foo = dso_local global %struct.Foo { i32 0, i32 1 }, align 4

# struct2.ll:
# @foo = dso_local global [3 x %struct.Foo] [%struct.Foo { i32 0, i32 1, i32 0 }, %struct.Foo { i32 2, i32 3, i32 0 }, %struct.Foo { i32 4, i32 5, i32 0 }], align 16

# struct4.ll:
# @s = dso_local global [2 x %struct._str] zeroinitializer, align 16

# struct8.ll:
# @st = dso_local global [2 x %struct.ST] zeroinitializer, align 16

## TODO: Char Arrays (Strings)

# foo.ll:
# @.str = private unnamed_addr constant [11 x i8] c"x - y != 0\00", align 1
# @.str.1 = private unnamed_addr constant [14 x i8] c"./input/foo.c\00", align 1
# @__PRETTY_FUNCTION__.foobar = private unnamed_addr constant [22 x i8] c"void foobar(int, int)\00", align 1
# @__PRETTY_FUNCTION__.foobar1 = private unnamed_addr constant [23 x i8] c"void foobar1(int, int)\00", align 1

# pointer5.ll:
# @.str = private unnamed_addr constant [27 x i8] c"The value of pointer is %u\00", align 1

# char* x = "hello";
# @.str = private unnamed_addr constant [6 x i8] c"hello\00", align 1
# @x = dso_local global i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i32 0, i32 0), align 8

## TODO(?): Function Pointers

# int (*my_int_f)(int) = &abs; // store the address of the standard function abs in the variable my_int_f
# @my_int_f = dso_local global i32 (i32)* @abs, align 8
# declare dso_local i32 @abs(i32) #0

## TODO: Other

# @G = addrspace(5) constant float 1.0, section "foo", align 4

### TODO: Keywords

# dso_local: linkage type, resolve a symbol within the same linkage unit
# global: LLVM identifiers come in two basic types: global and local. Global identifiers (functions, global variables) begin with the '@' character.
# constant: indicates that the contents of the variable will never be modified
# private: global values with “private” linkage are only directly accessible by objects in the current module.
# unnamed_addr: indicates that the address is not significant, only the content
# zeroinitializer: can be used to zero initialize a value to zero of any type
# internal: Similar to private, but the value shows as a local symbol (STB_LOCAL in the case of ELF) in the object file. This corresponds to the notion of the ‘static’ keyword in C.
# external: If none of the above identifiers are used, the global is externally visible, meaning that it participates in linkage and can be used to resolve external symbol references.

### TODO: What are the fields needed to allocate the global variables accurately on the R model?

# name: name of the global variable must be given in order to register it to the symbol table.
# type: if an aggregate type is allocated without any initial values, it has to be initialized with zeros
#       (zeroinitializer). type is needed to calculate the memory size which is going to be allocated.
# value(s): definition values of the global variable. if the variable is only declared, this field must be 'zeroinitializer'.
#           if the value is another variable(pointer), its name must be given as string ( (..., "@name") ).
#           strings -> globAlloca("@name", "[6 x i8]", strsplit("hello\3", "")[[1]])

## Examples

# @.str = private unnamed_addr constant [27 x i8] "The value of pointer is %u\00", align 1
# globAllocator("@.str", "[27 x i8]", strsplit("The value of pointer is %u")) # splitted, since this is also an aggregate type

# @s = dso_local global [2 x %struct._str] zeroinitializer, align 16
# globAllocator("@s", "[2 x %struct._str]", "zeroinitializer")

# @c = dso_local global i32 5, align 4
# @b = dso_local global i32* @c, align 8
# globAllocator("@c", "i32", 5)
# globAllocator("@b", "i32*", "@c") # pointer

# @arr = dso_local global [2 x [3 x [4 x i32]]] [[3 x [4 x i32]] [[4 x i32] [i32 1, i32 2, i32 3, i32 4], [4 x i32] [i32 5, i32 2, i32 3, i32 4], [4 x i32] [i32 1, i32 2, i32 3, i32 4]], [3 x [4 x i32]] [[4 x i32] [i32 1, i32 2, i32 3, i32 4], [4 x i32] [i32 1, i32 2, i32 3, i32 4], [4 x i32] [i32 1, i32 2, i32 3, i32 4]]], align 16
# globAllocator("@arr", "[2 x [3 x [4 x i32]]]", list(1, 2, 3, 4, 5, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4))

# @.str = private unnamed_addr constant [6 x i8] c"hello\00", align 1
# @x = dso_local global i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i32 0, i32 0), align 8
# globAllocator("@.str", "[6 x i8]", strsplit("hello", ""))
# globAllocator("@x", "i8*", gep("[6 x i8]", global$"str", 0, 0)) # special case (?)

### TODO: Regex

# atomic types: "i(\\d+)|double|float"
# aggregate types:
#   array: "(\\[.*\\])"
#   struct: "(%struct\\..*)"

### TODO: Psuedocode
"
sp <- 0
globalAllocator(name, type, value) {
  delete @ from name
  sym$name is global$sp

  if(type is atomic){
    global$sp is value
    sp++
  }
  else {
    if(value is zeroinitializer)
      value is list(0, size = calcsize(type))
    value <- getValues(value) # returns a list
    for(i = 0; i<len(value)){
      global$sp is value[i]
      sp++
    }
  }
}
"

### TODO: Implementation

# getValues <- function(valStr) {
#   if(grep("^c", valStr, perl = TRUE)){
#
#   } else {
#     valStr <- gsub("{|}|\\[|\\]|,|\\d x |i\\d+|double|float|%struct\\.[a-zA-Z0-9_%-]+", "", valStr)
#     valStr <- strsplit(valStr, " +")
#   }
#
#   return(valStr)
# }

make.ga <- function() {
  sp <- 0

  f <- function(name, type, value) {
    name <- base::sub("^@", "", name, perl = TRUE)
    sym[[toString(name)]] <- paste0("global$", dQuote(toString(sp)))

    if (length(grep("(\\[.*\\])|(%struct\\..*)", type))) {
      if (length(grep("zeroinitializer", value))) # values are not initialized
        value <- rep(0, calcSize(resolveType(type)))

      for (i in value) {
        if (length(grep("^@", toString(i)))) i <- eval(str2expression(paste0("sym$", dQuote(base::sub("^@", "", i, perl = TRUE)))))
        global[[toString(sp)]] <- i
        sp <<- sp + 1
      }
    }
    else {
      if (length(grep("^@", value))) value <- eval(str2expression(paste0("sym$", dQuote(base::sub("^@", "", value, perl = TRUE)))))
      global[[toString(sp)]] <- value
      sp <<- sp + 1
    }
  }

  return(f)
}

### TODO: Tests
options(useFancyQuotes = FALSE)

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

# %struct.c = type { [3 x %struct.a], [4 x %struct.b] }
# %struct.a = type { [5 x i32] }
# %struct.b = type { [2 x %struct.a] }
rm(list = setdiff(ls(), lsf.str()))
sym <- env()
global <- env()
typ <- env()
globAlloca <- make.ga()

## TODO - Atomic Types (char, int, double)
# char x;
# @x = dso_local global i8 0, align 1
# char w = 'x';
# @w = dso_local global i8 120, align 1
# int y;
# @y = dso_local global i32 0, align 4
# double a;
# @z = dso_local global double 0.000000e+00, align 8

globAlloca("@x", "i8", 0)
globAlloca("@w", "i8", 120)
globAlloca("@y", "i32", 0)
globAlloca("@z", "double", 0.000000e+00)

rm(list = setdiff(ls(), lsf.str()))
sym <- env()
global <- env()
typ <- env()
globAlloca <- make.ga()

## TODO - Pointers
# char* x;
# @x = dso_local global i8* null, align 8

globAlloca("@x", "i8*", "NULL")

# pointer1.ll:
# @b = dso_local global i32 5, align 4
# @a = dso_local global i32* @b, align 8

globAlloca("@b", "i32", 5)
globAlloca("@a", "i32*", "@b")

# pointer3.ll:
# @c = dso_local global i32 5, align 4
# @b = dso_local global i32* @c, align 8
# @a = dso_local global i32** @b, align 8

globAlloca("@c", "i32", 5)
globAlloca("@b", "i32*", "@c")
globAlloca("@a", "i32**", "@b")

rm(list = setdiff(ls(), lsf.str()))
sym <- env()
global <- env()
typ <- env()
globAlloca <- make.ga()

## TODO - Arrays

# array.ll:
# @__const.main.vals = private unnamed_addr constant [4 x i32] [i32 2, i32 4, i32 8, i32 16], align 16

globAlloca("@__const.main.vals", "[4 x i32]", list(2, 4, 8, 16))

# array1.ll:
# @nums = dso_local global [3 x i64] [i64 1, i64 2, i64 3]
rm(list = setdiff(ls(), lsf.str()))
sym <- env()
global <- env()
typ <- env()
globAlloca <- make.ga()

globAlloca("@nums", "[3 x i64]", list(1, 2, 3))

# array2.ll:
# @nums = dso_local global [3 x i64] [i64 1, i64 2, i64 3], align 16
# @i = dso_local global i64 1, align 8
rm(list = setdiff(ls(), lsf.str()))
sym <- env()
global <- env()
typ <- env()
globAlloca <- make.ga()

globAlloca("@nums", "[3 x i64]", list(1, 2, 3))
globAlloca("@i", "i64", 1)

# array3.ll:
# @nums = dso_local global [3 x [3 x i64]] [[3 x i64] [i64 1, i64 2, i64 3], [3 x i64] [i64 2, i64 3, i64 4], [3 x i64] [i64 3, i64 4, i64 5]], align 16
# @i = dso_local global i64 2, align 8
rm(list = setdiff(ls(), lsf.str()))
sym <- env()
global <- env()
typ <- env()
globAlloca <- make.ga()

globAlloca("@nums", "[3 x [3 x i64]]", list(1, 2, 3, 2, 3, 4, 3, 4, 5))
globAlloca("@nums", "i64", 2)

# array4.ll:
# @arr = dso_local global [2 x [3 x [4 x i32]]] [[3 x [4 x i32]] [[4 x i32] [i32 1, i32 2, i32 3, i32 4], [4 x i32] [i32 5, i32 2, i32 3, i32 4], [4 x i32] [i32 1, i32 2, i32 3, i32 4]], [3 x [4 x i32]] [[4 x i32] [i32 1, i32 2, i32 3, i32 4], [4 x i32] [i32 1, i32 2, i32 3, i32 4], [4 x i32] [i32 1, i32 2, i32 3, i32 4]]], align 16
# @i = dso_local global i32 0, align 4
# @k = dso_local global i32 0, align 4
rm(list = setdiff(ls(), lsf.str()))
sym <- env()
global <- env()
typ <- env()
globAlloca <- make.ga()

globAlloca("@arr", "[2 x [3 x [4 x i32]]]", list(1, 2, 3, 4, 5, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4, 1, 2, 3, 4))
globAlloca("@i", "i32", 0)
globAlloca("@k", "i32", 0)

# int x[3];
# @x = dso_local global [3 x i32] zeroinitializer, align 4
rm(list = setdiff(ls(), lsf.str()))
sym <- env()
global <- env()
typ <- env()
globAlloca <- make.ga()

globAlloca("@x", "[3 x i32]", "zeroinitializer")

# int x[3][2][6];
# @x = dso_local global [3 x [2 x [6 x i32]]] zeroinitializer, align 16
rm(list = setdiff(ls(), lsf.str()))
sym <- env()
global <- env()
typ <- env()
globAlloca <- make.ga()

globAlloca("@x", "[3 x [2 x [6 x i32]]]", "zeroinitializer")

rm(list = setdiff(ls(), lsf.str()))
sym <- env()
global <- env()
typ <- env()
globAlloca <- make.ga()

## TODO: Structs

# local4.ll:
# @__const.main.foo = private unnamed_addr constant %struct.Foo { i32 0, i32 1 }, align 4

globAlloca("@__const.main.foo", "%struct.Foo", list(0, 1))

rm(list = setdiff(ls(), lsf.str()))
sym <- env()
global <- env()
typ <- env()
globAlloca <- make.ga()
# local6.ll:
# %struct.Foo = type { i32, i32, %struct.Bar }
# %struct.Bar = type { i32, i32 }
# @__const.main.foo = private unnamed_addr constant %struct.Foo { i32 0, i32 1, %struct.Bar { i32 5, i32 3 } }, align 4
typ$"%struct.Foo" <- "i32, i32, %struct.Bar"
typ$"%struct.Bar" <- "i32, i32"
globAlloca("@__const.main.foo", "%struct.Foo", list(0, 1, 5, 3))

rm(list = setdiff(ls(), lsf.str()))
sym <- env()
global <- env()
typ <- env()
globAlloca <- make.ga()
# malloc4.ll:
# @buf = dso_local global %struct.S { [2 x i32] [i32 0, i32 1] }, align 4
typ$"%struct.S" <- "[2 x i32]"
globAlloca("@buf", "%struct.S", list(0, 1))

rm(list = setdiff(ls(), lsf.str()))
sym <- env()
global <- env()
typ <- env()
globAlloca <- make.ga()
# struct1.ll:
# @foo = dso_local global %struct.Foo { i32 0, i32 1 }, align 4
typ$"%struct.Foo" <- "i32, i32"
globAlloca("@foo", "%struct.Foo", list(0, 1))

rm(list = setdiff(ls(), lsf.str()))
sym <- env()
global <- env()
typ <- env()
globAlloca <- make.ga()
# struct2.ll:
# @foo = dso_local global [3 x %struct.Foo] [%struct.Foo { i32 0, i32 1, i32 0 }, %struct.Foo { i32 2, i32 3, i32 0 }, %struct.Foo { i32 4, i32 5, i32 0 }], align 16
typ$"%struct.Foo" <- "i32, i32, i32"
globAlloca("@foo", "[3 x %struct.Foo]", list(0, 1, 0, 2, 3, 0, 4, 5, 0))

rm(list = setdiff(ls(), lsf.str()))
sym <- env()
global <- env()
typ <- env()
globAlloca <- make.ga()
# struct4.ll:
# @s = dso_local global [2 x %struct._str] zeroinitializer, align 16
typ$"%struct._str" <- "i32, i32*"
globAlloca("@s", "%struct._str", "zeroinitializer")

rm(list = setdiff(ls(), lsf.str()))
sym <- env()
global <- env()
typ <- env()
globAlloca <- make.ga()
# struct8.ll:
# @st = dso_local global [2 x %struct.ST] zeroinitializer, align 16
typ$"%struct.ST" <- "%struct.RT, i32, %struct.RT"
typ$"%struct.RT" <- "i32, [3 x [2 x i32]], i32"
globAlloca("@st", "[2 x %struct.ST]", "zeroinitializer")

rm(list = setdiff(ls(), lsf.str()))
sym <- env()
global <- env()
typ <- env()
globAlloca <- make.ga()

## TODO: Char Arrays (Strings)

# foo.ll:
# @.str = private unnamed_addr constant [11 x i8] c"x - y != 0\00", align 1
# @.str.1 = private unnamed_addr constant [14 x i8] c"./input/foo.c\00", align 1
# @__PRETTY_FUNCTION__.foobar = private unnamed_addr constant [22 x i8] c"void foobar(int, int)\00", align 1
# @__PRETTY_FUNCTION__.foobar1 = private unnamed_addr constant [23 x i8] c"void foobar1(int, int)\00", align 1

globAlloca("@.str", "[11 x i8]", strsplit("x - y != 0\3", "")[[1]]) # "\3" -> end of string, "\00" NOT ALLOWED IN R
globAlloca("@.str.1", "[14 x i8]", strsplit("./input/foo.c\3", "")[[1]])
globAlloca("@__PRETTY_FUNCTION__.foobar", "[22 x i8]", strsplit("void foobar(int, int)\3", "")[[1]])
globAlloca("@__PRETTY_FUNCTION__.foobar1", "[23 x i8]", strsplit("void foobar1(int, int)\3", "")[[1]])

rm(list = setdiff(ls(), lsf.str()))
sym <- env()
global <- env()
typ <- env()
globAlloca <- make.ga()
# pointer5.ll:
# @.str = private unnamed_addr constant [27 x i8] c"The value of pointer is %u\00", align 1
globAlloca("@.str", "[27 x i8]", strsplit("The value of pointer is %u\3", "")[[1]])

rm(list = setdiff(ls(), lsf.str()))
sym <- env()
global <- env()
typ <- env()
globAlloca <- make.ga()
# @.str = private unnamed_addr constant [6 x i8] c"hello\00", align 1
# @x = dso_local global i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str, i32 0, i32 0), align 8
globAlloca("@.str", "[6 x i8]", strsplit("hello\3", "")[[1]])
globAlloca("@x", "i8*", gep("[6 x i8]", sym$".str", 0, 0))

