rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
# load libraries
options("StartupBanner" = "off")
library("distr")
library("rlang") # required for environment functions

#max loop number
max_loop <- 6

factorial.entry <- list(
  name = "entry",
  insts = list(
    "x.addr <- 0",
    "result <- 0",
    "i <- 0",
    "x.addr <- x",
    "result <- 1",
    "i <- 0",
    "entry_for.cond <- 1.00; entry <- T"))

factorial.for.cond <- list(
  name = "for.cond",
  insts = list(
    "v0 <- i",
    "v1 <- x.addr",
    "cmp <- v0 - v1; if (is.numeric(cmp)) cmp <- DiscreteDistribution(cmp); cmp <- p(cmp)(-1)",
    "for.cond_for.body <- round(cmp, 2); for.cond_for.end <- round(1 - cmp, 2); for.cond <- T; for.inc <- F; entry <- F"))

factorial.for.body <- list(
  name = "for.body",
  insts = list(
    "v2 <- x.addr",
    "v3 <- i",
    "sub <- v2 - v3",
    "v4 <- result",
    "mul <- v4 * sub * DiscreteDistribution(1)",
    "mul <- mul * DiscreteDistribution(1)",
    #"if (inherits(sub,\"AffLinDiscreteDistribution\")) sub <- new(\"DiscreteDistribution\", supp=sub@support, .withSim=T); mul <- v4 * sub; mul@.withSim <- T;",
    "result <- mul",
    "for.body_for.inc <- 1.00; for.body <- T; for.cond <- F"))

factorial.for.inc <- list(
  name = "for.inc",
  insts = list(
    "v5 <- i",
    "inc <- v5 + 1",
    "i <- inc",
    "for.inc_for.cond <- 1.00; for.inc <- T; for.body <- F"))

factorial.for.end <- list(
  name = "for.end",
  insts = list(
    "v6 <- result",
    "ret <- v6; for.end <- T; for.cond <- F"))

preds <- list(list(), list(factorial.for.inc, factorial.entry), list(factorial.for.cond), list(factorial.for.body), list(factorial.for.cond))
names(preds) <- c(factorial.entry$name, factorial.for.cond$name, factorial.for.body$name, factorial.for.inc$name, factorial.for.end$name)

succs <- list(list(factorial.for.cond), list(factorial.for.body, factorial.for.end), list(factorial.for.inc), list(factorial.for.cond), list())
names(succs) <- c(factorial.entry$name, factorial.for.cond$name, factorial.for.body$name, factorial.for.inc$name, factorial.for.end$name)

edge <- as.list(rep(0, 5))
names(edge) <- c("entry#for.cond", "for.cond#for.body", "for.cond#for.end", "for.body#for.inc", "for.inc#for.cond")

freq <- as.list(rep("0", 5))
names(freq) <- c(factorial.entry$name, factorial.for.cond$name, factorial.for.body$name, factorial.for.inc$name, factorial.for.end$name)

visited <- as.list(rep(0, 5))
names(visited) <- c(factorial.entry$name, factorial.for.cond$name, factorial.for.body$name, factorial.for.inc$name, factorial.for.end$name)

color <- as.list(rep("white", 5))
names(color) <- c(factorial.entry$name, factorial.for.cond$name, factorial.for.body$name, factorial.for.inc$name, factorial.for.end$name)

total_visit <- as.list(rep(0, 5))
names(total_visit) <- c(factorial.entry$name, factorial.for.cond$name, factorial.for.body$name, factorial.for.inc$name, factorial.for.end$name)

factorial <- list(
  name = "factorial",
  formals = list("x <- DiscreteDistribution(1:5)"),
  initials = list("entry <- F; for.cond <- F; for.body <- F; for.inc <- F; for.end <- F"),
  blocks = list(factorial.entry, factorial.for.cond, factorial.for.body, factorial.for.inc, factorial.for.end))

# Create output file
profile <- paste0(".output/", factorial$name, ".profile")
file.create(profile, showWarnings = FALSE, recursive = TRUE)

DFS <- function(prev, v, path, prob, visited, env) {
  #  mark v visited
  visited[[v$name]] <- visited[[v$name]] + 1
  total_visit[[v$name]] <<- total_visit[[v$name]] + 1
  color[v$name] <<- "gray"
  print(visited)
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
eval(parse(text = factorial$formals), envir = env)
eval(parse(text = factorial$initials), envir = env)
# run the machine
DFS(list(), factorial$blocks[[1]], "", "1", visited, env)

prob_file <- paste0(".output/", factorial$name, ".prob")
file.create(prob_file, showWarnings = FALSE, recursive = TRUE)
for (i in seq_along(edge)) {
  line <- paste0(names(edge)[i], " = ", edge[i])
  write(line, file = prob_file, append = TRUE)
  #print(line)
}

freq_file <- paste0(".output/", factorial$name, ".freq")
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
