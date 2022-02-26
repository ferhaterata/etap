rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
# load libraries
options("StartupBanner" = "off")
library("distr")
library("rlang") # required for environment functions

#max loop number(less than or equal to)
max_loop <- 6

bar.entry <- list(
  name = "entry",
  insts = list(
    "retval <- 0",
    "x.addr <- 0",
    "y.addr <- 0",
    "a <- 0",
    "x.addr <- x",
    "y.addr <- y",
    "v0 <- x.addr",
    "v1 <- y.addr",
    "add <- v1 + 6",
    "cmp <- v0 - add; if (is.numeric(cmp)) cmp <- DiscreteDistribution(cmp); cmp <- p(cmp)(-1)",
    "entry_if.then <- round(cmp, 2); entry_if.end4 <- round(1 - cmp, 2); entry <- T"))

bar.if.then <- list(
  name = "if.then",
  insts = list(
    "v2 <- y.addr",
    "mul <- 2 * v2",
    "a <- mul",
    "v3 <- a",
    "cmp1 <- v3 - 8; if (is.numeric(cmp1)) cmp1 <- DiscreteDistribution(cmp1); cmp1 <- 1 - p(cmp1)(0)",
    "if.then_if.then2 <- round(cmp1, 2); if.then_if.end <- round(1 - cmp1, 2); if.then <- T; entry <- F"))

bar.if.then2 <- list(
  name = "if.then2",
  insts = list(
    "v4 <- x.addr",
    "v5 <- y.addr",
    "mul3 <- v4 * v5",
    "retval <- mul3",
    "if.then2_return <- 1.00; if.then2 <- T; if.then <- F"))

bar.if.end <- list(
  name = "if.end",
  insts = list(
    "if.end_if.end4 <- 1.00; if.end <- T; if.then <- F"))

bar.if.end4 <- list(
  name = "if.end4",
  insts = list(
    "v6 <- x.addr",
    "retval <- v6",
    "if.end4_return <- 1.00; if.end4 <- T; if.end <- F; entry <- F"))

bar.return <- list(
  name = "return",
  insts = list(
    "v7 <- retval",
    "ret <- v7; return <- T; if.end4 <- F; if.then2 <- F"))

preds <- list(list(), list(bar.entry), list(bar.if.then), list(bar.if.then), list(bar.if.end, bar.entry), list(bar.if.end4, bar.if.then2))
names(preds) <- c(bar.entry$name, bar.if.then$name, bar.if.then2$name, bar.if.end$name, bar.if.end4$name, bar.return$name)

succs <- list(list(bar.if.then, bar.if.end4), list(bar.if.then2, bar.if.end), list(bar.return), list(bar.if.end4), list(bar.return), list())
names(succs) <- c(bar.entry$name, bar.if.then$name, bar.if.then2$name, bar.if.end$name, bar.if.end4$name, bar.return$name)

edge_global <- as.list(rep(0, 7))
edge_local <- as.list(rep(0, 7))
edge_visited <- as.list(rep(0, 7))
names(edge_global) <- c("entry#if.then", "entry#if.end4", "if.then#if.then2", "if.then#if.end", "if.then2#return", "if.end#if.end4", "if.end4#return")
names(edge_local) <- c("entry#if.then", "entry#if.end4", "if.then#if.then2", "if.then#if.end", "if.then2#return", "if.end#if.end4", "if.end4#return")
names(edge_visited) <- c("entry#if.then", "entry#if.end4", "if.then#if.then2", "if.then#if.end", "if.then2#return", "if.end#if.end4", "if.end4#return")

freq <- as.list(rep("0", 6))
names(freq) <- c(bar.entry$name, bar.if.then$name, bar.if.then2$name, bar.if.end$name, bar.if.end4$name, bar.return$name)

visited <- as.list(rep(0, 6))
names(visited) <- c(bar.entry$name, bar.if.then$name, bar.if.then2$name, bar.if.end$name, bar.if.end4$name, bar.return$name)

color <- as.list(rep("white", 6))
names(color) <- c(bar.entry$name, bar.if.then$name, bar.if.then2$name, bar.if.end$name, bar.if.end4$name, bar.return$name)

total_visit <- as.list(rep(0, 6))
names(total_visit) <- c(bar.entry$name, bar.if.then$name, bar.if.then2$name, bar.if.end$name, bar.if.end4$name, bar.return$name)

bar <- list(
  name = "bar",
  formals = list("x <- DiscreteDistribution(supp = 10:11); y <- DiscreteDistribution(supp = 2:7)"),
  initials = list("entry <- F; if.then <- F; if.then2 <- F; if.end <- F; if.end4 <- F; return <- F"),
  blocks = list(bar.entry, bar.if.then, bar.if.then2, bar.if.end, bar.if.end4, bar.return))

# Create output file
profile <- paste0(".output/", bar$name, ".profile")
file.create(profile, showWarnings = FALSE, recursive = TRUE)

DFS <- function(prev, v, path, prob, visited, edge_visited, env) {
  #  mark v visited
  visited[[v$name]] <- visited[[v$name]] + 1
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
    edge_visited[[out]] <- edge_visited[[out]] + 1
    # print(paste0(out, " = ", value))
    prob <- paste0(prob, "*", value)
  }
  # for each successor v' of v { fs
  for (i in seq_along(succs[[v$name]])) {
    # if v' not yet visited and prob is greater than 0 {
    if (length(succs[[v$name]][[i]])) {
      expr <- paste0(v$name, "_", succs[[v$name]][[i]]$name)
      value <- eval(parse(text = expr), envir = env)
      if (value > 0 && all(visited <= max_loop)) {
        # if (i == 1) clone <- env # to be more efficient
        # else
        clone <- env_clone(env) # don't create unnecessary environments.
        DFS(v, succs[[v$name]][[i]], path, prob, visited, edge_visited, clone)
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
        total_visit[[names(visited)[i]]] <<- total_visit[[names(visited)[i]]] + visited[[i]]
      }
    }
    for (i in seq_along(edge_visited)) {
      if (edge_visited[[i]] != 0) {
        edge_global[i] <<- paste0(edge_global[i], "+", eval(parse(text = prob)))
        edge_local[[i]] <<- edge_local[[i]] + edge_visited[[i]]
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
eval(parse(text = bar$formals), envir = env)
eval(parse(text = bar$initials), envir = env)
# run the machine
DFS(list(), bar$blocks[[1]], "", "1", visited, edge_visited, env)

prob_global_file <- paste0(".output/", bar$name, ".global.prob")
file.create(prob_global_file, showWarnings = FALSE, recursive = TRUE)
for (i in seq_along(edge_global)) {
  p <- eval(parse(text = edge_global[i]))
  line <- paste0(names(edge_global)[i], ": [", edge_local[[i]], "] = ", p)
  write(line, file = prob_global_file, append = TRUE)
  #print(line)
}

prob_local_file <- paste0(".output/", bar$name, ".local.prob")
file.create(prob_local_file, showWarnings = FALSE, recursive = TRUE)
for (i in seq_along(edge_local)) {
  edge_name <- names(edge_local)[i] # edge's name
  block <- unlist(strsplit(edge_name, "#"))[1] # block's name
  if (total_visit[[block]] != 0)
    p <- edge_local[[i]] / total_visit[[block]]
  else
    p <- edge_local[[i]]
  line <- paste0(edge_name, ": [", edge_local[i], "] = ", p)
  write(line, file = prob_local_file, append = TRUE)
  #print(line)
}

freq_file <- paste0(".output/", bar$name, ".freq")
file.create(freq_file, showWarnings = FALSE, recursive = TRUE)
for (i in seq_along(freq)) {
  f <- eval(parse(text = freq[i]))
  line <- paste0(names(freq)[i], ": [", total_visit[[i]], "] = ", f)
  write(line, file = freq_file, append = TRUE)
  #print(line)
}

#for (i in seq_along(color)) {
#  print(paste0(names(color)[i], " = ", color[i]))
#}
