rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
# load libraries
options("StartupBanner" = "off")
options(expressions = 500000) #increase the limit on the number of nested expressions that will be evaluated
library("distr")
library("rlang") # required for environment functions
distroptions("WarningArith" = FALSE)

#max loop number(less than or equal to)
max_loop <- 10000

block.entry <- env(
  name = "entry",
  preds = list(),
  succs = list("if.then", "if.end3"),
  insts = list(
    list("p.retval <- alloca(\"int\")", "nop", "E(alloca)", "T(alloca)"),
    list("p.n.addr <- alloca(\"int\")", "nop", "E(alloca)", "T(alloca)"),
    list("p.x <- alloca(\"int\")", "nop", "E(alloca)", "T(alloca)"),
    list("p.xp <- alloca(\"int*\")", "nop", "E(alloca)", "T(alloca)"),
    list("store(n, p.n.addr)", "nop", "E(store)", "T(store)"),
    list("v.0 <- load(p.n.addr)", "nop", "E(load)", "T(load)"),
    list("store(v.0, p.x)", "nop", "E(store)", "T(store)"),
    list("store(p.x, p.xp)", "nop", "E(store)", "T(store)"),
    list("v.1 <- load(p.n.addr)", "nop", "E(load)", "T(load)"),
    list("v.cmp <- icmp(sgt, v.1, 1)", "nop", "E(icmp)", "T(icmp)"),
    list("br(if.then, if.end3, v.cmp)", "{if (!is.numeric(v.1)) v.1 <- add(v.cmp, 1)};store(v.1, p.n.addr); ", "E(br)", "T(br)")))

block.if.then <- env(
  name = "if.then",
  preds = list("entry"),
  succs = list("if.then2", "if.end"),
  insts = list(
    list("if(entry) {v.cmp <- v.cmp.true; {if (!is.numeric(v.1)) v.1 <- add(v.cmp, 1)};store(v.1, p.n.addr); };", "nop", "0", "0"),
    list("v.2 <- load(p.n.addr)", "nop", "E(load)", "T(load)"),
    list("v.cmp1 <- icmp(sgt, v.2, 2)", "nop", "E(icmp)", "T(icmp)"),
    list("br(if.then2, if.end, v.cmp1)", "{if (!is.numeric(v.2)) v.2 <- add(v.cmp1, 2)};store(v.2, p.n.addr); ", "E(br)", "T(br)")))

block.if.then2 <- env(
  name = "if.then2",
  preds = list("if.then"),
  succs = list("return"),
  insts = list(
    list("if(if.then) {v.cmp1 <- v.cmp1.true; {if (!is.numeric(v.2)) v.2 <- add(v.cmp1, 2)};store(v.2, p.n.addr); };", "nop", "0", "0"),
    list("v.3 <- load(p.n.addr)", "nop", "E(load)", "T(load)"),
    list("store(v.3, p.retval)", "nop", "E(store)", "T(store)"),
    list("br(return)", "nop", "E(br)", "T(br)")))

block.if.end <- env(
  name = "if.end",
  preds = list("if.then"),
  succs = list("if.end3"),
  insts = list(
    list("if(if.then) {v.cmp1 <- v.cmp1.false; {if (!is.numeric(v.2)) v.2 <- add(v.cmp1, 2)};store(v.2, p.n.addr); };", "nop", "0", "0"),
    list("br(if.end3)", "nop", "E(br)", "T(br)")))

block.if.end3 <- env(
  name = "if.end3",
  preds = list("if.end", "entry"),
  succs = list("return"),
  insts = list(
    list("if(entry) {v.cmp <- v.cmp.false; {if (!is.numeric(v.1)) v.1 <- add(v.cmp, 1)};store(v.1, p.n.addr); };", "nop", "0", "0"),
    list("p.4 <- load(p.xp)", "nop", "E(load)", "T(load)"),
    list("v.5 <- load(p.4)", "nop", "E(load)", "T(load)"),
    list("store(v.5, p.retval)", "nop", "E(store)", "T(store)"),
    list("br(return)", "nop", "E(br)", "T(br)")))

block.return <- env(
  name = "return",
  preds = list("if.end3", "if.then2"),
  succs = list(),
  insts = list(
    list("v.6 <- load(p.retval)", "nop", "E(load)", "T(load)"),
    list("path.return <<- c(path.return, ret(v.6)); return <- TRUE; if.end3 <- FALSE; if.then2 <- FALSE", "nop", "E(ret)", "T(ret)")))

preds <- list(list(), list(block.entry), list(block.if.then), list(block.if.then), list(block.if.end, block.entry), list(block.if.end3, block.if.then2))
names(preds) <- c(block.entry$name, block.if.then$name, block.if.then2$name, block.if.end$name, block.if.end3$name, block.return$name)

succs <- list(list(block.if.then, block.if.end3), list(block.if.then2, block.if.end), list(block.return), list(block.if.end3), list(block.return), list())
names(succs) <- c(block.entry$name, block.if.then$name, block.if.then2$name, block.if.end$name, block.if.end3$name, block.return$name)

edge_global <- as.list(rep(0, 7))
edge_local <- as.list(rep(0, 7))
edge_visited <- as.list(rep(0, 7))
names(edge_global) <- c("entry#if.then", "entry#if.end3", "if.then#if.then2", "if.then#if.end", "if.then2#return", "if.end#if.end3", "if.end3#return")
names(edge_local) <- c("entry#if.then", "entry#if.end3", "if.then#if.then2", "if.then#if.end", "if.then2#return", "if.end#if.end3", "if.end3#return")
names(edge_visited) <- c("entry#if.then", "entry#if.end3", "if.then#if.then2", "if.then#if.end", "if.then2#return", "if.end#if.end3", "if.end3#return")

freq <- as.list(rep("0", 6))
names(freq) <- c(block.entry$name, block.if.then$name, block.if.then2$name, block.if.end$name, block.if.end3$name, block.return$name)

visited <- as.list(rep(0, 6))
names(visited) <- c(block.entry$name, block.if.then$name, block.if.then2$name, block.if.end$name, block.if.end3$name, block.return$name)

color <- as.list(rep("white", 6))
names(color) <- c(block.entry$name, block.if.then$name, block.if.then2$name, block.if.end$name, block.if.end3$name, block.return$name)

total_visit <- as.list(rep(0, 6))
names(total_visit) <- c(block.entry$name, block.if.then$name, block.if.then2$name, block.if.end$name, block.if.end3$name, block.return$name)

.function <- list(
  name = "conditional3",
  formals = list("n <- DiscreteDistribution(supp=1:4)"),
  initials = list("entry <- FALSE; if.then <- FALSE; if.then2 <- FALSE; if.end <- FALSE; if.end3 <- FALSE; return <- FALSE"),
  globals = list(),
  blocks = list(block.entry, block.if.then, block.if.then2, block.if.end, block.if.end3, block.return))

# Create output file
profile <- paste0(".output/", .function$name, ".profile")
file.create(profile, showWarnings = FALSE, recursive = TRUE)

library("dequer") # required for an efficient implementation of stack

DFS <- function(prev, v, path, prob, visited, edge_visited, env, t, e) {
  nodes <- stack()
  push(nodes, list(prev, v, path, prob, visited, edge_visited, env, t, e))
  while (length(nodes)) {
    node <- pop(nodes)
    prev <- node[[1]]; v <- node[[2]]; path <- node[[3]]; prob <- node[[4]];
    visited <- node[[5]]; edge_visited <- node[[6]]; env <- node[[7]]; t <- node[[8]]
    #  mark v visited
    visited[[v$name]] <- visited[[v$name]] + 1
    color[v$name] <<- "gray"
    # add blockname to the path
    path <- paste0(path, "%", v$name)
    # initialize current block
    .block <<- v
    # execute block's instructions
    for (inst in v$insts) {
      eval(parse(text = inst[1]), envir = env)
      e <- e + eval(parse(text = inst[3]), envir = env)
      t <- t + eval(parse(text = inst[4]), envir = env)
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
          clone <- rlang::env_clone(env) # don't create unnecessary envs.
          push(nodes, list(v, succs[[v$name]][[i]], path, prob, visited, edge_visited, clone, t, e))
        }
      }
    }
    #
    if (!length(succs[[v$name]])) {
      color[v$name] <<- "black"
      p <- eval(parse(text = prob), envir = env)
      path.prob <<- c(path.prob, p) # TODO: is rounding good here?
      if (is.numeric(t)) t <- distr::DiscreteDistribution(t)
      path.timing <<- c(path.timing, t)
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
path.energy <- vector()
path.timing <- vector()

.block <- env()
env <- env()
# eval function parameters
eval(parse(text = .function$globals), envir = env)
eval(parse(text = .function$formals), envir = env)
eval(parse(text = .function$initials), envir = env)
source("test/r/testing/meta.R", local = env)
source("test/r/testing/model.conf.R", local = env)
# run the machine
initial_t <- 0
initial_e <- 0
system.time(DFS(list(), .function$blocks[[1]], "", "1", visited, edge_visited, env, initial_t, initial_e))

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
# return plot
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

# timing plot
opar <- par()
path.timing.mixture <- distr::UnivarMixingDistribution(Dlist = path.timing, mixCoeff = path.prob)
timingPlot <- paste0(".dots/timing/", .function$name, ".svg")
dir.create(dirname(timingPlot), showWarnings = FALSE, recursive = TRUE)
svg(timingPlot, width = 10.5, height = 3.5)
plot(path.timing.mixture, to.draw.arg = c("d", "p", "q"), bty = "7",
     panel.first = grid(lwd = 1), lwd = 1, vertical = FALSE,
     col.points = c("red", "black"), cex.points = 1.8,
     inner = list(
       paste("Probability Function of", .function$name),
       paste("CDF of", .function$name),
       paste("Quantile Function of", .function$name)),
)
suppressWarnings(par(opar))
dev.off()
browseURL(paste0('file://', file.path(getwd(), timingPlot)))

