rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
# load libraries
options("StartupBanner" = "off")
options(expressions = 500000) #increase the limit on the number of nested expressions that will be evaluated
library("distr")
library("rlang") # required for environment functions
#max loop number(less than or equal to)
max_loop <- 1000000

block.entry <- env(
  name = "entry",
  preds = list(),
  succs = list("for.cond"),
  insts = list(
    "p.x.addr <- alloca(\"int\")",
    "p.result <- alloca(\"int\")",
    "p.i <- alloca(\"int\")",
    "store(x, p.x.addr)",
    "store(0, p.result)",
    "store(0, p.i)",
    "br(quote(for.cond))"))

block.for.cond <- env(
  name = "for.cond",
  preds = list("for.inc", "entry"),
  succs = list("for.body", "for.end"),
  insts = list(
    "v.0 <- load(p.i)",
    "v.1 <- load(p.x.addr)",
    "v.cmp <- icmp(sle, v.0, v.1)",
    "br(quote(for.body), quote(for.end), v.cmp)"))

block.for.body <- env(
  name = "for.body",
  preds = list("for.cond"),
  succs = list("for.inc"),
  insts = list(
    "v.2 <- load(p.result)",
    "v.3 <- load(p.i)",
    "v.add <- add(v.2, v.3)",
    "store(v.add, p.result)",
    "br(quote(for.inc))"))

block.for.inc <- env(
  name = "for.inc",
  preds = list("for.body"),
  succs = list("for.cond"),
  insts = list(
    "v.4 <- load(p.i)",
    "v.inc <- add(v.4, 1)",
    "store(v.inc, p.i)",
    "br(quote(for.cond))"))

block.for.end <- env(
  name = "for.end",
  preds = list("for.cond"),
  succs = list(),
  insts = list(
    "v.5 <- load(p.result)",
    "path.return <<- c(path.return, ret(v.5)); for.end <- T; for.cond <- F"))

preds <- list(list(), list(block.for.inc, block.entry), list(block.for.cond), list(block.for.body), list(block.for.cond))
names(preds) <- c(block.entry$name, block.for.cond$name, block.for.body$name, block.for.inc$name, block.for.end$name)

succs <- list(list(block.for.cond), list(block.for.body, block.for.end), list(block.for.inc), list(block.for.cond), list())
names(succs) <- c(block.entry$name, block.for.cond$name, block.for.body$name, block.for.inc$name, block.for.end$name)

edge_global <- as.list(rep(0, 5))
edge_local <- as.list(rep(0, 5))
edge_visited <- as.list(rep(0, 5))
names(edge_global) <- c("entry#for.cond", "for.cond#for.body", "for.cond#for.end", "for.body#for.inc", "for.inc#for.cond")
names(edge_local) <- c("entry#for.cond", "for.cond#for.body", "for.cond#for.end", "for.body#for.inc", "for.inc#for.cond")
names(edge_visited) <- c("entry#for.cond", "for.cond#for.body", "for.cond#for.end", "for.body#for.inc", "for.inc#for.cond")

freq <- as.list(rep("0", 5))
names(freq) <- c(block.entry$name, block.for.cond$name, block.for.body$name, block.for.inc$name, block.for.end$name)

visited <- as.list(rep(0, 5))
names(visited) <- c(block.entry$name, block.for.cond$name, block.for.body$name, block.for.inc$name, block.for.end$name)

color <- as.list(rep("white", 5))
names(color) <- c(block.entry$name, block.for.cond$name, block.for.body$name, block.for.inc$name, block.for.end$name)

total_visit <- as.list(rep(0, 5))
names(total_visit) <- c(block.entry$name, block.for.cond$name, block.for.body$name, block.for.inc$name, block.for.end$name)

.function <- list(
  name = "sum",
  formals = list("x <- DiscreteDistribution(supp = 0:100)"),
  initials = list("entry <- F; for.cond <- F; for.body <- F; for.inc <- F; for.end <- F"),
  globals = list(),
  blocks = list(block.entry, block.for.cond, block.for.body, block.for.inc, block.for.end))

# Create output file
profile <- paste0(".output/", .function$name, ".profile")
file.create(profile, showWarnings = FALSE, recursive = TRUE)


library("dequer")

DFS <- function(prev, v, path, prob, visited, edge_visited, env) {
  nodes <- stack()
  push(nodes, list(prev, v, path, prob, visited, edge_visited, env))
  while (length(nodes)) {
    e <- pop(nodes)
    prev <- e[[1]]; v <- e[[2]]; path <- e[[3]]; prob <- e[[4]];
    visited <- e[[5]]; edge_visited <- e[[6]]; env <- e[[7]]
    #  mark v visited
    visited[[v$name]] <- visited[[v$name]] + 1
    color[v$name] <<- "gray"
    # add blockname to the path
    path <- paste0(path, "%", v$name)
    # initialize current block
    .block <<- v
    # execute block's instructions
    for (inst in v$insts) {
      eval(parse(text = inst), envir = env)
    }
    if (length(prev)) {
      expr <- paste0(prev$name, "_", v$name)
      value <- eval(parse(text = expr), envir = env)
      out <- paste0(prev$name, "#", v$name)
      edge_visited[[out]] <- edge_visited[[out]] + 1
      # print(paste0(out, " = ", value))
      prob <- paste0(prob, "*", value)
    }
    for (i in seq_along(succs[[v$name]])) {
      # if v' not yet visited and prob is greater than 0 {
      if (length(succs[[v$name]][[i]])) {
        expr <- paste0(v$name, "_", succs[[v$name]][[i]]$name)
        value <- eval(parse(text = expr), envir = env)
        if (value > 0 && all(visited <= max_loop)) {
          # if (i == 1) clone <- env # to be more efficient
          # else
          clone <- env_clone(env) # don't create unnecessary environments.
          push(nodes, list(v, succs[[v$name]][[i]], path, prob, visited, edge_visited, clone))
        }
      }
    }
    color[v$name] <<- "black"
    if (!length(succs[[v$name]])) {
      p <- eval(parse(text = prob), envir = env)
      path.prob <<- c(path.prob, round(p, 5))
      line <- paste0(path, ":", prob, "=", p)
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
    }
  }
}

path.return <- vector()
path.prob <- vector()

.block <- env()
env <- env()
# eval function parameters
eval(parse(text = .function$globals), envir = env)
eval(parse(text = .function$formals), envir = env)
eval(parse(text = .function$initials), envir = env)
source(".output/meta.R", local = env)
# run the machine
system.time(DFS(list(), .function$blocks[[1]], "", "1", visited, edge_visited, env))

prob_global_file <- paste0(".output/", .function$name, ".global.prob")
file.create(prob_global_file, showWarnings = FALSE, recursive = TRUE)
for (i in seq_along(edge_global)) {
  p <- eval(parse(text = edge_global[i]))
  line <- paste0(names(edge_global)[i], ": [", edge_local[[i]], "] = ", p)
  write(line, file = prob_global_file, append = TRUE)
  #print(line)
}

prob_local_file <- paste0(".output/", .function$name, ".local.prob")
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

freq_file <- paste0(".output/", .function$name, ".freq")
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

sum(path.prob)
sum(path.prob) > 1 + .Machine$double.eps
opar <- par()
path.return.mixture <- distr::UnivarMixingDistribution(Dlist = path.return, mixCoeff = path.prob)
returnPlot <- paste0(".dots/return/", .function$name, ".svg")
dir.create(dirname(returnPlot), showWarnings = FALSE, recursive = TRUE)
svg(returnPlot, width = 10.5, height = 3.5)
plot(path.return.mixture, to.draw.arg = c("d", "p", "q"), bty = "7",
     panel.first = grid(lwd = 1), lwd = 1, vertical = FALSE,
     col.points = c("red", "black"), cex.points = 1.8,
     inner = list(
       paste("Probability Function of", .function$name),
       paste("CDF of", .function$name),
       paste("Quantile Function of", .function$name)),
)
suppressWarnings(par(opar))
dev.off()
browseURL(paste0('file://', file.path(getwd(), returnPlot)))

