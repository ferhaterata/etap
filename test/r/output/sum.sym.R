rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
# load libraries
options("StartupBanner" = "off")
library("distr")
library("rlang") # required for environment functions

#max loop number(less than or equal to)
max_loop <- 6

sum.entry <- list(
  name = "entry",
  insts = list(
    "x.addr <- 0",
    "result <- 0",
    "i <- 0",
    "x.addr <- x",
    "result <- 1",
    "i <- 0",
    "entry_for.cond <- 1.00; entry <- T"))

sum.for.cond <- list(
  name = "for.cond",
  insts = list(
    "v0 <- i",
    "v1 <- x.addr",
    "cmp <- v0 - v1; if (is.numeric(cmp)) cmp <- DiscreteDistribution(cmp); cmp <- p(cmp)(-1)",
    "for.cond_for.body <- round(cmp, 2); for.cond_for.end <- round(1 - cmp, 2); for.cond <- T; for.inc <- F; entry <- F"))

sum.for.body <- list(
  name = "for.body",
  insts = list(
    "v2 <- x.addr",
    "v3 <- i",
    "add <- v2 + v3",
    "result <- add",
    "for.body_for.inc <- 1.00; for.body <- T; for.cond <- F"))

sum.for.inc <- list(
  name = "for.inc",
  insts = list(
    "v4 <- i",
    "inc <- v4 + 1",
    "i <- inc",
    "for.inc_for.cond <- 1.00; for.inc <- T; for.body <- F"))

sum.for.end <- list(
  name = "for.end",
  insts = list(
    "v5 <- result",
    "ret <- v5; for.end <- T; for.cond <- F"))

preds <- list(list(), list(sum.for.inc, sum.entry), list(sum.for.cond), list(sum.for.body), list(sum.for.cond))
names(preds) <- c(sum.entry$name, sum.for.cond$name, sum.for.body$name, sum.for.inc$name, sum.for.end$name)

succs <- list(list(sum.for.cond), list(sum.for.body, sum.for.end), list(sum.for.inc), list(sum.for.cond), list())
names(succs) <- c(sum.entry$name, sum.for.cond$name, sum.for.body$name, sum.for.inc$name, sum.for.end$name)

edge_global <- as.list(rep(0, 5))
edge_local <- as.list(rep(0, 5))
edge_visited <- as.list(rep(0, 5))
names(edge_global) <- c("entry#for.cond", "for.cond#for.body", "for.cond#for.end", "for.body#for.inc", "for.inc#for.cond")
names(edge_local) <- c("entry#for.cond", "for.cond#for.body", "for.cond#for.end", "for.body#for.inc", "for.inc#for.cond")
names(edge_visited) <- c("entry#for.cond", "for.cond#for.body", "for.cond#for.end", "for.body#for.inc", "for.inc#for.cond")

freq <- as.list(rep("0", 5))
names(freq) <- c(sum.entry$name, sum.for.cond$name, sum.for.body$name, sum.for.inc$name, sum.for.end$name)

visited <- as.list(rep(0, 5))
names(visited) <- c(sum.entry$name, sum.for.cond$name, sum.for.body$name, sum.for.inc$name, sum.for.end$name)

color <- as.list(rep("white", 5))
names(color) <- c(sum.entry$name, sum.for.cond$name, sum.for.body$name, sum.for.inc$name, sum.for.end$name)

total_visit <- as.list(rep(0, 5))
names(total_visit) <- c(sum.entry$name, sum.for.cond$name, sum.for.body$name, sum.for.inc$name, sum.for.end$name)

sum <- list(
  name = "sum",
  formals = list("x <- DiscreteDistribution(supp = 0:5)"),
  initials = list("entry <- F; for.cond <- F; for.body <- F; for.inc <- F; for.end <- F"),
  globals = list(""),
  blocks = list(sum.entry, sum.for.cond, sum.for.body, sum.for.inc, sum.for.end))

# Create output file
profile <- paste0(".output/", sum$name, ".profile")
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
eval(parse(text = sum$formals), envir = env)
eval(parse(text = sum$initials), envir = env)
# run the machine
DFS(list(), sum$blocks[[1]], "", "1", visited, edge_visited, env)

prob_global_file <- paste0(".output/", sum$name, ".global.prob")
file.create(prob_global_file, showWarnings = FALSE, recursive = TRUE)
for (i in seq_along(edge_global)) {
  p <- eval(parse(text = edge_global[i]))
  line <- paste0(names(edge_global)[i], ": [", edge_local[[i]], "] = ", p)
  write(line, file = prob_global_file, append = TRUE)
  #print(line)
}

prob_local_file <- paste0(".output/", sum$name, ".local.prob")
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

freq_file <- paste0(".output/", sum$name, ".freq")
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
