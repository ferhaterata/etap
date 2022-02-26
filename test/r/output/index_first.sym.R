rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
# load libraries
options("StartupBanner" = "off")
library("distr")
library("rlang") # required for environment functions

#max loop number(less than or equal to)
max_loop <- 5

index_first.entry <- list(
  name = "entry",
  insts = list(
    "p.nums <- alloca(\"array\")",
    "p.n <- alloca(\"int\")",
    "p.0 <- bitcast(p.nums)",
    "memcpy(p.0, ptr(c.__const.index_first.nums))",
    "p.arrayidx <- gep(p.nums, 2)",
    "v.1 <- load(p.arrayidx)",
    "v.add <- add(v.1, 2)",
    "store(v.add, p.n)",
    "v.2 <- load(p.n)",
    "ret(v.2) ; entry <- T"))

preds <- list(list())
names(preds) <- c(index_first.entry$name)

succs <- list(list())
names(succs) <- c(index_first.entry$name)

edge_global <- as.list(rep(0, 0))
edge_local <- as.list(rep(0, 0))
edge_visited <- as.list(rep(0, 0))
names(edge_global) <- c()
names(edge_local) <- c()
names(edge_visited) <- c()

freq <- as.list(rep("0", 1))
names(freq) <- c(index_first.entry$name)

visited <- as.list(rep(0, 1))
names(visited) <- c(index_first.entry$name)

color <- as.list(rep("white", 1))
names(color) <- c(index_first.entry$name)

total_visit <- as.list(rep(0, 1))
names(total_visit) <- c(index_first.entry$name)

index_first <- list(
  name = "index_first",
  formals = list(""),
  initials = list("entry <- F"),
  globals = list("c.__const.index_first.nums <- env(\"0\" = 1, \"1\" = 2, \"2\" = 3)"),
  blocks = list(index_first.entry))

# Create output file
profile <- paste0(".output/", index_first$name, ".profile")
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
eval(parse(text = index_first$globals), envir = env)
eval(parse(text = index_first$formals), envir = env)
eval(parse(text = index_first$initials), envir = env)
source("test/r/output/meta.R", local = env)
# run the machine
DFS(list(), index_first$blocks[[1]], "", "1", visited, edge_visited, env)

prob_global_file <- paste0(".output/", index_first$name, ".global.prob")
file.create(prob_global_file, showWarnings = FALSE, recursive = TRUE)
for (i in seq_along(edge_global)) {
  p <- eval(parse(text = edge_global[i]))
  line <- paste0(names(edge_global)[i], ": [", edge_local[[i]], "] = ", p)
  write(line, file = prob_global_file, append = TRUE)
  #print(line)
}

prob_local_file <- paste0(".output/", index_first$name, ".local.prob")
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

freq_file <- paste0(".output/", index_first$name, ".freq")
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
