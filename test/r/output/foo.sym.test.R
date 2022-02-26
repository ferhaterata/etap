rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
# load libraries
options("StartupBanner" = "off")
library("distr")
library("rlang") # required for environment functions

#max loop number
max_loop <- 5

foo.entry <- list(
  name = "entry",
  insts = list(
    "add <- y + 6.000000e+00",
    "cmp <- x - add; cmp <- p(cmp)(-0.01)",
    "entry_if.then <- round(cmp, 2); entry_if.end4 <- round(1 - cmp, 2); entry <- T"))

foo.if.then <- list(
  name = "if.then",
  insts = list(
    "mul <- 2.000000e+00 * y",
    "cmp1 <- mul - -2.000000e+00; cmp1 <- 1 - p(cmp1)(0.01)",
    "if.then_if.then2 <- round(cmp1, 2); if.then_if.end <- round(1 - cmp1, 2); if.then <- T; entry <- F"))

foo.if.then2 <- list(
  name = "if.then2",
  insts = list(
    "mul3 <- x * y",
    "if.then2_return <- 1.00; if.then2 <- T; if.then <- F"))

foo.if.end <- list(
  name = "if.end",
  insts = list(
    "if.end_if.end4 <- 1.00; if.end <- T; if.then <- F"))

foo.if.end4 <- list(
  name = "if.end4",
  insts = list(
    "if.end4_return <- 1.00; if.end4 <- T; if.end <- F; entry <- F"))

foo.return <- list(
  name = "return",
  insts = list(
    "retval.0 <- if (if.then2) mul3 else if (if.end4) x",
    "ret <- retval.0; return <- T; if.end4 <- F; if.then2 <- F"))

preds <- list(list(), list(foo.entry), list(foo.if.then), list(foo.if.then), list(foo.if.end, foo.entry), list(foo.if.end4, foo.if.then2))
names(preds) <- c(foo.entry$name, foo.if.then$name, foo.if.then2$name, foo.if.end$name, foo.if.end4$name, foo.return$name)

succs <- list(list(foo.if.then, foo.if.end4), list(foo.if.then2, foo.if.end), list(foo.return), list(foo.if.end4), list(foo.return), list())
names(succs) <- c(foo.entry$name, foo.if.then$name, foo.if.then2$name, foo.if.end$name, foo.if.end4$name, foo.return$name)

edge <- as.list(rep(0, 7))
names(edge) <- c("entry#if.then", "entry#if.end4", "if.then#if.then2", "if.then#if.end", "if.then2#return", "if.end#if.end4", "if.end4#return")

freq <- as.list(rep("0", 6))
names(freq) <- c(foo.entry$name, foo.if.then$name, foo.if.then2$name, foo.if.end$name, foo.if.end4$name, foo.return$name)

visited <- as.list(rep(0, 6))
names(visited) <- c(foo.entry$name, foo.if.then$name, foo.if.then2$name, foo.if.end$name, foo.if.end4$name, foo.return$name)

color <- as.list(rep("white", 6))
names(color) <- c(foo.entry$name, foo.if.then$name, foo.if.then2$name, foo.if.end$name, foo.if.end4$name, foo.return$name)

total_visit <- as.list(rep(0, 6))
names(total_visit) <- c(foo.entry$name, foo.if.then$name, foo.if.then2$name, foo.if.end$name, foo.if.end4$name, foo.return$name)

foo <- list(
  name = "foo",
  formals = list("x <- Norm(mean=11, sd=1); y <- Norm(mean=5, sd=1)"),
  initials = list("entry <- F; if.then <- F; if.then2 <- F; if.end <- F; if.end4 <- F; return <- F"),
  blocks = list(foo.entry, foo.if.then, foo.if.then2, foo.if.end, foo.if.end4, foo.return))

# Create output file
profile <- paste0(".output/", foo$name, ".profile")
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
eval(parse(text = foo$formals), envir = env)
eval(parse(text = foo$initials), envir = env)
# run the machine
DFS(list(), foo$blocks[[1]], "", "1", visited, env)

prob_file <- paste0(".output/", foo$name, ".prob")
file.create(prob_file, showWarnings = FALSE, recursive = TRUE)
for (i in seq_along(edge)) {
  line <- paste0(names(edge)[i], " = ", edge[i])
  write(line, file = prob_file, append = TRUE)
  #print(line)
}

freq_file <- paste0(".output/", foo$name, ".freq")
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
