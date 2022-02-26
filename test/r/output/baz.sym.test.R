rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
# load libraries
options("StartupBanner" = "off")
library("distr")
library("rlang") # required for environment functions

#max loop number
max_loop <- 5

baz.entry <- list(
  name = "entry",
  insts = list(
    "retval.i <- DiscreteDistribution(0.000000e+00)",
    "x.addr.i <- DiscreteDistribution(0.000000e+00)",
    "y.addr.i <- DiscreteDistribution(0.000000e+00)",
    "a.i <- DiscreteDistribution(0.000000e+00)",
    "x.addr <- DiscreteDistribution(0.000000e+00)",
    "y.addr <- DiscreteDistribution(0.000000e+00)",
    "z <- DiscreteDistribution(0.000000e+00)",
    "i <- DiscreteDistribution(0)",
    "x.addr <- x",
    "y.addr <- y",
    "z <- DiscreteDistribution(0.000000e+00)",
    "i <- DiscreteDistribution(1)",
    "entry_for.cond <- 1.00; entry <- T"))

baz.for.cond <- list(
  name = "for.cond",
  insts = list(
    "v0 <- i",
    "cmp <- v0 - 3; cmp <- p(cmp)(-1)",
    "for.cond_for.body <- round(cmp, 2); for.cond_for.end <- round(1 - cmp, 2); for.cond <- T; for.inc <- F; entry <- F"))

baz.for.body <- list(
  name = "for.body",
  insts = list(
    "v1 <- x.addr",
    "v2 <- y.addr",
    "x.addr.i <- v1",
    "y.addr.i <- v2",
    "v3 <- x.addr.i",
    "v4 <- y.addr.i",
    "add.i <- v4 + 6.000000e+00",
    "cmp.i <- v3 - add.i; cmp.i <- p(cmp.i)(-0.01)",
    "for.body_if.then.i <- round(cmp.i, 2); for.body_if.end4.i <- round(1 - cmp.i, 2); for.body <- T; for.cond <- F"))

baz.if.then.i <- list(
  name = "if.then.i",
  insts = list(
    "v5 <- y.addr.i",
    "mul.i <- 2.000000e+00 * v5",
    "a.i <- mul.i",
    "v6 <- a.i",
    "cmp1.i <- v6 - -2.000000e+00; cmp1.i <- 1 - p(cmp1.i)(0.01)",
    "if.then.i_if.then2.i <- round(cmp1.i, 2); if.then.i_if.end.i <- round(1 - cmp1.i, 2); if.then.i <- T; for.body <- F"))

baz.if.then2.i <- list(
  name = "if.then2.i",
  insts = list(
    "v7 <- x.addr.i",
    "v8 <- y.addr.i",
    "mul3.i <- v7 * v8",
    "retval.i <- mul3.i",
    "if.then2.i_foo.exit <- 1.00; if.then2.i <- T; if.then.i <- F"))

baz.if.end.i <- list(
  name = "if.end.i",
  insts = list(
    "if.end.i_if.end4.i <- 1.00; if.end.i <- T; if.then.i <- F"))

baz.if.end4.i <- list(
  name = "if.end4.i",
  insts = list(
    "v9 <- x.addr.i",
    "retval.i <- v9",
    "if.end4.i_foo.exit <- 1.00; if.end4.i <- T; if.end.i <- F; for.body <- F"))

baz.foo.exit <- list(
  name = "foo.exit",
  insts = list(
    "v10 <- retval.i",
    "v11 <- z",
    "add <- v11 + v10",
    "z <- add",
    "foo.exit_for.inc <- 1.00; foo.exit <- T; if.end4.i <- F; if.then2.i <- F"))

baz.for.inc <- list(
  name = "for.inc",
  insts = list(
    "v12 <- i",
    "inc <- v12 + 1",
    "i <- inc",
    "for.inc_for.cond <- 1.00; for.inc <- T; foo.exit <- F"))

baz.for.end <- list(
  name = "for.end",
  insts = list(
    "v13 <- z",
    "ret <- v13; for.end <- T; for.cond <- F"))

preds <- list(list(), list(baz.for.inc, baz.entry), list(baz.for.cond), list(baz.for.body), list(baz.if.then.i), list(baz.if.then.i), list(baz.if.end.i, baz.for.body), list(baz.if.end4.i, baz.if.then2.i), list(baz.foo.exit), list(baz.for.cond))
names(preds) <- c(baz.entry$name, baz.for.cond$name, baz.for.body$name, baz.if.then.i$name, baz.if.then2.i$name, baz.if.end.i$name, baz.if.end4.i$name, baz.foo.exit$name, baz.for.inc$name, baz.for.end$name)

succs <- list(list(baz.for.cond), list(baz.for.body, baz.for.end), list(baz.if.then.i, baz.if.end4.i), list(baz.if.then2.i, baz.if.end.i), list(baz.foo.exit), list(baz.if.end4.i), list(baz.foo.exit), list(baz.for.inc), list(baz.for.cond), list())
names(succs) <- c(baz.entry$name, baz.for.cond$name, baz.for.body$name, baz.if.then.i$name, baz.if.then2.i$name, baz.if.end.i$name, baz.if.end4.i$name, baz.foo.exit$name, baz.for.inc$name, baz.for.end$name)

edge <- as.list(rep(0, 12))
names(edge) <- c("entry#for.cond", "for.cond#for.body", "for.cond#for.end", "for.body#if.then.i", "for.body#if.end4.i", "if.then.i#if.then2.i", "if.then.i#if.end.i", "if.then2.i#foo.exit", "if.end.i#if.end4.i", "if.end4.i#foo.exit", "foo.exit#for.inc", "for.inc#for.cond")

freq <- as.list(rep("0", 10))
names(freq) <- c(baz.entry$name, baz.for.cond$name, baz.for.body$name, baz.if.then.i$name, baz.if.then2.i$name, baz.if.end.i$name, baz.if.end4.i$name, baz.foo.exit$name, baz.for.inc$name, baz.for.end$name)

visited <- as.list(rep(0, 10))
names(visited) <- c(baz.entry$name, baz.for.cond$name, baz.for.body$name, baz.if.then.i$name, baz.if.then2.i$name, baz.if.end.i$name, baz.if.end4.i$name, baz.foo.exit$name, baz.for.inc$name, baz.for.end$name)

color <- as.list(rep("white", 10))
names(color) <- c(baz.entry$name, baz.for.cond$name, baz.for.body$name, baz.if.then.i$name, baz.if.then2.i$name, baz.if.end.i$name, baz.if.end4.i$name, baz.foo.exit$name, baz.for.inc$name, baz.for.end$name)

total_visit <- as.list(rep(0, 10))
names(total_visit) <- c(baz.entry$name, baz.for.cond$name, baz.for.body$name, baz.if.then.i$name, baz.if.then2.i$name, baz.if.end.i$name, baz.if.end4.i$name, baz.foo.exit$name, baz.for.inc$name, baz.for.end$name)

baz <- list(
  name = "baz",
  formals = list("x <- Norm(mean=11, sd=1); y <- Norm(mean=5, sd=1)"),
  initials = list("entry <- F; for.cond <- F; for.body <- F; if.then.i <- F; if.then2.i <- F; if.end.i <- F; if.end4.i <- F; foo.exit <- F; for.inc <- F; for.end <- F"),
  blocks = list(baz.entry, baz.for.cond, baz.for.body, baz.if.then.i, baz.if.then2.i, baz.if.end.i, baz.if.end4.i, baz.foo.exit, baz.for.inc, baz.for.end))

# Create output file
profile <- paste0(".output/", baz$name, ".profile")
file.create(profile, showWarnings = FALSE, recursive = TRUE)

DFS <- function(prev, v, path, prob, visited, env) {
  #  mark v visited
  visited[[v$name]] <- visited[[v$name]] + 1
  total_visit[[v$name]] <<- total_visit[[v$name]] + 1
  color[v$name] <<- "gray"
  # add blockname to the path
  path <- paste0(path, "%", v$name)
  # execute block's instructions
  for (inst in v$insts) {
    eval(parse(text = inst), envir = env)
  }
  # eval path probability
  if (length(prev)) {
    expr <- paste0(prev$name, "_", v$name)
    value <- eval(parse(text = expr), envir = env)
    out <- paste0(prev$name, "#", v$name)
    edge[out] <<- value
    # print(paste0(out, " = ", value))
    prob <- paste0(prob, "*", value)
  }
  # for each successor v' of v { fs
  for (i in seq_along(succs[[v$name]])) {
    # if v' not yet visited and prob is greater than 0 {
    if (length(succs[[v$name]][[i]])) {
      expr <- paste0(v$name, "_", succs[[v$name]][[i]]$name)
      value <- eval(parse(text = expr), envir = env)
      if (value > 0 && all(visited < max_loop)) {
        # if (i == 1) clone <- env # to be more efficient
        # else
        clone <- env_clone(env) # don't create unnecessary environments.
        DFS(v, succs[[v$name]][[i]], path, prob, visited, clone)
      }
    }
  }
  #
  color[v$name] <<- "black"
  if (!length(succs[[v$name]])) {
    line <- paste0(path, ":", prob, "=", eval(parse(text = prob), envir = env))
    write(line, file = profile, append = TRUE)
    for (i in seq_along(visited)) {
      if (visited[[i]] != 0) {
        # collect frequency as percentage
        freq[names(visited)[i]] <<- paste0(freq[names(visited)[i]], "+", eval(parse(text = prob)))
      }
    }
    #print(line)
    #print("visited:")
    #for (i in seq_along(visited)) {
    #  print(paste0(names(visited)[i], " = ", eval(parse(text = freq[names(visited)[i]]))))
    #}
  }
}

env <- env()
# eval function parameters
eval(parse(text = baz$formals), envir = env)
eval(parse(text = baz$initials), envir = env)
# run the machine
DFS(list(), baz$blocks[[1]], "", "1", visited, env)

prob_file <- paste0(".output/", baz$name, ".prob")
file.create(prob_file, showWarnings = FALSE, recursive = TRUE)
for (i in seq_along(edge)) {
  line <- paste0(names(edge)[i], " = ", edge[i])
  write(line, file = prob_file, append = TRUE)
  #print(line)
}

freq_file <- paste0(".output/", baz$name, ".freq")
file.create(freq_file, showWarnings = FALSE, recursive = TRUE)
for (i in seq_along(freq)) {
  f <- eval(parse(text = freq[i]))
  line <- paste0(names(freq)[i], ": [", freq[i], "] = ", f)
  write(line, file = freq_file, append = TRUE)
  #print(line)
}

#for (i in seq_along(color)) {
#  print(paste0(names(color)[i], " = ", color[i]))
#}
