rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
# load libraries
options("StartupBanner" = "off")
options(expressions = 500000) #increase the limit on the number of nested expressions that will be evaluated
library("distr")
library("distrEx")
library("rlang") # required for environment functions
library(llvm)
distroptions("WarningArith" = FALSE)
set.seed(100)

# max loop number(less than or equal to)
max_loop <- 100000
restore.energy <- distr::Norm(11024.3, 30) # nj
restore.timing <- distr::Norm(8409.47, 0.01) # us


block.entry <- env(
  name = "entry",
  preds = list(),
  succs = list("checkpoint.1"),
  energy = "E(classify, entry)",
  timing = "T(classify, entry)",
  insts = list(
    list("sym$\"data.addr\" <- alloca(\"i16\")", "nop", "E(alloca)", "T(alloca)"),
    list("sym$\"result\" <- alloca(\"i16\")", "nop", "E(alloca)", "T(alloca)"),
    list("store(sym$\"data\", sym$\"data.addr\")", "nop", "E(store)", "T(store)"),
    list("store(-1, sym$\"result\")", "nop", "E(store)", "T(store)"),
    list("br(checkpoint.1)", "nop", "E(br)", "T(br)")))

block.checkpoint.1 <- env(
  name = "checkpoint.1",
  preds = list("entry"),
  succs = list("if.then", "if.else"),
  energy = "E(classify, checkpoint.1)",
  timing = "T(classify, checkpoint.1)",
  insts = list(
    list("checkpoint()", "nop", "E(call) + distr::Norm(14560, 20)", "T(call) + distr::Norm(8517.05, 0.01)"),
    list("sym$\"0\" <- load(sym$\"data.addr\")", "nop", "E(load)", "T(load)"),
    list("sym$\"cmp\" <- icmp(slt, sym$\"0\", 21)", "nop", "E(icmp)", "T(icmp)"),
    list("br(if.then, if.else, sym$\"cmp\")", "{if (is(sym$\"0\", \"Distribution\")) sym$\"0\" <- add(sym$\"cmp\", 21)};store(sym$\"0\", sym$\"data.addr\"); ", "E(br)", "T(br)")))

block.if.then <- env(
  name = "if.then",
  preds = list("checkpoint.1"),
  succs = list("checkpoint.2"),
  energy = "E(classify, if.then)",
  timing = "T(classify, if.then)",
  insts = list(
    list("if(checkpoint.1) {sym$\"cmp\" <- sym$\"cmp.true\"; {if (is(sym$\"0\", \"Distribution\")) sym$\"0\" <- add(sym$\"cmp\", 21)};store(sym$\"0\", sym$\"data.addr\"); };", "nop", "0", "0"),
    list("sym$\"1\" <- load(sym$\"data.addr\")", "nop", "E(load)", "T(load)"),
    list("store(1, sym$\"result\")", "nop", "E(store)", "T(store)"),
    list("br(checkpoint.2)", "nop", "E(br)", "T(br)")))

block.checkpoint.2 <- env(
  name = "checkpoint.2",
  preds = list("if.then"),
  succs = list("if.end4"),
  energy = "E(classify, checkpoint.2)",
  timing = "T(classify, checkpoint.2)",
  insts = list(
    list("checkpoint()", "nop", "E(call) + distr::Norm(14560, 20)", "T(call) + distr::Norm(8517.05, 0.01)"),
    list("br(if.end4)", "nop", "E(br)", "T(br)")))

block.if.else <- env(
  name = "if.else",
  preds = list("checkpoint.1"),
  succs = list("if.then2", "if.else3"),
  energy = "E(classify, if.else)",
  timing = "T(classify, if.else)",
  insts = list(
    list("if(checkpoint.1) {sym$\"cmp\" <- sym$\"cmp.false\"; {if (is(sym$\"0\", \"Distribution\")) sym$\"0\" <- add(sym$\"cmp\", 21)};store(sym$\"0\", sym$\"data.addr\"); };", "nop", "0", "0"),
    list("sym$\"2\" <- load(sym$\"data.addr\")", "nop", "E(load)", "T(load)"),
    list("sym$\"cmp1\" <- icmp(sgt, sym$\"2\", 27)", "nop", "E(icmp)", "T(icmp)"),
    list("br(if.then2, if.else3, sym$\"cmp1\")", "{if (is(sym$\"2\", \"Distribution\")) sym$\"2\" <- add(sym$\"cmp1\", 27)};store(sym$\"2\", sym$\"data.addr\"); ", "E(br)", "T(br)")))

block.if.then2 <- env(
  name = "if.then2",
  preds = list("if.else"),
  succs = list("checkpoint.3"),
  energy = "E(classify, if.then2)",
  timing = "T(classify, if.then2)",
  insts = list(
    list("if(if.else) {sym$\"cmp1\" <- sym$\"cmp1.true\"; {if (is(sym$\"2\", \"Distribution\")) sym$\"2\" <- add(sym$\"cmp1\", 27)};store(sym$\"2\", sym$\"data.addr\"); };", "nop", "0", "0"),
    list("store(0, sym$\"result\")", "nop", "E(store)", "T(store)"),
    list("br(checkpoint.3)", "nop", "E(br)", "T(br)")))

block.checkpoint.3 <- env(
  name = "checkpoint.3",
  preds = list("if.then2"),
  succs = list("if.end"),
  energy = "E(classify, checkpoint.3)",
  timing = "T(classify, checkpoint.3)",
  insts = list(
    list("checkpoint()", "nop", "E(call) + distr::Norm(14560, 20)", "T(call) + distr::Norm(8517.05, 0.01)"),
    list("br(if.end)", "nop", "E(br)", "T(br)")))

block.if.else3 <- env(
  name = "if.else3",
  preds = list("if.else"),
  succs = list("if.end"),
  energy = "E(classify, if.else3)",
  timing = "T(classify, if.else3)",
  insts = list(
    list("if(if.else) {sym$\"cmp1\" <- sym$\"cmp1.false\"; {if (is(sym$\"2\", \"Distribution\")) sym$\"2\" <- add(sym$\"cmp1\", 27)};store(sym$\"2\", sym$\"data.addr\"); };", "nop", "0", "0"),
    list("br(if.end)", "nop", "E(br)", "T(br)")))

block.if.end <- env(
  name = "if.end",
  preds = list("if.else3", "checkpoint.3"),
  succs = list("if.end4"),
  energy = "E(classify, if.end)",
  timing = "T(classify, if.end)",
  insts = list(
    list("br(if.end4)", "nop", "E(br)", "T(br)")))

block.if.end4 <- env(
  name = "if.end4",
  preds = list("if.end", "checkpoint.2"),
  succs = list(),
  energy = "E(classify, if.end4)",
  timing = "T(classify, if.end4)",
  insts = list(
    list("checkpoint()", "nop", "E(call) + distr::Norm(14560, 20)", "T(call) + distr::Norm(8517.05, 0.01)"),
    list("sym$\"3\" <- load(sym$\"result\")", "nop", "E(load)", "T(load)"),
    list("path.return <<- c(path.return, ret(sym$\"3\")); if.end4 <- TRUE; if.end <- FALSE; checkpoint.2 <- FALSE", "nop", "E(ret)", "T(ret)")))

preds <- list(list(), list(block.entry), list(block.checkpoint.1), list(block.if.then), list(block.checkpoint.1), list(block.if.else), list(block.if.then2), list(block.if.else), list(block.if.else3, block.checkpoint.3), list(block.if.end, block.checkpoint.2))
names(preds) <- c(block.entry$name, block.checkpoint.1$name, block.if.then$name, block.checkpoint.2$name, block.if.else$name, block.if.then2$name, block.checkpoint.3$name, block.if.else3$name, block.if.end$name, block.if.end4$name)

succs <- list(list(block.checkpoint.1), list(block.if.then, block.if.else), list(block.checkpoint.2), list(block.if.end4), list(block.if.then2, block.if.else3), list(block.checkpoint.3), list(block.if.end), list(block.if.end), list(block.if.end4), list())
names(succs) <- c(block.entry$name, block.checkpoint.1$name, block.if.then$name, block.checkpoint.2$name, block.if.else$name, block.if.then2$name, block.checkpoint.3$name, block.if.else3$name, block.if.end$name, block.if.end4$name)

edge_global <- as.list(rep(0, 11))
edge_local <- as.list(rep(0, 11))
edge_visited <- as.list(rep(0, 11))
names(edge_global) <- c("entry#checkpoint.1", "checkpoint.1#if.then", "checkpoint.1#if.else", "if.then#checkpoint.2", "checkpoint.2#if.end4", "if.else#if.then2", "if.else#if.else3", "if.then2#checkpoint.3", "checkpoint.3#if.end", "if.else3#if.end", "if.end#if.end4")
names(edge_local) <- c("entry#checkpoint.1", "checkpoint.1#if.then", "checkpoint.1#if.else", "if.then#checkpoint.2", "checkpoint.2#if.end4", "if.else#if.then2", "if.else#if.else3", "if.then2#checkpoint.3", "checkpoint.3#if.end", "if.else3#if.end", "if.end#if.end4")
names(edge_visited) <- c("entry#checkpoint.1", "checkpoint.1#if.then", "checkpoint.1#if.else", "if.then#checkpoint.2", "checkpoint.2#if.end4", "if.else#if.then2", "if.else#if.else3", "if.then2#checkpoint.3", "checkpoint.3#if.end", "if.else3#if.end", "if.end#if.end4")

freq <- as.list(rep("0", 10))
names(freq) <- c(block.entry$name, block.checkpoint.1$name, block.if.then$name, block.checkpoint.2$name, block.if.else$name, block.if.then2$name, block.checkpoint.3$name, block.if.else3$name, block.if.end$name, block.if.end4$name)

visited <- as.list(rep(0, 10))
names(visited) <- c(block.entry$name, block.checkpoint.1$name, block.if.then$name, block.checkpoint.2$name, block.if.else$name, block.if.then2$name, block.checkpoint.3$name, block.if.else3$name, block.if.end$name, block.if.end4$name)

color <- as.list(rep("white", 10))
names(color) <- c(block.entry$name, block.checkpoint.1$name, block.if.then$name, block.checkpoint.2$name, block.if.else$name, block.if.then2$name, block.checkpoint.3$name, block.if.else3$name, block.if.end$name, block.if.end4$name)

total_visit <- as.list(rep(0, 10))
names(total_visit) <- c(block.entry$name, block.checkpoint.1$name, block.if.then$name, block.checkpoint.2$name, block.if.else$name, block.if.then2$name, block.checkpoint.3$name, block.if.else3$name, block.if.end$name, block.if.end4$name)

.function <- list(
  name = "classify",
  formals = list("sym$\"data\" <- Mixing(Binom(40, 0.4), 15 + Binom(30, 0.6), mixCoeff = c(0.7, 0.3))"),
  initials = list("entry <- FALSE; checkpoint.1 <- FALSE; if.then <- FALSE; checkpoint.2 <- FALSE; if.else <- FALSE; if.then2 <- FALSE; checkpoint.3 <- FALSE; if.else3 <- FALSE; if.end <- FALSE; if.end4 <- FALSE"),
  globals = list(),
  types = list(),
  blocks = list(block.entry, block.checkpoint.1, block.if.then, block.checkpoint.2, block.if.else, block.if.then2, block.checkpoint.3, block.if.else3, block.if.end, block.if.end4))

# Capacitor Thresholds
min_cap <- 520200 #nj
max_cap <- 781250 #nj

# 1 mF capacitance 40 cm distance profile
harvesting_time <- 10000 # us

# Create output file
profile <- paste0(".output/", .function$name, ".profile")
file.create(profile, showWarnings = FALSE, recursive = TRUE)

clone <- function(env) {
  newenv <- rlang::env_clone(env)
  newenv$stack <- rlang::env_clone(env$stack)
  newenv$heap <- rlang::env_clone(env$heap)
  newenv$global <- rlang::env_clone(env$global)
  newenv$nv <- rlang::env_clone(env$nv)
  newenv$sym <- rlang::env_clone(env$sym)
  newenv$typ <- rlang::env_clone(env$typ)
  newenv$memptrs <- rlang::env_clone(env$memptrs)
  return(newenv)
}

library("dequer") # required for an efficient implementation of stack

DFS <- function(prev, v, path, prob, visited, edge_visited, env, t, e, p) {
  nodes <- stack()
  dequer::push(nodes, list(prev, v, path, prob, visited, edge_visited, env, t, e, p))
  while (length(nodes)) {
    node <- dequer::pop(nodes)
    prev <- node[[1]]; v <- node[[2]]; path <- node[[3]]; prob <- node[[4]];
    visited <- node[[5]]; edge_visited <- node[[6]]; env <- node[[7]]; t <- node[[8]]; p <- node[[10]]
    #  mark v visited
    visited[[v$name]] <- visited[[v$name]] + 1
    color[v$name] <<- "gray"
    # add blockname to the path
    path <- paste0(path, "%", v$name)
    # initialize current block
    .block <<- v
    cat(v$name, "\n")
    # eval path probability
    if (length(prev)) {
      expr <- paste0(prev$name, "_", v$name)
      value <- eval(parse(text = expr), envir = env)
      out <- paste0(prev$name, "#", v$name)
      edge_visited[[out]] <- edge_visited[[out]] + 1
      # print(paste0(out, " = ", value))
      prob <- paste0(prob, "*", value)
      p <- p * value
    }
    # add block timing to total timing
    t <- t + eval(parse(text = v$timing), envir = env)
    e <- e + eval(parse(text = v$energy), envir = env)
    # execute block's instructions
    for (inst in v$insts) {
      if (substr(inst[1], 1, 6) == "memcpy") {
        e <- e + eval(parse(text = inst[3]), envir = env)
        t <- t + eval(parse(text = inst[4]), envir = env)
      }
      eval(parse(text = inst[1]), envir = env)
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
          clone_env <- clone(env) # don't create unnecessary envs.
          dequer::push(nodes, list(v, succs[[v$name]][[i]], path, prob, visited, edge_visited, clone_env, t, e, p))
        }
      }
    }
    #
    if (!length(succs[[v$name]])) {
      color[v$name] <<- "black"
      #p <- eval(parse(text = prob), envir = env)
      path.prob <<- c(path.prob, p) # TODO: is rounding good here?
      if (is.numeric(t)) t <- distr::DiscreteDistribution(t)
      path.timing <<- c(path.timing, t)
      line <- paste0(path, ":", prob, "=", p)
      write(line, file = profile, append = TRUE)
      for (i in seq_along(visited)) {
        if (visited[[i]] != 0) {
          # collect frequency as percentage
          freq[names(visited)[i]] <<- paste0(freq[names(visited)[i]], "+", p)
          total_visit[[names(visited)[i]]] <<- total_visit[[names(visited)[i]]] + visited[[i]]
        }
      }
      for (i in seq_along(edge_visited)) {
        if (edge_visited[[i]] != 0) {
          edge_global[i] <<- paste0(edge_global[i], "+", p)
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
source(".output/meta.R", local = env)
source(".output/model.conf.R", local = env)
# eval function parameters
eval(parse(text = .function$types), envir = env)
eval(parse(text = .function$globals), envir = env)
eval(parse(text = .function$formals), envir = env)
eval(parse(text = .function$initials), envir = env)
# run the machine
initial_t <- 0
initial_e <- 0
system.time(DFS(list(), .function$blocks[[1]], "", "1", visited, edge_visited, env, initial_t, initial_e, 1))

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
q1 <- distr::q(path.timing.mixture)(.025)
mn <- distrEx::E(path.timing.mixture)
md <- distrEx::median(path.timing.mixture)
q2 <- distr::q(path.timing.mixture)(.975)
rnd <- round(c(q1, mn, q2), 2)
lab <- paste0("95% Confidence Interval (", rnd[1], ", ", rnd[2], ", ", rnd[3], ")")
timingPlot <- paste0(".dots/timing/", .function$name, ".svg")
dir.create(dirname(timingPlot), showWarnings = FALSE, recursive = TRUE)
svg(timingPlot, width = 10.5, height = 3.5)
par(mfrow = c(1, 3))
plot(path.timing.mixture, mfColRow = FALSE, to.draw.arg = "d", bty = "7",
     panel.first = grid(lwd = 1), lwd = 1, vertical = FALSE,
     col.points = c("red", "black"), cex.points = 1.8,
     inner = list(paste("Probability Function Of", .function$name)))
abline(v = c(q1, md, mn, q2), col = c("skyblue", "turquoise", "coral", "skyblue"))
plot(path.timing.mixture, mfColRow = FALSE, to.draw.arg = "p", bty = "7",
     panel.first = grid(lwd = 1), lwd = 1, vertical = FALSE,
     col.points = c("red", "black"), cex.points = 1.8, xlab = "",
     inner = list(paste("CDF of", .function$name)))
title(xlab = lab)
abline(v = c(q1, md, mn, q2), col = c("skyblue", "turquoise", "coral", "skyblue"))
plot(path.timing.mixture, mfColRow = FALSE, to.draw.arg = "q", bty = "7",
     panel.first = grid(lwd = 1), lwd = 1, vertical = FALSE,
     col.points = c("red", "black"), cex.points = 1.8,
     inner = list(paste("Quantile Function of", .function$name)))
abline(h = c(q1, md, mn, q2), col = c("skyblue", "turquoise", "coral", "skyblue"))
suppressWarnings(par(opar))
dev.off()
browseURL(paste0('file://', file.path(getwd(), timingPlot)))

cat("\nTime @ 1 MHz (us)")
cat("\nName ", "Mean", "Sd")
cat("\n", .function$name, distrEx::E(path.timing.mixture), distrEx::sd(path.timing.mixture))

isCheckpoint <- function(block) {
  for (i in block$insts) {
    if (i[[1]] == "checkpoint()") {
      return(TRUE)
    }
  }
  return(FALSE)
}

path.timing.mixture <- 0

intermittent_analysis <- function() {
  restore.timing <- restore.timing + harvesting_time
  file <- readLines(profile)
  tt <- vector()
  pp <- vector()
  pf_path_counter <- 0
  for (i in seq_along(file)) {
    init_cap <- distr::Unif(min_cap, max_cap)
    path <- strsplit(file[i], ":")[[1]][[1]]
    # prob in the file
    prob <- as.double(strsplit(file[i], "=")[[1]][[2]])
    # blocks of the path
    blocks <- strsplit(path, "%")[[1]]
    blocks <- blocks[2:length(blocks)]
    cp_path_total_timing <- 0
    paths <- list(list("cap" = init_cap, "total_timing" = 0, "timing" = vector(), "energy" = 0, "pf_prob" = 1, "nopf_prob" = 1, "has_pf_path" = FALSE)) # "cap" = init_cap - checkpoint.energy,
    for (j in seq_along(blocks)) {
      cat(j, " ", blocks[[j]], "\n")
      block <- eval(parse(text = paste0("block.", blocks[[j]])))
      block_energy <- eval(parse(text = block$energy), envir = env)
      block_timing <- eval(parse(text = block$timing), envir = env)
      if (isCheckpoint(block) && j != 1) {
        cat("CHECKPOINT\n")
        # cp_path_total_timing <- cp_path_total_timing + checkpoint.timing
        for (c in seq_along(paths)) {
          if (paths[[c]]$nopf_prob == 0) {
            next
          }
          # for main path (without power failures path)
          if (length(paths[[c]]$timing) == 0) {
            paths[[c]]$timing <- cp_path_total_timing
            paths[[c]]$total_timing <- paths[[c]]$total_timing + paths[[c]]$timing
          }else {
            # add cp to cp total timing to timing vector for example power failure path
            paths[[c]]$timing <- lapply(paths[[c]]$timing, function(x) x + cp_path_total_timing)
            #TODO: normalize the pf_probs
            # sum all probs for coef
            totalpf <- sum(paths[[c]]$pf_prob)
            # calculate coef for all blocks
            coef <- 1 / totalpf
            # multiply all block power failure prob with coef
            paths[[c]]$pf_prob <- paths[[c]]$pf_prob * coef
            # mix cp to cp path timing totals
            path.timing.mixture <- distr::UnivarMixingDistribution(Dlist = paths[[c]]$timing, mixCoeff = paths[[c]]$pf_prob)
            paths[[c]]$total_timing <- paths[[c]]$total_timing + path.timing.mixture
          }
          # init cp to cp timing and prob vector
          paths[[c]]$timing <- vector()
          paths[[c]]$pf_prob <- vector()
          # paths[[c]]$cap <- paths[[c]]$cap - checkpoint.energy
        }
        cp_path_total_timing <- 0
      }
      cp_path_total_timing <- cp_path_total_timing + block_timing
      for (p in seq_along(paths)) {
        if (paths[[p]]$nopf_prob == 0) {
          next
        }
        # current vertex' energy subtract from the  current capacitor total energy
        paths[[p]]$cap <- paths[[p]]$cap - block_energy
        # probability of cur_cap < min_cap so power failure prob
        pf_prob <- round(distr::p(paths[[p]]$cap)(min_cap), 3)
        # 1 - power failure prob = no power failure path (main path) prob
        paths[[p]]$nopf_prob <- round(paths[[p]]$nopf_prob * (1 - pf_prob), 3)
        # if power failure probability > 0
        if (pf_prob > 0) {
          if (!paths[[p]]$has_pf_path) {
            pf_path_counter <- pf_path_counter + 1
            paths[[p]]$has_pf_path <- TRUE
            # harvesting time in restore timing
            pf_timing <- paths[[p]]$total_timing + restore.timing
            cap_init <- max_cap - restore.energy
            timing <- append(vector(), cp_path_total_timing)
            # add new power failure path to path list with initial values
            paths <- append(paths, list(list("cap" = cap_init, "total_timing" = pf_timing, "timing" = timing, "energy" = vector(), "pf_prob" = pf_prob, "nopf_prob" = 1, "has_pf_path" = FALSE)))
          }else {
            pf_path_counter <- pf_path_counter + 1
            paths[[p + 1]]$timing <- append(paths[[p + 1]]$timing, cp_path_total_timing)
            paths[[p + 1]]$pf_prob <- append(paths[[p + 1]]$pf_prob, pf_prob)
          }
        }
      }
    }
    timing_vec <- vector()
    prob_vec <- vector()
    for (c in seq_along(paths)) {
      # if timing is empty, need to append local total because you cant add to empty vector
      if (length(paths[[c]]$timing) == 0) {
        paths[[c]]$timing <- append(paths[[c]]$timing, cp_path_total_timing)
      }else {
        paths[[c]]$timing <- lapply(paths[[c]]$timing, function(x) x + cp_path_total_timing)
      }
      if (length(paths[[c]]$timing) > 1) {
        #TODO: normalize the pf_probs
        # sum all probs for coef
        totalpf <- sum(paths[[c]]$pf_prob)
        # calculate coef for all blocks
        coef <- 1 / totalpf
        # multiply all block power failure prob with coef
        paths[[c]]$pf_prob <- paths[[c]]$pf_prob * coef
        # mix cp to cp path timing totals
        path.timing.mixture <- distr::UnivarMixingDistribution(Dlist = paths[[c]]$timing, mixCoeff = paths[[c]]$pf_prob)
        paths[[c]]$total_timing <- paths[[c]]$total_timing + path.timing.mixture
      }
      else {
        paths[[c]]$total_timing <- paths[[c]]$total_timing + paths[[c]]$timing[[1]]
      }
      if (c > 1) {
        # this paths probability is previous paths (1 - no power failure path prob)
        paths[[c]]$nopf_prob <- paths[[c]]$nopf_prob * (1 - paths[[c - 1]]$nopf_prob)
        timing_vec <- c(timing_vec, paths[[c]]$total_timing)
        prob_vec <- c(prob_vec, paths[[c]]$nopf_prob)
      }else {
        timing_vec <- c(timing_vec, paths[[c]]$total_timing)
        prob_vec <- c(prob_vec, paths[[c]]$nopf_prob)
      }
    }
    while (!is.na(match(0, prob_vec))) {
      i <- match(0, prob_vec)
      prob_vec <- prob_vec[-i]
      timing_vec <- timing_vec[-i]
    }
    path.timing.mixture <- distr::UnivarMixingDistribution(Dlist = timing_vec, mixCoeff = prob_vec)
    tt <- c(tt, path.timing.mixture)
    pp <- c(pp, prob)
  }
  cat("PF PATH COUNT: ", pf_path_counter, "\n")
  path.timing.mixture <<- distr::UnivarMixingDistribution(Dlist = tt, mixCoeff = pp)
}

system.time(intermittent_analysis())
opar <- par()
q1 <- distr::q(path.timing.mixture)(.025)
mn <- distrEx::E(path.timing.mixture)
md <- distrEx::median(path.timing.mixture)
q2 <- distr::q(path.timing.mixture)(.975)
rnd <- round(c(q1, mn, q2), 2)
lab <- paste0("95% Confidence Interval (", rnd[1], ", ", rnd[2], ", ", rnd[3], ")")
################################################
timingPlot <- paste0("Plots/", .function$name, ".intermittent.1mF.1MHz.Variant2.pdf")
dir.create(dirname(timingPlot), showWarnings = FALSE, recursive = TRUE)
# systemfonts::match_font("Fira Sans", bold = TRUE)
extrafont::loadfonts()
pdf(timingPlot, width = 9, height = 5, family = "Fira Sans")
par(mfrow = c(1, 2))
plot(path.timing.mixture, font = 2, font.lab = 2, font.main = 2, cex = 1.1, fontfamily = "Fira Sans", mfColRow = FALSE, to.draw.arg = "d", bty = "7",
     panel.first = grid(lwd = 1.1), lwd = 2, vertical = FALSE, xlab = "", cex.axis = 1.2,
     col.points = c("red", "black"), cex.points = 1.8, ylab = "", inner = ""
     # inner = list(paste("Probability Function Of", .function$name))
)
abline(v = c(q1, md, mn, q2), lwd = 1.1, col = c("skyblue", "turquoise", "coral", "skyblue"))
plot(path.timing.mixture, font = 2, font.lab = 2, font.main = 2, cex = 1.1, fontfamily = "Fira Sans", mfColRow = FALSE, to.draw.arg = "p", bty = "7",
     panel.first = grid(lwd = 1.1), lwd = 2, vertical = FALSE, inner = "", cex.axis = 1.2,
     col.points = c("red", "black"), cex.points = 1.8, xlab = "", ylab = "probability",
     # inner = list(paste("CDF of", .function$name))
)
abline(v = c(q1, md, mn, q2), lwd = 1.1, col = c("skyblue", "turquoise", "coral", "skyblue"))
# title(xlab = lab, font = 2, font.lab = 2, font.main = 2, family = "Fira Sans", cex.lab = 1.1)
mtext(lab, side = 3, line = -3, outer = TRUE, font = 2, font.lab = 2, font.main = 2, family = "Fira Sans", cex = 1.3)
# plot(path.timing.mixture, font = 2, font.lab = 2, font.main = 2, mfColRow = FALSE, to.draw.arg = "q", bty = "7",
#      panel.first = grid(lwd = 1.1), lwd = 2, vertical = FALSE,
#      col.points = c("red", "black"), cex.points = 1.8, inner = "", #ylab = "")
# )
abline(h = c(q1, md, mn, q2), lwd = 1.1, col = c("skyblue", "turquoise", "coral", "skyblue"))
suppressWarnings(par(opar))
dev.off()
# browseURL(paste0('file://', file.path(getwd(), timingPlot)))
################################################
cat("\nTime @ 1 MHz (us)")
cat("\nName ", "Mean", "Sd")
cat("\n", .function$name, distr::mean(path.timing.mixture), distrEx::sd(path.timing.mixture))
cat("\n")
distr::p(path.timing.mixture)(20000)
cat("\n")
distr::p(path.timing.mixture)(40000)
cat("\n")

cat("95\n")
round(distr::q(path.timing.mixture)(.025) * 0.001, 1)
cat("\n")
round(distr::q(path.timing.mixture)(.975) * 0.001, 1)
cat("90\n")
round(distr::q(path.timing.mixture)(.05) * 0.001, 1)
cat("\n")
round(distr::q(path.timing.mixture)(.95) * 0.001, 1)
cat("80\n")
round(distr::q(path.timing.mixture)(.1) * 0.001, 1)
cat("\n")
round(distr::q(path.timing.mixture)(.9) * 0.001, 1)
