//  ----------------------------------------------------------------------------
//  Header file for the Pass class.                                     pass.cpp
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 24, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

#include "writer.hpp"

#include <llvm/IR/CFG.h>
#include <llvm/IR/IntrinsicInst.h>

#include <regex>
#include <sstream>

#include "llvm/IR/Function.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Module.h"

char prob::sym::Writer::ID = 0;

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::Prologue =
    "rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden "
    "objects.\n"
    "# load libraries\n"
    "options(\"StartupBanner\" = \"off\")\n"
    "options(expressions=500000) #increase the limit on the number of nested "
    "expressions that will be evaluated\n"
    "library(\"distr\")\n"
    "library(\"distrEx\")\n"
    "library(\"rlang\") # required for environment functions\n"
    "library(llvm)\n"
    "distroptions(\"WarningArith\" = FALSE)\n"
    "set.seed(100)\n\n";
// -----------------------------------------------------------------------------
// Less than or equal to loop count
std::string prob::sym::Writer::MaxLoop =
    "# max loop number(less than or equal to)\n"
    "max_loop <- <N>\n"
    //    "checkpoint.energy <- distr::Norm(14560, 20) # nj\n"
    //    "checkpoint.timing <- distr::Norm(8517.05, 0.01) # us\n"
    "restore.energy <- distr::Norm(11024.3, 30) # nj\n"
    "restore.timing <- distr::Norm(8409.47, 0.01) # us\n\n"
    //    "alert.energy <- distr::Norm(9020.3, 250) # nj\n"
    //    "alert.timing <- distr::Norm(5102.4, 234) # us\n"
    //    "error.energy <- distr::Norm(4020.3, 202) # nj\n"
    //    "error.timing <- distr::Norm(2067.4, 225) # us\n"
    //    "featurize.energy <- distr::Norm(11020, 201) # nj\n"
    //    "featurize.timing <- distr::Norm(8056.47, 211) # us\n"
    "\n";
// -----------------------------------------------------------------------------
std::string prob::sym::Writer::loopCount(int N) const {
  return utility::replaceAll(MaxLoop, "<N>", std::to_string(N));
}
// -----------------------------------------------------------------------------
// Capacitor Thresholds
std::string prob::sym::Writer::Capacitor =
    "# Capacitor Thresholds\n"
    "min_cap <- <MIN> #nj\n"
    "max_cap <- <MAX> #nj\n\n"
    "# 1 mF capacitance 40 cm distance profile\n"
    "harvesting_time <- 10000 # us\n\n";
// -----------------------------------------------------------------------------
std::string prob::sym::Writer::capacitorInitializer(std::string Min,
                                                    std::string Max) const {
  std::string ret = utility::replaceAll(Capacitor, "<MIN>", Min);
  return utility::replaceAll(ret, "<MAX>", Max);
}
// -----------------------------------------------------------------------------
std::pair<std::string, std::string> prob::sym::Writer::capacitor(
    const llvm::Module& M) const {
  llvm::SmallVector<llvm::MDNode*, 5> Metadata;
  std::pair<std::string, std::string> pair = std::make_pair("0", "0");
  for (auto& F : M) {
    F.getMetadata("intermittent", Metadata);
    for (const auto& Datum : Metadata) {
      llvm::StringRef Store =
          llvm::cast<llvm::MDString>(Datum->getOperand(0))->getString();
      std::string cap = Store.str();
      std::smatch match;
      std::regex pattern("Intermittent Capacitor (\\S*),(\\S*)");
      std::regex_search(cap, match, pattern);
      if (!match.empty()) {
        pair.first = match[1].str();
        pair.second = match[2].str();
        break;
      }
    }
  }
  return pair;
}
// -----------------------------------------------------------------------------
std::string prob::sym::Writer::BlockTemplate =
    "block.<BLOCK> <- env(\n"
    "  name = \"<NAME>\",\n"
    "  preds = list(<PREDS>),\n"
    "  succs = list(<SUCCS>),\n"
    "  energy = \"E(<FUNC>, <NAME>)\",\n"
    "  timing = \"T(<FUNC>, <NAME>)\",\n"
    "  insts = list(\n<INSTRUCTIONS>))\n\n";

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::Predecessors = "list(<PREDS>)";

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::NamePredecessors =
    "names(preds) <- c(<BLOCKS>)\n\n";

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::pred(const llvm::BasicBlock& BB) const {
  std::vector<std::string> preds;
  for (const llvm::BasicBlock* pred : llvm::predecessors(&BB)) {
    preds.push_back(qualified(*pred));
  }
  return utility::replaceAll(Predecessors, "<PREDS>",
                             utility::concat(preds, ", ", ""));
}

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::namePred(
    const std::vector<std::string>& blocks) const {
  return utility::replaceAll(NamePredecessors, "<BLOCKS>",
                             utility::concat(blocks, ", ", ""));
}

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::Successors = "list(<SUCCS>)";

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::NameSuccessors =
    "names(succs) <- c(<BLOCKS>)\n\n";

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::succ(const llvm::BasicBlock& BB) const {
  std::vector<std::string> succs;
  for (const llvm::BasicBlock* succ : llvm::successors(&BB)) {
    succs.push_back(qualified(*succ));
  }
  return utility::replaceAll(Successors, "<SUCCS>",
                             utility::concat(succs, ", ", ""));
}

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::nameSucc(
    const std::vector<std::string>& blocks) const {
  return utility::replaceAll(NameSuccessors, "<BLOCKS>",
                             utility::concat(blocks, ", ", ""));
}

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::Frequencies =
    "freq <- as.list(rep(\"0\", <N>))\n";

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::NameFrequencies = "names(freq) <- c(<B>)\n\n";

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::Visited = "visited <- as.list(rep(0, <N>))\n";

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::NameVisited = "names(visited) <- c(<B>)\n\n";

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::Color =
    "color <- as.list(rep(\"white\", <N>))\n";

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::NameColor = "names(color) <- c(<B>)\n\n";

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::TotalVisit =
    "total_visit <- as.list(rep(0, <N>))\n";

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::NameTotalVisit =
    "names(total_visit) <- c(<B>)\n\n";

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::block(
    const std::vector<std::string>& blocks) const {
  std::vector<std::string> list;
  for (int i = 0; i < blocks.size(); ++i) {
    list.push_back("\"0\"");
  }

  std::string names = utility::concat(blocks, ", ", "");
  std::stringstream ss;

  ss << utility::replaceAll(Frequencies, "<N>", std::to_string(blocks.size()));
  ss << utility::replaceAll(NameFrequencies, "<B>", names);

  ss << utility::replaceAll(Visited, "<N>", std::to_string(blocks.size()));
  ss << utility::replaceAll(NameVisited, "<B>", names);

  ss << utility::replaceAll(Color, "<N>", std::to_string(blocks.size()));
  ss << utility::replaceAll(NameColor, "<B>", names);

  ss << utility::replaceAll(TotalVisit, "<N>", std::to_string(blocks.size()));
  ss << utility::replaceAll(NameTotalVisit, "<B>", names);

  return ss.str();
}

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::EdgeProbabilities =
    "edge_global <- as.list(rep(0, <N>))\n"
    "edge_local <- as.list(rep(0, <N>))\n"
    "edge_visited <- as.list(rep(0, <N>))\n";

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::NameEdgeProbabilities =
    "names(edge_global) <- c(<EDGES>)\n"
    "names(edge_local) <- c(<EDGES>)\n"
    "names(edge_visited) <- c(<EDGES>)\n\n";

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::edge(const llvm::Function& F) const {
  std::vector<std::string> succs;
  for (const llvm::BasicBlock& BB : F) {
    for (const llvm::BasicBlock* succ : llvm::successors(&BB)) {
      std::string edge =
          "\"" + BB.getName().str() + "#" + succ->getName().str() + "\"";
      succs.push_back(edge);
    }
  }

  std::vector<std::string> list;
  for (int i = 0; i < succs.size(); ++i) {
    list.push_back("0");
  }

  std::stringstream ss;
  ss << utility::replaceAll(EdgeProbabilities, "<N>",
                            std::to_string(succs.size()));
  ss << utility::replaceAll(NameEdgeProbabilities, "<EDGES>",
                            utility::concat(succs, ", ", ""));
  return ss.str();
}

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::FunctionTemplate =
    ".function <- list(\n"
    "  name = \"<FUNCTIONNAME>\",\n"
    "  formals = list(<FORMALS>),\n"
    "  initials = list(<STORE>),\n"
    "  globals = list(<GLOBALS>),\n"
    "  types = list(<TYPES>),\n"
    "  blocks = list(<BLOCKS>))\n\n";

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::FileTemplate =
    "# Create output file\n"
    "profile <- paste0(\".output/\", .function$name, \".profile\")\n"
    "file.create(profile, showWarnings = FALSE, recursive = TRUE)\n\n";

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::NormalBlockBasedMachine =
    "clone <- function(env) {\n"
    "  newenv <- rlang::env_clone(env)\n"
    "  newenv$stack <- rlang::env_clone(env$stack)\n"
    "  newenv$heap <- rlang::env_clone(env$heap)\n"
    "  newenv$global <- rlang::env_clone(env$global)\n"
    "  newenv$nv <- rlang::env_clone(env$nv)\n"
    "  newenv$sym <- rlang::env_clone(env$sym)\n"
    "  newenv$typ <- rlang::env_clone(env$typ)\n"
    "  newenv$memptrs <- rlang::env_clone(env$memptrs)\n"
    "  return(newenv)\n"
    "}\n"
    "\n"
    "library(\"dequer\") # required for an efficient implementation of stack\n"
    "\n"
    "DFS <- function(prev, v, path, prob, visited, edge_visited, env, t, e, p) "
    "{\n"
    "  nodes <- stack()\n"
    "  dequer::push(nodes, list(prev, v, path, prob, visited, edge_visited, "
    "env, t, e, p))\n"
    "  while (length(nodes)) {\n"
    "    node <- dequer::pop(nodes)\n"
    "    prev <- node[[1]]; v <- node[[2]]; path <- node[[3]]; prob <- "
    "node[[4]];\n"
    "    visited <- node[[5]]; edge_visited <- node[[6]]; env <- node[[7]]; t "
    "<- node[[8]]; p <- node[[10]]\n"
    "    #  mark v visited\n"
    "    visited[[v$name]] <- visited[[v$name]] + 1\n"
    "    color[v$name] <<- \"gray\"\n"
    "    # add blockname to the path\n"
    "    path <- paste0(path, \"%\", v$name)\n"
    "    # initialize current block\n"
    "    .block <<- v\n"
    "    cat(v$name, \"\\n\")\n"
    "    # eval path probability\n"
    "    if (length(prev)) {\n"
    "      expr <- paste0(prev$name, \"_\", v$name)\n"
    "      value <- eval(parse(text = expr), envir = env)\n"
    "      out <- paste0(prev$name, \"#\", v$name)\n"
    "      edge_visited[[out]] <- edge_visited[[out]] + 1\n"
    "      # print(paste0(out, \" = \", value))\n"
    "      prob <- paste0(prob, \"*\", value)\n"
    "      p <- p * value\n"
    "    }\n"
    "    # add block timing to total timing\n"
    "    t <- t + eval(parse(text = v$timing), envir = env)\n"
    "    e <- e + eval(parse(text = v$energy), envir = env)\n"
    "    # execute block's instructions\n"
    "    for (inst in v$insts) {\n"
    "      if (substr(inst[1], 1, 6) == \"memcpy\") {\n"
    "        e <- e + eval(parse(text = inst[3]), envir = env)\n"
    "        t <- t + eval(parse(text = inst[4]), envir = env)\n"
    "      }\n"
    "      eval(parse(text = inst[1]), envir = env)\n"
    "    }\n"
    "    # for each successor v' of v { fs\n"
    "    for (i in seq_along(succs[[v$name]])) {\n"
    "      # if v' not yet visited and prob is greater than 0 {\n"
    "      if (length(succs[[v$name]][[i]])) {\n"
    "        expr <- paste0(v$name, \"_\", succs[[v$name]][[i]]$name)\n"
    "        value <- eval(parse(text = expr), envir = env)\n"
    "        if (value > 0 && all(visited <= max_loop)) {\n"
    "          # if (i == 1) clone <- env # to be more efficient\n"
    "          # else\n"
    "          clone_env <- clone(env) # don't create unnecessary envs.\n"
    "          dequer::push(nodes, list(v, succs[[v$name]][[i]], path, prob, "
    "visited, edge_visited, clone_env, t, e, p))\n"
    "        }\n"
    "      }\n"
    "    }\n"
    "    #\n"
    "    if (!length(succs[[v$name]])) {\n"
    "      color[v$name] <<- \"black\"\n"
    "      #p <- eval(parse(text = prob), envir = env)\n"
    "      path.prob <<- c(path.prob, p) # TODO: is rounding good here?\n"
    "      if (is.numeric(t)) t <- distr::DiscreteDistribution(t)\n"
    "      path.timing <<- c(path.timing, t)\n"
    "      line <- paste0(path, \":\", prob, \"=\", p)\n"
    "      write(line, file = profile, append = TRUE)\n"
    "      for (i in seq_along(visited)) {\n"
    "        if (visited[[i]] != 0) {\n"
    "          # collect frequency as percentage\n"
    "          freq[names(visited)[i]] <<- paste0(freq[names(visited)[i]], "
    "\"+\", p)\n"
    "          total_visit[[names(visited)[i]]] <<- "
    "total_visit[[names(visited)[i]]] + visited[[i]]\n"
    "        }\n"
    "      }\n"
    "      for (i in seq_along(edge_visited)) {\n"
    "        if (edge_visited[[i]] != 0) {\n"
    "          edge_global[i] <<- paste0(edge_global[i], \"+\", "
    "p)\n"
    "          edge_local[[i]] <<- edge_local[[i]] + edge_visited[[i]]\n"
    "        }\n"
    "      }\n"
    "    }\n"
    "  }\n"
    "}\n"
    "\n";

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::ETAPMachine =
    "isCheckpoint <- function(block) {\n"
    "  for (i in block$insts) {\n"
    "    if (i[[1]] == \"checkpoint()\") {\n"
    "      return(TRUE)\n"
    "    }\n"
    "  }\n"
    "  return(FALSE)\n"
    "}\n"
    "path.timing.mixture <- 0\n"
    "intermittent_analysis <- function() {\n"
    "  restore.timing <- restore.timing + harvesting_time\n"
    "  file <- readLines(profile)\n"
    "  tt <- vector()\n"
    "  pp <- vector()\n"
    "  pf_path_counter <- 0\n"
    "  for (i in seq_along(file)) {\n"
    "    init_cap <- distr::Unif(min_cap, max_cap)\n"
    "    path <- strsplit(file[i], \":\")[[1]][[1]]\n"
    "    # prob in the file\n"
    "    prob <- as.double(strsplit(file[i], \"=\")[[1]][[2]])\n"
    "    # blocks of the path\n"
    "    blocks <- strsplit(path, \"%\")[[1]]\n"
    "    blocks <- blocks[2:length(blocks)]\n"
    "    cp_path_total_timing <- 0\n"
    "    paths <- list(list(\"cap\" = init_cap, \"total_timing\" = 0, "
    "\"timing\" = vector(), \"energy\" = 0, \"pf_prob\" = 1, \"nopf_prob\" = "
    "1, \"has_pf_path\" = FALSE)) # \"cap\" = init_cap - checkpoint.energy,\n"
    "    for (j in seq_along(blocks)) {\n"
    "      cat(j, \" \", blocks[[j]], \"\\n\")\n"
    "      block <- eval(parse(text = paste0(\"block.\", blocks[[j]])))\n"
    "      block_energy <- eval(parse(text = block$energy), envir = env)\n"
    "      block_timing <- eval(parse(text = block$timing), envir = env)\n"
    "      if (isCheckpoint(block) && j != 1) {\n"
    "        cat(\"CHECKPOINT\\n\")\n"
    "        # cp_path_total_timing <- cp_path_total_timing + "
    "checkpoint.timing\n"
    "        for (c in seq_along(paths)) {\n"
    "          if (paths[[c]]$nopf_prob == 0) {\n"
    "            next\n"
    "          }\n"
    "          # for main path (without power failures path)\n"
    "          if (length(paths[[c]]$timing) == 0) {\n"
    "            paths[[c]]$timing <- cp_path_total_timing\n"
    "            paths[[c]]$total_timing <- paths[[c]]$total_timing + "
    "paths[[c]]$timing\n"
    "          }else {\n"
    "            # add cp to cp total timing to timing vector for example "
    "power failure path\n"
    "            paths[[c]]$timing <- lapply(paths[[c]]$timing, function(x) x "
    "+ cp_path_total_timing)\n"
    "            #TODO: normalize the pf_probs\n"
    "            # sum all probs for coef\n"
    "            totalpf <- sum(paths[[c]]$pf_prob)\n"
    "            # calculate coef for all blocks\n"
    "            coef <- 1 / totalpf\n"
    "            # multiply all block power failure prob with coef\n"
    "            paths[[c]]$pf_prob <- paths[[c]]$pf_prob * coef\n"
    "            # mix cp to cp path timing totals\n"
    "            path.timing.mixture <- distr::UnivarMixingDistribution(Dlist "
    "= paths[[c]]$timing, mixCoeff = paths[[c]]$pf_prob)\n"
    "            paths[[c]]$total_timing <- paths[[c]]$total_timing + "
    "path.timing.mixture\n"
    "          }\n"
    "          # init cp to cp timing and prob vector\n"
    "          paths[[c]]$timing <- vector()\n"
    "          paths[[c]]$pf_prob <- vector()\n"
    "          # paths[[c]]$cap <- paths[[c]]$cap - checkpoint.energy\n"
    "        }\n"
    "        cp_path_total_timing <- 0\n"
    "      }\n"
    "      cp_path_total_timing <- cp_path_total_timing + block_timing\n"
    "      for (p in seq_along(paths)) {\n"
    "        if (paths[[p]]$nopf_prob == 0) {\n"
    "          next\n"
    "        }\n"
    "        # current vertex' energy subtract from the  current capacitor "
    "total energy\n"
    "        paths[[p]]$cap <- paths[[p]]$cap - block_energy\n"
    "        # probability of cur_cap < min_cap so power failure prob\n"
    "        pf_prob <- round(distr::p(paths[[p]]$cap)(min_cap), 3)\n"
    "        # 1 - power failure prob = no power failure path (main path) "
    "prob\n"
    "        paths[[p]]$nopf_prob <- round(paths[[p]]$nopf_prob * (1 - "
    "pf_prob), 3)\n"
    "        # if power failure probability > 0\n"
    "        if (pf_prob > 0) {\n"
    "          if (!paths[[p]]$has_pf_path) {\n"
    "            pf_path_counter <- pf_path_counter +1\n"
    "            paths[[p]]$has_pf_path <- TRUE\n"
    "            # harvesting time in restore timing\n"
    "            pf_timing <- paths[[p]]$total_timing + restore.timing\n"
    "            cap_init <- max_cap - restore.energy\n"
    "            timing <- append(vector(), cp_path_total_timing)\n"
    "            # add new power failure path to path list with initial "
    "values\n"
    "            paths <- append(paths, list(list(\"cap\" = cap_init, "
    "\"total_timing\" = pf_timing, \"timing\" = timing, \"energy\" = vector(), "
    "\"pf_prob\" = pf_prob, \"nopf_prob\" = 1, \"has_pf_path\" = FALSE)))\n"
    "          }else {\n"
    "            pf_path_counter <- pf_path_counter +1\n"
    "            paths[[p + 1]]$timing <- append(paths[[p + 1]]$timing, "
    "cp_path_total_timing)\n"
    "            paths[[p + 1]]$pf_prob <- append(paths[[p + 1]]$pf_prob, "
    "pf_prob)\n"
    "          }\n"
    "        }\n"
    "      }\n"
    "    }\n"
    "    timing_vec <- vector()\n"
    "    prob_vec <- vector()\n"
    "    for (c in seq_along(paths)) {\n"
    "      # if timing is empty, need to append local total because you cant "
    "add to empty vector\n"
    "      if (length(paths[[c]]$timing) == 0) {\n"
    "        paths[[c]]$timing <- append(paths[[c]]$timing, "
    "cp_path_total_timing)\n"
    "      }else {\n"
    "        paths[[c]]$timing <- lapply(paths[[c]]$timing, function(x) x + "
    "cp_path_total_timing)\n"
    "      }\n"
    "      if (length(paths[[c]]$timing) > 1) {\n"
    "        #TODO: normalize the pf_probs\n"
    "        # sum all probs for coef\n"
    "        totalpf <- sum(paths[[c]]$pf_prob)\n"
    "        # calculate coef for all blocks\n"
    "        coef <- 1 / totalpf\n"
    "        # multiply all block power failure prob with coef\n"
    "        paths[[c]]$pf_prob <- paths[[c]]$pf_prob * coef\n"
    "        # mix cp to cp path timing totals\n"
    "        path.timing.mixture <- distr::UnivarMixingDistribution(Dlist = "
    "paths[[c]]$timing, mixCoeff = paths[[c]]$pf_prob)\n"
    "        paths[[c]]$total_timing <- paths[[c]]$total_timing + "
    "path.timing.mixture\n"
    "      }\n"
    "      else {\n"
    "        paths[[c]]$total_timing <- paths[[c]]$total_timing + "
    "paths[[c]]$timing[[1]]\n"
    "      }\n"
    "      if (c > 1) {\n"
    "        # this paths probability is previous paths (1 - no power failure "
    "path prob)\n"
    "        paths[[c]]$nopf_prob <- paths[[c]]$nopf_prob * (1 - paths[[c - "
    "1]]$nopf_prob)\n"
    "        timing_vec <- c(timing_vec, paths[[c]]$total_timing)\n"
    "        prob_vec <- c(prob_vec, paths[[c]]$nopf_prob)\n"
    "      }else {\n"
    "        timing_vec <- c(timing_vec, paths[[c]]$total_timing)\n"
    "        prob_vec <- c(prob_vec, paths[[c]]$nopf_prob)\n"
    "      }\n"
    "    }\n"
    "    while (!is.na(match(0, prob_vec))) {\n"
    "      i <- match(0, prob_vec)\n"
    "      prob_vec <- prob_vec[-i]\n"
    "      timing_vec <- timing_vec[-i]\n"
    "    }\n"
    "    path.timing.mixture <- distr::UnivarMixingDistribution(Dlist = "
    "timing_vec, mixCoeff = prob_vec)\n"
    "    tt <- c(tt, path.timing.mixture)\n"
    "    pp <- c(pp, prob)\n"
    "  }\n"
    "  cat(\"PF PATH COUNT: \",pf_path_counter,\"\\n\")\n"
    "  path.timing.mixture <<- distr::UnivarMixingDistribution(Dlist = tt, "
    "mixCoeff = pp)\n"
    "}\n"
    "\n"
    "system.time(intermittent_analysis())\n"
    "opar <- par()\n"
    "q1 <- distr::q(path.timing.mixture)(.025)\n"
    "mn <- distrEx::E(path.timing.mixture)\n"
    "md <- distrEx::median(path.timing.mixture)\n"
    "q2 <- distr::q(path.timing.mixture)(.975)\n"
    "rnd <- round(c(q1, mn, q2), 2)\n"
    "lab <- paste0(\"95% Confidence Interval (\", rnd[1], \", \", rnd[2], \", "
    "\", rnd[3], \")\")\n"
    "timingPlot <- paste0(\".dots/timing/\", .function$name, "
    "\".intermittent.svg\")\n"
    "dir.create(dirname(timingPlot), showWarnings = FALSE, recursive = TRUE)\n"
    "svg(timingPlot, width = 10.5, height = 3.5)\n"
    "par(mfrow = c(1, 3))\n"
    "plot(path.timing.mixture, mfColRow = FALSE, to.draw.arg = \"d\", bty = "
    "\"7\",\n"
    "     panel.first = grid(lwd = 1), lwd = 1, vertical = FALSE,\n"
    "     col.points = c(\"red\", \"black\"), cex.points = 1.8,\n"
    "     inner = list(paste(\"Probability Function Of\", .function$name)))\n"
    "abline(v = c(q1, md, mn, q2), col = c(\"skyblue\", \"turquoise\", "
    "\"coral\", \"skyblue\"))\n"
    "plot(path.timing.mixture, mfColRow = FALSE, to.draw.arg = \"p\", bty = "
    "\"7\",\n"
    "     panel.first = grid(lwd = 1), lwd = 1, vertical = FALSE,\n"
    "     col.points = c(\"red\", \"black\"), cex.points = 1.8, xlab = \"\",\n"
    "     inner = list(paste(\"CDF of\", .function$name)))\n"
    "title(xlab = lab)\n"
    "abline(v = c(q1, md, mn, q2), col = c(\"skyblue\", \"turquoise\", "
    "\"coral\", \"skyblue\"))\n"
    "plot(path.timing.mixture, mfColRow = FALSE, to.draw.arg = \"q\", bty = "
    "\"7\",\n"
    "     panel.first = grid(lwd = 1), lwd = 1, vertical = FALSE,\n"
    "     col.points = c(\"red\", \"black\"), cex.points = 1.8,\n"
    "     inner = list(paste(\"Quantile Function of\", .function$name)))\n"
    "abline(h = c(q1, md, mn, q2), col = c(\"skyblue\", \"turquoise\", "
    "\"coral\", \"skyblue\"))\n"
    "suppressWarnings(par(opar))\n"
    "dev.off()\n"
    "browseURL(paste0('file://', file.path(getwd(), timingPlot)))\n"
    "cat(\"\\nTime @ 1 MHz (us)\")\n"
    "cat(\"\\nName \", \"Mean\", \"Sd\")\n"
    "cat(\"\\n\", .function$name, distr::mean(path.timing.mixture), "
    "distrEx::sd(path.timing.mixture))\n";

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::NormalInstructionBasedMachine =
    "clone <- function(env) {\n"
    "  newenv <- rlang::env_clone(env)\n"
    "  newenv$stack <- rlang::env_clone(env$stack)\n"
    "  newenv$heap <- rlang::env_clone(env$heap)\n"
    "  newenv$global <- rlang::env_clone(env$global)\n"
    "  newenv$nv <- rlang::env_clone(env$nv)\n"
    "  newenv$sym <- rlang::env_clone(env$sym)\n"
    "  newenv$typ <- rlang::env_clone(env$typ)\n"
    "  newenv$memptrs <- rlang::env_clone(env$memptrs)\n"
    "  return(newenv)\n"
    "}\n"
    "\n"
    "library(\"dequer\") # required for an efficient implementation of stack\n"
    "\n"
    "DFS <- function(prev, v, path, prob, visited, edge_visited, env, t, e, p) "
    "{\n"
    "  nodes <- stack()\n"
    "  dequer::push(nodes, list(prev, v, path, prob, visited, edge_visited, "
    "env, t, e, p))\n"
    "  while (length(nodes)) {\n"
    "    node <- dequer::pop(nodes)\n"
    "    prev <- node[[1]]; v <- node[[2]]; path <- node[[3]]; prob <- "
    "node[[4]];\n"
    "    visited <- node[[5]]; edge_visited <- node[[6]]; env <- node[[7]]; t "
    "<- node[[8]]; p <- node[[10]]\n"
    "    #  mark v visited\n"
    "    visited[[v$name]] <- visited[[v$name]] + 1\n"
    "    color[v$name] <<- \"gray\"\n"
    "    # add blockname to the path\n"
    "    path <- paste0(path, \"%\", v$name)\n"
    "    # initialize current block\n"
    "    .block <<- v\n"
    "    cat(v$name, \"\\n\")\n"
    "    # eval path probability\n"
    "    if (length(prev)) {\n"
    "      expr <- paste0(prev$name, \"_\", v$name)\n"
    "      value <- eval(parse(text = expr), envir = env)\n"
    "      out <- paste0(prev$name, \"#\", v$name)\n"
    "      edge_visited[[out]] <- edge_visited[[out]] + 1\n"
    "      # print(paste0(out, \" = \", value))\n"
    "      prob <- paste0(prob, \"*\", value)\n"
    "      p <- p * value\n"
    "    }\n"
    "    # execute block's instructions\n"
    "    for (inst in v$insts) {\n"
    //    "      if (inst[1] == \"checkpoint()\") {\n"
    //    "        t <- t + checkpoint.timing\n"
    //    "        e <- e + checkpoint.energy\n"
    //    "      } else if (inst[1] == \"alert()\") {\n"
    //    "        t <- t + alert.timing\n"
    //    "        e <- e + alert.energy\n"
    //    "      } else if (inst[1] == \"error()\") {\n"
    //    "        t <- t + error.timing\n"
    //    "        e <- e + error.energy\n"
    //    "      } else if (inst[1] == \"featurize()\") {\n"
    //    "        t <- t + featurize.timing\n"
    //    "        e <- e + featurize.energy\n"
    //    "      }\n"
    "      eval(parse(text = inst[1]), envir = env)\n"
    "      e <- e + eval(parse(text = inst[3]), envir = env)\n"
    "      t <- t + eval(parse(text = inst[4]), envir = env)\n"
    "    }\n"
    "    # for each successor v' of v { fs\n"
    "    for (i in seq_along(succs[[v$name]])) {\n"
    "      # if v' not yet visited and prob is greater than 0 {\n"
    "      if (length(succs[[v$name]][[i]])) {\n"
    "        expr <- paste0(v$name, \"_\", succs[[v$name]][[i]]$name)\n"
    "        value <- eval(parse(text = expr), envir = env)\n"
    "        if (value > 0 && all(visited <= max_loop)) {\n"
    "          # if (i == 1) clone <- env # to be more efficient\n"
    "          # else\n"
    "          clone_env <- clone(env) # don't create unnecessary envs.\n"
    "          dequer::push(nodes, list(v, succs[[v$name]][[i]], path, prob, "
    "visited, edge_visited, clone_env, t, e, p))\n"
    "        }\n"
    "      }\n"
    "    }\n"
    "    #\n"
    "    if (!length(succs[[v$name]])) {\n"
    "      color[v$name] <<- \"black\"\n"
    "      path.prob <<- c(path.prob, p) # TODO: is rounding good here?\n"
    "      if (is.numeric(t)) t <- distr::DiscreteDistribution(t)\n"
    "      path.timing <<- c(path.timing, t)\n"
    "      line <- paste0(path, \":\", prob, \"=\", p)\n"
    "      write(line, file = profile, append = TRUE)\n"
    "      for (i in seq_along(visited)) {\n"
    "        if (visited[[i]] != 0) {\n"
    "          # collect frequency as percentage\n"
    "          freq[names(visited)[i]] <<- paste0(freq[names(visited)[i]], "
    "\"+\", p)\n"
    "          total_visit[[names(visited)[i]]] <<- "
    "total_visit[[names(visited)[i]]] + visited[[i]]\n"
    "        }\n"
    "      }\n"
    "      for (i in seq_along(edge_visited)) {\n"
    "        if (edge_visited[[i]] != 0) {\n"
    "          edge_global[i] <<- paste0(edge_global[i], \"+\", p)\n"
    "          edge_local[[i]] <<- edge_local[[i]] + edge_visited[[i]]\n"
    "        }\n"
    "      }\n"
    "    }\n"
    "  }\n"
    "}\n"
    "\n";

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::IntermittentMachine =
    "checkpoint <- function(env) {\n"
    "  memelements <- c(\"global\", \"heap\", \"memptrs\", \"stack\", \"sym\", "
    "\"typ\")\n"
    "  for (i in memelements) {\n"
    "    env$nv[[i]] <- rlang::env_clone(env[[i]])\n"
    "  }\n"
    "}\n"
    "\n"
    "restore <- function(env) {\n"
    "  memelements <- c(\"global\", \"heap\", \"memptrs\", \"stack\", \"sym\", "
    "\"typ\")\n"
    "  for (i in memelements) {\n"
    "    if (is.null(env$nv[[i]])) next\n"
    "    env[[i]] <- rlang::env_clone(env$nv[[i]])\n"
    "  }\n"
    "}\n"
    "\n"
    "clone <- function(env) {\n"
    "  newenv <- rlang::env_clone(env)\n"
    "  newenv$stack <- rlang::env_clone(env$stack)\n"
    "  newenv$heap <- rlang::env_clone(env$heap)\n"
    "  newenv$global <- rlang::env_clone(env$global)\n"
    "  newenv$nv <- rlang::env_clone(env$nv)\n"
    "  newenv$sym <- rlang::env_clone(env$sym)\n"
    "  newenv$typ <- rlang::env_clone(env$typ)\n"
    "  newenv$memptrs <- rlang::env_clone(env$memptrs)\n"
    "  return(newenv)\n"
    "}\n"
    "\n"
    "library(\"dequer\") # required for an efficient implementation of stack\n"
    "\n"
    "DFS <- function(prev, v, path, prob, visited, edge_visited, env, t, e, "
    "cur_cap, cp_block) {\n"
    "  nodes <- stack()\n"
    "  dequer::push(nodes, list(prev, v, path, prob, visited, edge_visited, "
    "env, t, e, cur_cap, cp_block))\n"
    "  while (length(nodes)) {\n"
    "    node <- dequer::pop(nodes)\n"
    "    prev <- node[[1]]; v <- node[[2]]; path <- node[[3]]; prob <- "
    "node[[4]];\n"
    "    visited <- node[[5]]; edge_visited <- node[[6]]; env <- node[[7]]; t "
    "<- node[[8]]\n"
    "    cur_cap<- node[[10]]; cp_block<-node[[11]]\n"
    "    #  mark v visited\n"
    "    visited[[v$name]] <- visited[[v$name]] + 1\n"
    "    color[v$name] <<- \"gray\"\n"
    "    # add blockname to the path\n"
    "    path <- paste0(path, \"%\", v$name)\n"
    "    # print(\"---------------\")\n"
    "    cat(\"PATH: \", path, \"\\n\")\n"
    "    print(cur_cap)\n"
    "    # initialize current block\n"
    "    .block <<- v\n"
    "    # add block timing to total timing\n"
    "    t <- t + eval(parse(text = v$timing), envir = env)\n"
    "    e <- e + eval(parse(text = v$energy), envir = env)\n"
    "    # execute block's instructions\n"
    "    for (inst in v$insts) {\n"
    "      if (inst[1] == \"checkpoint()\") {\n"
    "        cp_block <- v\n"
    "        checkpoint(env)\n"
    "      } else\n"
    "        eval(parse(text = inst[1]), envir = env)\n"
    "    }\n"
    "    # current vertex' energy subtract from the  current capacitor total "
    "energy\n"
    "    cur_cap <- cur_cap - eval(parse(text = v$energy), envir = env)\n"
    "    pf_prob <- round(distr::p(cur_cap)(min_cap), 2) #  rounding because "
    "of too small (e-20) probs\n"
    "    # cat(\"PF_PROB: \",pf_prob,\"\\n\")\n"
    "    # pf_block <- paste0(\"pf_\",v$name)\n"
    "    # eval(parse(text=paste0(pf_block,\"<-\",pf_prob)),envir = env)\n\n"
    "    # eval path probability\n"
    "    if (length(prev)) {\n"
    "      expr <- paste0(prev$name, \"_\", v$name)\n"
    "      if (!is.null(env[[expr]])) {\n"
    "        value <- eval(parse(text = expr), envir = env)\n"
    "        out <- paste0(prev$name, \"#\", v$name)\n"
    "        edge_visited[[out]] <- edge_visited[[out]] + 1\n"
    "        # print(paste0(out, \" = \", value))\n"
    "        prob <- paste0(prob, \"*\", value)\n"
    "      }\n"
    "    }\n"
    "    # for each successor v' of v { fs\n"
    "    for (i in seq_along(succs[[v$name]])) {\n"
    "      # if v' not yet visited and prob is greater than 0 {\n"
    "      if (length(succs[[v$name]][[i]])) {\n"
    "        expr <- paste0(v$name, \"_\", succs[[v$name]][[i]]$name)\n"
    "        value <- eval(parse(text = expr), envir = env)\n"
    "        if (value > 0 &&\n"
    "          all(visited <= max_loop) &&\n"
    "          pf_prob < 1) {\n"
    "          # if (i == 1) clone <- env # to be more efficient\n"
    "          # else\n"
    "          # multiply with no power failure prob\n"
    "          prob_no_pf_path <- paste0(prob, \"* (\", 1 - pf_prob, \") \")\n"
    "          #clone <- rlang::env_clone(env) # don't create unnecessary "
    "envs.\n"
    "          # clone <- cloneEnv(env)\n"
    "          clone_env <- clone(env)\n"
    "          dequer::push(nodes, list(v, succs[[v$name]][[i]], path, "
    "prob_no_pf_path, visited, edge_visited, clone_env, t, e, cur_cap, "
    "cp_block))\n"
    "        }\n"
    "      }\n"
    "    }\n\n"
    "    # if power failure prob greater than 0 then restore and push "
    "checkpoint block\n"
    "    if (pf_prob > 0 &&\n"
    "      length(succs[[v$name]]) &&\n"
    "      all(visited <= max_loop)) {\n"
    "      prob_pf_path <- paste0(prob, \"* (\", pf_prob, \") \")\n"
    "      restore(env)\n"
    "      # add harvesting time to total time\n"
    "      t <- t + harvesting_time + restore.timing\n"
    "      # current capacitor is max level\n"
    "      cur_cap <- max_cap - restore.energy\n"
    "      # clone <- rlang::env_clone(env)\n"
    "      clone_env <- clone(env)\n"
    "      dequer::push(nodes, list(v, cp_block, path, prob_pf_path, visited, "
    "edge_visited, clone_env, t, e, cur_cap, cp_block))\n"
    "    }\n\n"
    "    #\n"
    "    if (!length(succs[[v$name]])) {\n"
    "      color[v$name] <<- \"black\"\n"
    "      p <- eval(parse(text = prob), envir = env)\n"
    "      path.prob <<- c(path.prob, p) # TODO: is rounding good here?\n"
    "      if (is.numeric(t)) t <- distr::DiscreteDistribution(t)\n"
    "      path.timing <<- c(path.timing, t)\n"
    "      path <- substr(path, 1, 10000)\n"
    "      prob <- substr(prob, 1, 10000)\n"
    "      line <- paste0(path, \":\", prob, \"=\", p)\n"
    "      write(line, file = profile, append = TRUE)\n"
    "      for (i in seq_along(visited)) {\n"
    "        if (visited[[i]] != 0) {\n"
    "          # collect frequency as percentage\n"
    "          freq[names(visited)[i]] <<- paste0(freq[names(visited)[i]], "
    "\"+\", eval(parse(text = prob)))\n"
    "          total_visit[[names(visited)[i]]] <<- "
    "total_visit[[names(visited)[i]]] + visited[[i]]\n"
    "        }\n"
    "      }\n"
    "      for (i in seq_along(edge_visited)) {\n"
    "        if (edge_visited[[i]] != 0) {\n"
    "          edge_global[i] <<- paste0(edge_global[i], \"+\", "
    "eval(parse(text = prob)))\n"
    "          edge_local[[i]] <<- edge_local[[i]] + edge_visited[[i]]\n"
    "        }\n"
    "      }\n"
    "    }\n"
    "  }\n"
    "}\n"
    "\n";

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::RunNormalMachine =
    "path.return <- vector()\n"
    "path.prob <- vector()\n"
    "path.energy <- vector()\n"
    "path.timing <- vector()\n\n"
    ".block <- env()\n"
    "env <- env()\n"
    "source(\".output/meta.R\", local = env)\n"
    "source(\".output/model.conf.R\", local = env)\n"
    "# eval function parameters\n"
    "eval(parse(text = .function$types), envir = env)\n"
    "eval(parse(text = .function$globals), envir = env)\n"
    "eval(parse(text = .function$formals), envir = env)\n"
    "eval(parse(text = .function$initials), envir = env)\n"
    "# run the machine\n"
    "initial_t <- 0\n"
    "initial_e <- 0\n"
    "system.time(DFS(list(), .function$blocks[[1]], \"\", \"1\", visited, "
    "edge_visited, env, initial_t, initial_e, 1))\n"
    "\n";

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::RunIntermittentMachine =
    "path.return <- vector()\n"
    "path.prob <- vector()\n"
    "path.energy <- vector()\n"
    "path.timing <- vector()\n\n"
    ".block <- env()\n"
    "env <- env()\n"
    "source(\".output/meta.R\", local = env)\n"
    "source(\".output/model.conf.R\", local = env)\n"
    "# source(\".output/harvesting.conf.R\", local = env)\n"
    "# eval function parameters\n"
    "eval(parse(text = .function$types), envir = env)\n"
    "eval(parse(text = .function$globals), envir = env)\n"
    "eval(parse(text = .function$formals), envir = env)\n"
    "eval(parse(text = .function$initials), envir = env)\n"
    "# run the machine\n"
    "initial_t <- 0\n"
    "initial_e <- 0\n"
    "cp_block <- .function$blocks[[1]]\n"
    "system.time(DFS(list(), .function$blocks[[1]], \"\", \"1\", visited, "
    "edge_visited, env, initial_t, initial_e, distr::Unif(Min = min_cap, Max = "
    "max_cap), cp_block))\n"
    "\n";

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::PlotReturn =
    "# return plot\n"
    "opar <- par()\n"
    "path.return.mixture <- distr::UnivarMixingDistribution(Dlist = "
    "path.return, mixCoeff = path.prob)\n"
    "returnPlot <- paste0(\".dots/return/\", .function$name, \".svg\")\n"
    "dir.create(dirname(returnPlot), showWarnings = FALSE, recursive = TRUE)\n"
    "svg(returnPlot, width = 10.5, height = 3.5)\n"
    "plot(path.return.mixture, to.draw.arg = c(\"d\", \"p\", \"q\"), "
    "bty = "
    "\"7\",\n"
    "     panel.first = grid(lwd = 1), lwd = 1, vertical = FALSE,\n"
    "     col.points = c(\"red\", \"black\"), cex.points = 1.8,\n"
    "     inner = list(\n"
    "       paste(\"Probability Function of\", .function$name),\n"
    "       paste(\"CDF of\", .function$name),\n"
    "       paste(\"Quantile Function of\", .function$name)),\n"
    ")\n"
    "suppressWarnings(par(opar))\n"
    "dev.off()\n"
    "browseURL(paste0('file://', file.path(getwd(), returnPlot)))\n\n";
// -----------------------------------------------------------------------------
std::string prob::sym::Writer::PlotTiming =
    "# timing plot\n"
    "opar <- par()\n"
    "path.timing.mixture <- distr::UnivarMixingDistribution(Dlist = "
    "path.timing, mixCoeff = path.prob)\n"
    "q1 <- distr::q(path.timing.mixture)(.025)\n"
    "mn <- distrEx::E(path.timing.mixture)\n"
    "md <- distrEx::median(path.timing.mixture)\n"
    "q2 <- distr::q(path.timing.mixture)(.975)\n"
    "rnd <- round(c(q1, mn, q2), 2)\n"
    "lab <- paste0(\"95% Confidence Interval (\", rnd[1], \", \", rnd[2], \", "
    "\", rnd[3], \")\")\n"
    "timingPlot <- paste0(\".dots/timing/\", .function$name, \".svg\")\n"
    "dir.create(dirname(timingPlot), showWarnings = FALSE, recursive = TRUE)\n"
    "svg(timingPlot, width = 10.5, height = 3.5)\n"
    "par(mfrow = c(1, 3))\n"
    "plot(path.timing.mixture, mfColRow = FALSE, to.draw.arg = \"d\", bty = "
    "\"7\",\n"
    "     panel.first = grid(lwd = 1), lwd = 1, vertical = FALSE,\n"
    "     col.points = c(\"red\", \"black\"), cex.points = 1.8,\n"
    "     inner = list(paste(\"Probability Function Of\", .function$name)))\n"
    "abline(v = c(q1, md, mn, q2), col = c(\"skyblue\", \"turquoise\", "
    "\"coral\", \"skyblue\"))\n"
    "plot(path.timing.mixture, mfColRow = FALSE, to.draw.arg = \"p\", bty = "
    "\"7\",\n"
    "     panel.first = grid(lwd = 1), lwd = 1, vertical = FALSE,\n"
    "     col.points = c(\"red\", \"black\"), cex.points = 1.8, xlab = \"\",\n"
    "     inner = list(paste(\"CDF of\", .function$name)))\n"
    "title(xlab = lab)\n"
    "abline(v = c(q1, md, mn, q2), col = c(\"skyblue\", \"turquoise\", "
    "\"coral\", \"skyblue\"))\n"
    "plot(path.timing.mixture, mfColRow = FALSE, to.draw.arg = \"q\", bty = "
    "\"7\",\n"
    "     panel.first = grid(lwd = 1), lwd = 1, vertical = FALSE,\n"
    "     col.points = c(\"red\", \"black\"), cex.points = 1.8,\n"
    "     inner = list(paste(\"Quantile Function of\", .function$name)))\n"
    "abline(h = c(q1, md, mn, q2), col = c(\"skyblue\", \"turquoise\", "
    "\"coral\", \"skyblue\"))\n"
    "suppressWarnings(par(opar))\n"
    "dev.off()\n"
    "browseURL(paste0('file://', file.path(getwd(), timingPlot)))\n\n"
    "cat(\"\\nTime @ 1 MHz (us)\")\n"
    "cat(\"\\nName \", \"Mean\", \"Sd\")\n"
    "cat(\"\\n\", .function$name, distrEx::E(path.timing.mixture), "
    "distrEx::sd(path.timing.mixture))\n\n";

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::Epilogue =
    "prob_global_file <- paste0(\".output/\", .function$name, "
    "\".global.prob\")\n"
    "file.create(prob_global_file, showWarnings = FALSE, recursive = TRUE)\n"
    "for (i in seq_along(edge_global)) {\n"
    "  p <- eval(parse(text = edge_global[i]))\n"
    "  line <- paste0(names(edge_global)[i], \": [\", edge_local[[i]], \"] = "
    "\", p)\n"
    "  write(line, file = prob_global_file, append = TRUE)\n"
    "  #print(line)\n"
    "}\n\n"
    "prob_local_file <- paste0(\".output/\", .function$name, "
    "\".local.prob\")\n"
    "file.create(prob_local_file, showWarnings = FALSE, recursive = TRUE)\n"
    "for (i in seq_along(edge_local)) {\n"
    "  edge_name <- names(edge_local)[i] # edge's name\n"
    "  block <- unlist(strsplit(edge_name, \"#\"))[1] # block's name\n"
    "  if (total_visit[[block]] != 0)\n"
    "    p <- edge_local[[i]] / total_visit[[block]]\n"
    "  else\n"
    "    p <- edge_local[[i]]\n"
    "  line <- paste0(edge_name, \": [\", edge_local[i], \"] = \", p)\n"
    "  write(line, file = prob_local_file, append = TRUE)\n"
    "  #print(line)\n"
    "}\n\n"
    "freq_file <- paste0(\".output/\", .function$name, \".freq\")\n"
    "file.create(freq_file, showWarnings = FALSE, recursive = TRUE)\n"
    "for (i in seq_along(freq)) {\n"
    "  f <- eval(parse(text = freq[i]))\n"
    "  line <- paste0(names(freq)[i], \": [\", total_visit[[i]], \"] = \", f)\n"
    "  write(line, file = freq_file, append = TRUE)\n"
    "  #print(line)\n"
    "}\n\n"
    "#for (i in seq_along(color)) {\n"
    "#  print(paste0(names(color)[i], \" = \", color[i]))\n"
    "#}\n";

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::run(const llvm::Function& F) const {
  std::string s;
  if (Execution == Intermittent)
    s = utility::replaceAll(RunIntermittentMachine, "<FUNCTIONNAME>",
                            F.getName().str());
  else
    s = utility::replaceAll(RunNormalMachine, "<FUNCTIONNAME>",
                            F.getName().str());
  return s;
}

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::epilogue(const llvm::Function& F) const {
  std::string s =
      utility::replaceAll(Epilogue, "<FUNCTIONNAME>", F.getName().str());
  return s;
}

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::formals(const llvm::Function& F,
                                       bool verbose) const {
  std::string Store(utility::concat(metadata(F, verbose), "; ", ""));
  return Store;
}

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::store(const llvm::Function& F) const {
  llvm::SmallVector<llvm::MDNode*, 5> Metadata;
  std::vector<std::string> values;
  F.getMetadata("store", Metadata);
  for (const auto& Datum : Metadata) {
    llvm::StringRef Store =
        llvm::cast<llvm::MDString>(Datum->getOperand(0))->getString();
    values.push_back(Store.str());
  }
  return utility::concat(values, "; ", "");  // REVIEW here
}

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::function(
    const llvm::Function& F, const std::vector<std::string>& blocks,
    const std::vector<std::string>& globals,
    const std::vector<std::string>& types) const {
  std::string s = utility::replaceAll(FunctionTemplate, "<FUNCTIONNAME>",
                                      F.getName().str());
  s = utility::replaceAll(s, "<FORMALS>", "\"" + formals(F) + "\"");
  s = utility::replaceAll(s, "<STORE>", "\"" + store(F) + "\"");
  s = utility::replaceAll(s, "<GLOBALS>", utility::concat(globals, ", ", ""));
  s = utility::replaceAll(s, "<TYPES>", utility::concat(types, ", ", ""));
  s = utility::replaceAll(s, "<BLOCKS>", utility::concat(blocks, ", ", ""));
  return s;
}

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::block(
    const llvm::BasicBlock& BB, const std::vector<std::string>& insts) const {
  std::string s;
  s = utility::replaceAll(BlockTemplate, "<BLOCK>", BB.getName().str());
  s = utility::replaceAll(s, "<NAME>", BB.getName().str());
  s = utility::replaceAll(s, "<FUNC>", BB.getParent()->getName().str());

  std::vector<std::string> preds;
  for (const llvm::BasicBlock* pred : llvm::predecessors(&BB)) {
    preds.push_back("\"" + (*pred).getName().str() + "\"");
  }
  s = utility::replaceAll(s, "<PREDS>", utility::concat(preds, ", ", ""));

  std::vector<std::string> succs;
  for (const llvm::BasicBlock* succ : llvm::successors(&BB)) {
    succs.push_back("\"" + (*succ).getName().str() + "\"");
  }
  s = utility::replaceAll(s, "<SUCCS>", utility::concat(succs, ", ", ""));
  s = utility::replaceAll(s, "<INSTRUCTIONS>",
                          utility::concat(insts, ",\n", ""));
  return s;
}

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::instruction(std::string Store,
                                           std::string Update,
                                           std::string Energy,
                                           std::string Timing) const {
  return std::string(4, ' ') + "list(\"" + Store + "\", \"" + Update +
         "\", \"" + Energy + "\", \"" + Timing + "\")";
}

// -----------------------------------------------------------------------------
std::vector<std::string> prob::sym::Writer::metadata(const llvm::Function& F,
                                                     bool verbose) const {
  llvm::SmallVector<llvm::MDNode*, 5> Metadata;
  std::vector<std::string> values;
  F.getMetadata("formal", Metadata);
  for (const auto& Datum : Metadata) {
    llvm::StringRef Store =
        llvm::cast<llvm::MDString>(Datum->getOperand(0))->getString();
    std::string formal = Store.str();
    if (!verbose)
      formal = std::regex_replace(
          formal, std::regex("sym\\$\\\\\"(.*?)\\\\\"(.*)"), "$1 $2");
    values.push_back(formal);
  }
  return values;
}

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::constant(const llvm::Constant* C,
                                        const llvm::Module* M) const {
  if (C->getType()->isArrayTy()) {
    std::string list;
    int i = 0;
    for (; i < C->getType()->getArrayNumElements(); ++i) {
      llvm::Constant* c = C->getAggregateElement(i);
      list += constant(c, M) + ", ";
    }
    if (i > 0) {
      list.pop_back();
      list.pop_back();
    }
    return list;
  }
  if (C->getType()->isStructTy()) {
    std::string list;
    int i = 0;
    for (; i < C->getType()->getStructNumElements(); ++i) {
      llvm::Constant* c = C->getAggregateElement(i);
      list += constant(c, M) + ", ";
    }
    if (i > 0) {
      list.pop_back();
      list.pop_back();
    }
    return list;
  }
  if (C->getType()->isPointerTy()) {
    return symbol(C, M);
  }
  if (C->getType()->isIntegerTy() || C->getType()->isFloatingPointTy()) {
    return symbol(C, M);
  }
  return "error";
}
// -----------------------------------------------------------------------------
// sym$"name"
std::string prob::sym::Writer::symbol(const llvm::Value* V,
                                      const llvm::Module* M) const {
  std::string name = utility::name(V, M);
  if (name == "null") return name;
  if (auto* c = llvm::dyn_cast<llvm::Constant>(V)) {
    if (c->getType()->isIntegerTy() || c->getType()->isFloatingPointTy())
      return name;
  }
  if (auto* bb = llvm::dyn_cast<llvm::BasicBlock>(V))
    return bb->getName().str();
  return "sym$\\\"" + name.replace(0, 1, "") + "\\\"";
}
// -----------------------------------------------------------------------------
// prints type
std::string prob::sym::Writer::type(const llvm::Type* T) const {
  std::string s;
  llvm::raw_string_ostream ss(s);
  if (auto* st = llvm::dyn_cast<llvm::StructType>(T))
    ss << "%" << st->getName();
  else
    T->print(ss, true, false);
  return "\\\"" + ss.str() + "\\\"";
}
// -----------------------------------------------------------------------------
// prints instruction
std::string prob::sym::Writer::instruction(const std::string& I) const {
  return "\"" + I + "\"";
}

// -----------------------------------------------------------------------------
// gets the metadata of the called function
std::string prob::sym::Writer::getMetaDataCalledFunc(
    llvm::Function* F, std::string metaData) const {
  std::string cost{""};
  if (llvm::MDNode* n = F->getMetadata(metaData)) {
    if (!n->isDistinct()) {
      cost = llvm::cast<llvm::MDString>(n->getOperand(0))->getString().str();
    }
  }
  return cost;
}

// -----------------------------------------------------------------------------
void prob::sym::Writer::write(const llvm::Module& M) const {
  // Generate meta file that each function (file) will use (source)
  std::ofstream meta(".output/meta.R");
  meta << MetaFunctions;  // instructions for llvm2R translation
  if (Execution == Normal || Execution == ETAP)
    meta << CheckpointRestoreForNormalExecution;
  if (BlockBased.getValue())
    meta << BlockBasedFunctions;
  else
    meta << InstructionBasedFunctions;
  meta.close();
  // Capacitor
  std::pair<std::string, std::string> cap = capacitor(M);
  std::string capMin = cap.first;
  std::string capMax = cap.second;

  // extract struct types
  std::vector<std::string> types;
  for (const auto& st : M.getIdentifiedStructTypes()) {
    const std::string expr = utility::printType(st);
    std::smatch match;
    const std::regex pattern("(%\\S*) = type \\{ (.*?) \\}");
    std::regex_search(expr, match, pattern);
    if (match.empty()) continue;
    const std::string sym = match[1].str();
    const std::string type = match[2].str();
    const std::string inst =
        "typ$\\\"" + sym + "\\\" <- " + "\\\"" + type + "\\\"";
    types.push_back(instruction(inst));
  }

  // For each function...
  for (const llvm::Function& F : M) {
    // Collect global variables
    std::vector<std::string> globals;
    for (const llvm::GlobalVariable& G : M.globals()) {
      if (!G.hasInitializer()) continue;
      const std::string sym = symbol(&G, &M);
      const llvm::Constant* initializer = G.getInitializer();
      const std::string typ = type(initializer->getType());
      const std::string val = constant(initializer, &M);
      const std::string inst =
          sym + " <- " + "galloc(" + typ + ", " + val + ")";
      globals.push_back(instruction(inst));
    }
    // if it is a declaration just skip it.
    if (F.isDeclaration()) continue;
    // create a file for the function
    std::string f = ".output/" + F.getName().str() + ".sym.R";
    std::ofstream File(f);
    std::cout << "  Generating: " << f << " ..." << std::endl;
    // insert the opening statements
    File << Prologue;
    // insert the max loop count
    File << loopCount();
    // start writing the machine model to the file
    std::vector<std::string> blocks;
    std::vector<std::string> block_names;
    // predecessors and successors  will be appended just before the function
    std::vector<std::string> preds;
    std::vector<std::string> succs;
    // prepare each block
    for (const llvm::BasicBlock& BB : F) {
      blocks.push_back(qualified(BB));
      block_names.push_back(qualified(BB) + "$name");
      // for the first instruction, is there any undo instruction?
      std::vector<std::string> insts;
      llvm::BasicBlock::const_iterator i = BB.begin();
      const llvm::Instruction& inst = *i;
      // if exists, add it as a first instruction
      if (llvm::MDNode* undo = inst.getMetadata("undo")) {
        llvm::StringRef cmd =
            llvm::cast<llvm::MDString>(undo->getOperand(0))->getString();
        insts.push_back(instruction(cmd.str(), "nop", "0", "0"));
      }
      // for each block, collect the instructions
      for (const llvm::Instruction& I : BB) {
        // fill the instructions
        if (llvm::MDNode* nodeS = I.getMetadata("store")) {
          llvm::StringRef Store =
              llvm::cast<llvm::MDString>(nodeS->getOperand(0))->getString();
          llvm::StringRef Update = "nop";
          // For Energy and Timing cost for Instruction-based models
          std::string opcode = I.getOpcodeName();
          std::string Energy = "E(" + opcode + ")";
          std::string Timing = "T(" + opcode + ")";
          if (llvm::isa<llvm::MemCpyInst>(I)) {
            std::string size =
                utility::name(llvm::cast<llvm::MemCpyInst>(I).getArgOperand(2),
                              I.getModule());
            Energy = "energy$memcpy(" + size + ")";
            Timing = "timing$memcpy(" + size + ")";
          } else if (llvm::isa<llvm::CallInst>(I)) {
            llvm::Function* calledFunction =
                llvm::cast<llvm::CallInst>(I).getCalledFunction();
            std::string timing =
                getMetaDataCalledFunc(calledFunction, "timing");
            std::string energy =
                getMetaDataCalledFunc(calledFunction, "energy");
            if (energy != "") Energy += " + " + energy;
            if (timing != "") Timing += " + " + timing;
          }
          // For conditional probabilities
          if (llvm::MDNode* nodeU = I.getMetadata("update")) {
            Update =
                llvm::cast<llvm::MDString>(nodeU->getOperand(0))->getString();
          }
          insts.push_back(
              instruction(Store.str(), Update.str(), Energy, Timing));
        }
      }  // foreach instruction
      // write block
      File << block(BB, insts);
      // insert edge info
      succs.push_back(succ(BB));
      preds.push_back(pred(BB));
      // exit Block
    }
    File << "preds <- list(" << utility::concat(preds, ", ", ")\n");
    File << namePred(block_names);  // predecessors relations
    File << "succs <- list(" << utility::concat(succs, ", ", ")\n");
    File << nameSucc(block_names);                // successor relations
    File << edge(F);                              // edge probabilities
    File << block(block_names);                   // block names
    File << function(F, blocks, globals, types);  // function definition
    if (Execution == Intermittent || Execution == ETAP) {
      File << capacitorInitializer(capMin, capMax);
    }
    File << FileTemplate;           // profile file creation
    if (Execution == Intermittent)  // if Intermittent Execution
      File << IntermittentMachine;  // main Machine generated (CPU)
    else {
      if (BlockBased) {                   // if Normal Execution
        File << NormalBlockBasedMachine;  // main Machine generated (CPU)
      } else
        File << NormalInstructionBasedMachine;  // main Machine generated (CPU)
    }
    File << run(F);       // the triggers the Machine
    File << epilogue(F);  // epilogue
    if (PlotReturnValue.getValue())
      if (!F.getReturnType()->isVoidTy() && !F.getReturnType()->isPointerTy())
        File << PlotReturn;  // plot the result of the function
    File << PlotTiming;
    if (Execution == ETAP)  // attach ETAP analysis function
      File << ETAPMachine;
    // exit Function
    File.close();
  }  // end of Function
}

// -----------------------------------------------------------------------------
void prob::sym::Writer::execute(const llvm::Module& M) const {
  std::string scripts = "";

  if (FunctionName.empty())
    for (const llvm::Function& F : M) {
      // if it is a declaration just skip it.
      if (F.isDeclaration()) continue;
      scripts += ".output/" + F.getName().str() + ".sym.R ";
    }
  else
    for (const llvm::Function& F : M) {
      // if it is a declaration just skip it.
      if (F.isDeclaration()) continue;
      if (FunctionName == F.getName().str())
        scripts = ".output/" + F.getName().str() + ".sym.R ";
    }

  if (scripts.empty()) {
    std::cerr << "Error: there is no machine/function to run..." << std::endl;
    return;
  }

  // add --verbose -v switch...
  std::string cmd = "R --vanilla";
  std::string cat = "ulimit & cat " + scripts;
  //  std::string out = M.getName().str() + ".out";
  if (!Verbose) cmd = cmd + " > /dev/null 2>&1";
  std::string run = cat + " | " + cmd;
  std::cout << "  Executing: " << run << " ..." << std::endl;
  int i = std::system(run.c_str());
  if (i != 0) std::cerr << "System call returned: " << i << std::endl;
}

// -----------------------------------------------------------------------------
// generates base cfg graphs from the underlying llvm file
void prob::sym::Writer::cfg(const llvm::Module& M) const {
  // TODO: Generate cfg file through the system call...
  std::string cmd = "Rscript R/pfg.R";

  for (const llvm::Function& F : M) {
    // if it is a declaration just skip it.
    if (F.isDeclaration()) continue;
    // prepare the command
    std::string run = cmd + " " + F.getName().str();
    int i = std::system(run.c_str());
    if (i != 0) std::cerr << "System call returned: " << i << std::endl;
  }
}

// -----------------------------------------------------------------------------
// Generates probability flow graph
void prob::sym::Writer::pfg(const llvm::Module& M) const {
  for (const llvm::Function& F : M) {
    // if it is a declaration just skip it.
    if (F.isDeclaration()) continue;
    if (!FunctionName.empty() && FunctionName != F.getName().str()) continue;

    std::cout << "##" << F.getName().str() << std::endl;
    std::string idiom = GlobalIdiom ? "global" : "local";
    // -------------------------------------------------------------------------
    // try getting edge probabilities from the .prob file
    std::map<std::string, double> probabilities;
    {
      std::string p(".output/" + F.getName().str() + "." + idiom + ".prob");
      std::ifstream probs(p);
      std::string line;
      if (probs.is_open()) {
        while (getline(probs, line)) {
          std::smatch match;
          std::regex pattern("([\\w|.]*)(#)([\\w|.]*):.*( = )([\\d|.]*)");
          std::regex_search(line, match, pattern);
          if (match.empty() || match.size() != 6) continue;  // REVIEW here
          std::string path = match[1].str() + "#" + match[3].str();
          double probability = std::stod(match[5]);
          std::cout << path << " = " << probability << std::endl;
          probabilities.insert(std::make_pair(path, probability));
        }
        probs.close();
      } else
        std::cout << "couldn't open the \"" << p << "\"!" << std::endl;
    }
    // -------------------------------------------------------------------------
    // try getting block frequencies from the .freq file
    // a block frequency is the sum of probability of incoming edges
    std::map<std::string, double> frequencies;
    // the number of times a block visited
    std::map<std::string, double> block_visits;
    {
      std::string f(".output/" + F.getName().str() + ".freq");
      std::ifstream freqs(f);
      std::string line;
      if (freqs.is_open()) {
        while (getline(freqs, line)) {
          std::smatch match;
          // block:(1), frequency(2)
          std::regex pattern("([\\w|.]*):\\s*\\[(\\d*)\\]\\s*=\\s*([\\d|.]*)");
          std::regex_search(line, match, pattern);
          if (match.empty()) continue;
          std::string block = match[1].str();
          int count = std::stoi(match[2]);
          double frequency = std::stod(match[3]);
          std::cout << block << "[" << count << "] = " << frequency << "\n";
          block_visits.insert(std::make_pair(block, count));
          frequencies.insert(std::make_pair(block, frequency));
        }
        freqs.close();
      } else
        std::cout << "couldn't open the \"" << f << "\"!" << std::endl;
    }
    // -------------------------------------------------------------------------
    // open in file
    std::string f(".dots/.cfg." + F.getName().str() + ".dot");
    std::ifstream dot(f);
    // -------------------------------------------------------------------------
    // create an out file
    std::string o(".dots/.sym." + F.getName().str() + ".dot");
    std::ofstream out(o);
    // logic.
    std::string line;
    if (dot.is_open()) {
      while (getline(dot, line)) {
        // ---------------------------------------------------------------------
        // match label and pretty print it
        {
          std::smatch match;
          std::regex pattern("(label=)\"(CFG.*)\"");
          std::regex_search(line, match, pattern);
          if (!match.empty()) {
            // add formal parameters
            std::string returnType = utility::printType(F.getReturnType());
            std::string function = returnType + " " + F.getName().str() + "(" +
                                   formals(F, false) + ")";
            function = utility::replaceAll(function, "<-", "~");
            out << utility::replaceAll(line, match[2], function) << "\n";
            continue;
          }
        }
        // ---------------------------------------------------------------------
        // match block name as a node
        {
          std::smatch match;
          // block:(1), color(2), fillcolor(3), \l(4)
          std::regex pattern(
              "\"([\\w|.]*)\"\\s*\\[.*color=\"(#.*)\".*fillcolor=\"(#.*)\"\\s*,"
              "\\s*label=\".*?(\\l )");
          std::regex_search(line, match, pattern);
          // -------------------------------------------------------------------
          // change color and fill color
          if (!match.empty()) {
            std::string block = match[1];
            double frequency = 0;
            auto search = frequencies.find(block);
            if (search != frequencies.end()) {
              frequency = search->second;
            }
            double count = 0;
            search = block_visits.find(block);
            if (search != block_visits.end()) {
              count = search->second;
            }
            std::string edgeColor = utility::getHeatColor(frequency) + "ff";
            line = utility::replaceAll(line, match[2], edgeColor);
            std::string color = utility::getHeatColor(frequency) + "70";
            line = utility::replaceAll(line, match[3], color);
            utility::replace(line, match[4],
                             utility::getFrequency(frequency, count));
            out << line << "\n";
            continue;
          }
        }
        // ---------------------------------------------------------------------
        // match block name as an edge
        {
          std::smatch match;
          // from:(1), to(2), label(3), penwidth(4)
          std::regex pattern(
              "\"([\\w|.]*)\".*->\\s*\"([\\w|.]*)\".*label=\"([\\d|.]*%)\"\\s*"
              "penwidth(=[\\d|.]*)");
          std::regex_search(line, match, pattern);
          // -------------------------------------------------------------------
          // change label and penwidth
          if (!match.empty()) {
            std::string from = match[1];
            std::string to = match[2];
            auto search = probabilities.find(from + "#" + to);
            if (search != probabilities.end()) {
              std::string label = utility::getEdgeLabel(search->second);
              std::string penwidth =
                  "=" + utility::getEdgeWidth(search->second);
              line = utility::replaceAll(line, match[3], label);
              line = utility::replaceAll(line, match[4],
                                         penwidth);  // change to regex replace
            }
            out << line << "\n";
            continue;
          }
        }
        // match block name as an edge (no label)
        {
          std::smatch match;
          // from:(1), to(2), penwidth(3)
          std::regex pattern(
              "\"([\\w|.]*)\".*->\\s*\"([\\w|.]*)\".*(penwidth=[\\d|.]*)");
          std::regex_search(line, match, pattern);
          // -------------------------------------------------------------------
          // change label and penwidth
          if (!match.empty()) {
            std::string from = match[1];
            std::string to = match[2];
            auto search = probabilities.find(from + "#" + to);
            if (search != probabilities.end()) {
              std::string penwidth =
                  "penwidth=" + utility::getEdgeWidth(search->second);
              if (search->second != 1)
                penwidth =
                    "label=\"" + utility::getEdgeLabel(search->second) +
                    "\" penwidth=" + utility::getEdgeWidth(search->second);
              line = utility::replaceAll(line, match[3], penwidth);
            }
            out << line << "\n";
            continue;
          }
        }
        // ---------------------------------------------------------------------
        // print the rest as is
        out << line << "\n";
      }  // end of while
      dot.close();
      out.close();
      // convert dot file to svg
      svg(o);
      open(o);
      pdf(o);  // ToDo: you can remove this later.
    } else
      std::cout << "couldn't open the dot file!" << std::endl;
  }
}

// -----------------------------------------------------------------------------
void prob::sym::Writer::svg(const std::string& file) const {
  std::string cmd =
      "dot -Tsvg -Nfontname=Roboto -Nfontsize=10 -Efontname=Roboto "
      "-Efontsize=10 -Gfontname=Roboto -Gfontsize=12 -O ";
  std::string run = cmd + " " + file;
  int i = std::system(run.c_str());
  if (i != 0) std::cerr << "System call returned: " << i << std::endl;
}

// -----------------------------------------------------------------------------
void prob::sym::Writer::pdf(const std::string& file) const {
  std::string cmd =
      "dot -Tpdf -Nfontname=Roboto -Nfontsize=10 -Efontname=Roboto "
      "-Efontsize=10 -Gfontname=Roboto -Gfontsize=12 -O ";
  std::string run = cmd + " " + file;
  int i = std::system(run.c_str());
  if (i != 0) std::cerr << "System call returned: " << i << std::endl;
}

// -----------------------------------------------------------------------------
void prob::sym::Writer::open(const std::string& file) const {
  std::string cmd = "xdg-open";
  std::string suffix = ">/dev/null 2>&1 &";
  std::string run = cmd + " " + file + ".svg" + suffix;
  int i = std::system(run.c_str());
  if (i != 0) std::cerr << "System call returned: " << i << std::endl;
}

// -----------------------------------------------------------------------------
std::string prob::sym::Writer::qualified(const llvm::BasicBlock& BB) const {
  return "block." + BB.getName().str();
}

// -----------------------------------------------------------------------------
static llvm::RegisterPass<prob::sym::Writer> X(
    "prob-sym-exec-writer", "Probabilistic Symbolic Execution Writer", false,
    true);

// -----------------------------------------------------------------------------
// R functions to get block-based models
std::string prob::sym::Writer::BlockBasedFunctions =
    "energy <- rlang::env()\n"
    "\n"
    "E <- function(func, bloc) {\n"
    "  func <- deparse(substitute(func))\n"
    "  bloc <- deparse(substitute(bloc))\n"
    "  if (func %in% names(energy))\n"
    "    if (bloc %in% names(energy[[func]]))\n"
    "      return(energy[[func]][[bloc]])\n"
    "  warning(paste0(\"no energy model for \", func, \"$\", bloc, \"!\"))\n"
    "  return(0)\n"
    "}\n"
    "\n"
    "timing <- rlang::env()\n"
    "\n"
    "T <- function(func, bloc) {\n"
    "  func <- deparse(substitute(func))\n"
    "  bloc <- deparse(substitute(bloc))\n"
    "  if (func %in% names(timing))\n"
    "    if (bloc %in% names(timing[[func]]))\n"
    "      return(timing[[func]][[bloc]])\n"
    "  warning(paste0(\"no timing model for \", func, \"$\", bloc, \"!\"))\n"
    "  return(0)\n"
    "}\n";

// -----------------------------------------------------------------------------
// R functions to get instruction-based models
std::string prob::sym::Writer::InstructionBasedFunctions =
    "energy <- rlang::env()\n"
    "\n"
    "E <- function(inst) {\n"
    "  inst <- deparse(substitute(inst))\n"
    "  if (inst %in% names(energy))\n"
    "    return(energy[[inst]])\n"
    "  else if (\"default\" %in% names(energy))\n"
    "    return(energy$default)\n"
    "  else return(0)\n"
    "}\n"
    "\n"
    "timing <- rlang::env()\n"
    "\n"
    "T <- function(inst) {\n"
    "  inst <- deparse(substitute(inst))\n"
    "  if (inst %in% names(timing))\n"
    "    return(timing[[inst]])\n"
    "  else if (\"default\" %in% names(timing))\n"
    "    return(timing$default)\n"
    "  else return(0)\n"
    "}\n";

// -----------------------------------------------------------------------------
// R functions to add to meta.R ToDo: You may need to revise here later.
std::string prob::sym::Writer::CheckpointRestoreForNormalExecution =
    "checkpoint <- function() { }\n"
    "restore <- function() { }\n";

// -----------------------------------------------------------------------------
// R counterparts of Machine commands
std::string prob::sym::Writer::MetaFunctions =
    //    "Rcpp::sourceCpp(\".output/meta.cpp\")\n"
    "options(useFancyQuotes = FALSE)\n"
    "\n"
    "rm(list = setdiff(ls(), lsf.str()))\n"
    "sym <- rlang::env()\n"
    "global <- rlang::env()\n"
    "stack <- rlang::env()\n"
    "heap <- rlang::env()\n"
    "nv <- rlang::env()\n"
    "typ <- rlang::env()\n"
    "memptrs <- rlang::env(\"heap\" = 0, \"stack\" = 0, \"global\" = 0)\n"
    "\n"
    "false <- 0\n"
    "true <- 1\n"
    "null <- NULL\n"
    "\n"
    "# zext\n"
    "zext <- function(from, value, to) value\n"
    "\n"
    "# fpext\n"
    "fpext <- function(from, value, to) value\n"
    "\n"
    "# sext\n"
    "\n"
    "# <result> = add <ty> <var1>, <var2>gg\n"
    "add <- function(var1, var2) var1 + var2\n"
    "sub <- function(var1, var2) var1 - var2\n"
    "mul <- function(var1, var2) var1 * var2\n"
    "div <- function(var1, var2) var1 / var2\n"
    "rem <- function(var1, var2) var1 %% var2\n"
    "sin <- function(val) base::sin(val)\n"
    "cos <- function(val) base::cos(val)\n"
    "\n"
    "ret <- function(value) {\n"
    "  print(value)\n"
    "  if (is.numeric(value)) value <- distr::DiscreteDistribution(value)\n"
    "  return(value)\n"
    "}\n"
    "\n"
    "# always returns pointer\n"
    "bitcast <- function(from, value, to) value\n"
    "\n"
    "resolveType <- function(type) {\n"
    "  if (length(grep(\"\\\\*$\", type, perl = TRUE))) return(\"1\") # if "
    "type is a pointer, return size of a one mem loc\n"
    "\n"
    "  while (length(grep(\"(%struct\\\\..*)|\\\\[\\\\d+ x "
    "(%struct\\\\..*)\\\\]\", type, perl = TRUE))) { # the case where there is "
    "no `struct`\n"
    "    structname <- regmatches(type, "
    "regexpr(\"(%struct\\\\.[a-zA-Z0-9_%-]+)\", type, perl = TRUE))\n"
    "    type <- gsub(structname, paste0(\"[\", typ[[structname]], \"]\"), "
    "type)\n"
    "  }\n"
    "  while (length(grep(\"(%union\\\\..*)|\\\\[\\\\d+ x "
    "(%union\\\\..*)\\\\]\", type, perl = TRUE))) { # the case where there is "
    "no `union`\n"
    "    unionname <- regmatches(type, "
    "regexpr(\"(%union\\\\.[a-zA-Z0-9_%-]+)\", type, perl = TRUE))\n"
    "    type <- gsub(unionname, paste0(\"[\", typ[[unionname]], \"]\"), "
    "type)\n"
    "  }\n"
    "  return(type)\n"
    "}\n"
    "\n"
    "calcSize <- function(typestr) {\n"
    "  typestr <- gsub(\"i(\\\\d+)|double|float\", \"1\", typestr)\n"
    "  typestr <- gsub(\"x\", '\\\\*', typestr)\n"
    "  typestr <- gsub(\",\", '\\\\+', typestr)\n"
    "  typestr <- gsub(\"\\\\[\", '\\\\(', typestr)\n"
    "  typestr <- gsub(\"\\\\]\", '\\\\)', typestr)\n"
    "  typestr <- gsub(\"\\\\w+\\\\*\", \"1\", typestr)\n"
    "  return(eval(str2expression(typestr)))\n"
    "}\n"
    "\n"
    "alloca <- function(type, ...) {\n"
    "  values <- list(...)\n"
    "  ptrLocToReturn <- memptrs$\"stack\" # remember first mem loc\n"
    "\n"
    "  if (!length(values)) # if values are not pre-defined\n"
    "    values <- rep(0, calcSize(resolveType(type))) # create a list with "
    "size of type and init value of 0\n"
    "\n"
    "  for (i in values) { # insert values into the memory slots\n"
    "    stack[[toString(memptrs$\"stack\")]] <- eval.parent(i)\n"
    "    memptrs$\"stack\" <- memptrs$\"stack\" + 1\n"
    "  }\n"
    "  return(paste0(\"stack$\", dQuote(toString(ptrLocToReturn))))\n"
    "}\n"
    "\n"
    "gep <- function(type, addr, ...) {\n"
    "  # extract addr to be incremented and memory region\n"
    "  parsedAddrList <- regmatches(addr, gregexpr(\"(\\\\w+)\", addr))\n"
    "  region <- parsedAddrList[[1]][[1]]\n"
    "  addr <- as.integer(parsedAddrList[[1]][[2]])\n"
    "  # evaluate index if its a variable\n"
    "  indices <- list(...)\n"
    "  typeSize <- 0\n"
    "  for (i in seq_along(indices)) {\n"
    "    indices[[i]] <- "
    "as.integer(eval.parent(str2expression(deparse(substitute(indices[[i]])))))"
    "\n"
    "  }\n"
    "  addr <- indices[[1]] + addr\n"
    "\n"
    "  if (length(indices) > 1) {\n"
    "\n"
    "    for (i in 2:length(indices)) {\n"
    "      if (length(grep(\"(\\\\[.*\\\\])\", type)) && substr(type, "
    "nchar(type), nchar(type)) != \"*\") {\n"
    "        replaceStr <- paste(\"(\", indices[[i]], \") x \")\n"
    "        calcStr <- type\n"
    "        if (length(grep(\"(%struct\\\\..*)\", type))) {\n"
    "          calcStr <- base::sub(\"(%struct\\\\..*)\", "
    "paste0(calcSize(resolveType(regmatches(type, "
    "regexpr(\"%struct\\\\..+(?<![\\\\]\\\\)*])\", type, perl = TRUE)))), "
    "\"]\"), type)\n"
    "        }\n"
    "        calcStr <- base::sub(\"(\\\\d+) x \", replaceStr, calcStr)\n"
    "        typeSize <- calcSize(calcStr) + typeSize\n"
    "        type <- base::sub(\"\\\\d+ x \", \"\", type)\n"
    "        type <- substr(type, 2, nchar(type) - 1)\n"
    "      }\n"
    "      else if (length(grep(\"(%struct\\\\..*)\", type)) && substr(type, "
    "nchar(type), nchar(type)) != \"*\") {\n"
    "        type <- typ[[type]]\n"
    "        s <- trimws(strsplit(type, \",\")[[1]])\n"
    "        index <- 0\n"
    "        while (index < indices[[i]]) {\n"
    "          typeSize <- typeSize + calcSize(resolveType(s[[index + 1]]))\n"
    "          index <- index + 1\n"
    "        }\n"
    "        type <- s[[indices[[i]] + 1 ]]\n"
    "      }else if (length(grep(\"(\\\\{.*\\\\})\", type))) {\n"
    "        typeSize <- typeSize + indices[[i]]\n"
    "      }\n"
    "      else {\n"
    "        typeSize <- calcSize(type) + typeSize\n"
    "      }\n"
    "    }\n"
    "\n"
    "  }\n"
    "\n"
    "  addr <- addr + typeSize\n"
    "  return(paste0(region, \"$\", dQuote(addr)))\n"
    "}\n"
    "\n"
    "store <- function(val, ptr) {\n"
    "  "
    "eval.parent(str2expression(paste0(eval.parent(str2expression(deparse("
    "substitute(ptr)))), \"<-\", deparse(substitute(val)))))\n"
    "}\n"
    "\n"
    "load <- function(ptr) {\n"
    "  return(eval.parent(str2expression(ptr)))\n"
    "}\n"
    "\n"
    "memcmp <- function(ptr1, ptr2, n) {\n"
    "  ptr1ParsedAddrList <- regmatches(ptr1, gregexpr(\"(\\\\w+)\", ptr1))\n"
    "  ptr1Region <- ptr1ParsedAddrList[[1]][[1]]\n"
    "  ptr1Addr <- as.integer(ptr1ParsedAddrList[[1]][[2]])\n"
    "  ptr2ParsedAddrList <- regmatches(ptr2, gregexpr(\"(\\\\w+)\", ptr2))\n"
    "  ptr2Region <- ptr2ParsedAddrList[[1]][[1]]\n"
    "  ptr2Addr <- as.integer(ptr2ParsedAddrList[[1]][[2]])\n"
    "  for (i in 0:(n - 1)) {\n"
    "    p1 <- ptr1Addr + i\n"
    "    p2 <- ptr2Addr + i\n"
    "    x <- eval.parent(str2expression(paste0(ptr1Region, \"$\", "
    "dQuote(toString(p1)))))\n"
    "    y <- eval.parent(str2expression(paste0(ptr2Region, \"$\", "
    "dQuote(toString(p2)))))\n"
    "    if (x > y || is.null(y)) return(1)\n"
    "    if (x < y || is.null(x)) return(-1)\n"
    "  }\n"
    "  return(0)\n"
    "}\n"
    "memcpy <- function(destPtr, srcPtr, type) {\n"
    "  size <- calcSize(resolveType(type))\n"
    "  destParsedAddrList <- regmatches(destPtr, gregexpr(\"(\\\\w+)\", "
    "destPtr))\n"
    "  destRegion <- destParsedAddrList[[1]][[1]]\n"
    "  destAddr <- destParsedAddrList[[1]][[2]]\n"
    "  srcParsedAddrList <- regmatches(srcPtr, gregexpr(\"(\\\\w+)\", "
    "srcPtr))\n"
    "  srcRegion <- srcParsedAddrList[[1]][[1]]\n"
    "  srcAddr <- srcParsedAddrList[[1]][[2]]\n"
    "\n"
    "  for (i in 0:(size - 1)) {\n"
    "    d <- as.integer(destAddr) + i\n"
    "    s <- as.integer(srcAddr) + i\n"
    "    eval.parent(str2expression(paste0(destRegion, \"$\", "
    "dQuote(toString(d)), \" <- \", eval(str2expression(paste0(srcRegion, "
    "\"$\", dQuote(toString(s))))))))\n"
    "  }\n"
    "}\n"
    "\n"
    "malloc <- function(size) {\n"
    "  ptrLocToReturn <- memptrs$\"heap\" # remember ptr location\n"
    "  memptrs$\"heap\" <- memptrs$\"heap\" + size # increment the heap "
    "pointer with the size\n"
    "\n"
    "  return(paste0(\"heap$\", dQuote(ptrLocToReturn)))\n"
    "}\n"
    "\n"
    "free <- function(ptr) { }\n"
    "\n"
    "galloc <- function(type, ...) {\n"
    "  values <- list(...) # create a list of values from ellipsis\n"
    "  ptrLocToReturn <- memptrs$\"global\" # remember ptr location\n"
    "\n"
    "  for (i in values) {\n"
    "    global[[toString(memptrs$\"global\")]] <- eval.parent(i) # insert "
    "values into global mem locs\n"
    "\n"
    "    memptrs$\"global\" <- memptrs$\"global\" + 1 # increment the pointer\n"
    "  }\n"
    "\n"
    "  return(paste0(\"global$\", dQuote(toString(ptrLocToReturn))))\n"
    "}\n"
    "\n"
    "\n"
    "eq <- \"eq\"\n"
    "ne <- \"ne\"\n"
    "ugt <- \"ugt\"\n"
    "uge <- \"uge\"\n"
    "ult <- \"ult\"\n"
    "ule <- \"ule\"\n"
    "sgt <- \"sgt\"\n"
    "sge <- \"sge\"\n"
    "slt <- \"slt\"\n"
    "sle <- \"sle\"\n"
    "\n"
    "# https://llvm.org/docs/LangRef.html#icmp-instruction\n"
    "icmp <- function(cond, left, right) {\n"
    "  # EXAMPLE ------------------------------\n"
    "  # F(x ≤ 3) = F(x ≤ 3)\n"
    "  # F(x < 3) = F(x ≤ 2)\n"
    "  # F(x = 3) = F(x ≤ 3) - F(x ≤ 2)\n"
    "  # F(x ≠ 3) = 1 - F(x ≤ 3) + F(x ≤ 2)\n"
    "  # F(x > 3) = 1 - F(x ≤ 3)\n"
    "  # F(x ≥ 3) = 1 - F(x < 3) = 1 - F(x ≤ 2)\n"
    "  # --------------------------------------\n"
    "  # null comparison\n"
    "  if (is.null(left) || is.null(right)) {\n"
    "    # if (null == null)\n"
    "    if (cond == eq) {\n"
    "      if (is.null(left) && is.null(right))\n"
    "        return(c(1, 0, 0))\n"
    "      else\n"
    "        return(c(0, 0, 0))\n"
    "    }\n"
    "    # if (null != null)\n"
    "    else if (cond == ne) {\n"
    "      if (is.null(left) && is.null(right))\n"
    "        return(c(0, 0, 0))\n"
    "      else\n"
    "        return(c(1, 0, 0))\n"
    "    }\n"
    "  }\n"
    "  # pointer comparison\n"
    "  if (is.character(left) || is.character(right)) {\n"
    "    # if (pointer == pointer)\n"
    "    if (cond == \"eq\") {\n"
    "      if (left == right)\n"
    "        return(c(1, 0, 0))\n"
    "      else\n"
    "        return(c(0, 0, 0))\n"
    "    }\n"
    "    # if (pointer != pointer)\n"
    "    else if (cond == \"ne\") {\n"
    "      if (left != right)\n"
    "        return(c(1, 0, 0))\n"
    "      else\n"
    "        return(c(0, 0, 0))\n"
    "    }\n"
    "  }\n"
    "  cmp <- left - right;\n"
    "  if (is.numeric(cmp)) cmp <- distr::DiscreteDistribution(cmp);\n"
    "  cmp.true <- cmp; cmp.false <- cmp\n"
    "  # F(x ≤ 0) = F(x ≤ 0)\n"
    "  if (cond == sle || cond == ule) {\n"
    "    mass <- distr::p(cmp)(0)\n"
    "    if (1 > mass && mass > 0) {\n"
    "      cmp.true <- distr::Truncate(cmp, lower = -Inf, upper = 0)\n"
    "      cmp.false <- distr::Truncate(cmp, lower = 1, upper = Inf)\n"
    "    }\n"
    "    return(c(mass, cmp.true, cmp.false))\n"
    "  }\n"
    "  # F(x < 0) = F(x ≤ -1)\n"
    "  if (cond == slt || cond == ult) {\n"
    "    mass <- distr::p(cmp)(-1)\n"
    "    if (1 > mass && mass > 0) {\n"
    "      cmp.true <- distr::Truncate(cmp, lower = -Inf, upper = -1)\n"
    "      cmp.false <- distr::Truncate(cmp, lower = 0, upper = Inf)\n"
    "    }\n"
    "    return(c(mass, cmp.true, cmp.false))\n"
    "  }\n"
    "  # F(x = 0) = F(x ≤ 0) - F(x ≤ -1)\n"
    "  if (cond == eq) {\n"
    "    mass <- distr::p(cmp)(0) - distr::p(cmp)(-1)\n"
    "    if (1 > mass && mass > 0) {\n"
    "      cmp.true <- distr::DiscreteDistribution(0)\n"
    "      support <- distr::support(cmp)\n"
    "      prob <- distr::prob(cmp)[[match(0, distr::support(cmp))]] / "
    "(length(support) - 1)\n"
    "      distribute <- function(x) x + prob\n"
    "      probs <- lapply(distr::prob(cmp)[-match(0, support)], FUN = "
    "distribute)\n"
    "      cmp.false <- distr::DiscreteDistribution(supp = "
    "distr::support(cmp)[distr::support(cmp) != 0], prob = unlist(probs))\n"
    "    }\n"
    "    return(c(mass, cmp.true, cmp.false))\n"
    "  }\n"
    "  # F(x ≠ 0) = 1 - F(x ≤ 0) + F(x ≤ -1)\n"
    "  if (cond == ne) {\n"
    "    mass <- 1 - distr::p(cmp)(0) + distr::p(cmp)(-1)\n"
    "    if (1 > mass && mass > 0) {\n"
    "      cmp.false <- distr::DiscreteDistribution(0)\n"
    "      support <- distr::support(cmp)\n"
    "      prob <- distr::prob(cmp)[[match(0, distr::support(cmp))]] / "
    "(length(support) - 1)\n"
    "      distribute <- function(x)x + prob\n"
    "      probs <- lapply(distr::prob(cmp)[-match(0, support)], FUN = "
    "distribute)\n"
    "      cmp.true <- distr::DiscreteDistribution(supp = "
    "distr::support(cmp)[distr::support(cmp) != 0], prob = unlist(probs))\n"
    "    }\n"
    "    return(c(mass, cmp.true, cmp.false))\n"
    "  }\n"
    "  # F(x > 0) = 1 - F(x ≤ 0)\n"
    "  if (cond == sgt || cond == ugt) {\n"
    "    mass <- 1 - distr::p(cmp)(0)\n"
    "    if (1 > mass && mass > 0) {\n"
    "      cmp.true <- distr::Truncate(cmp, lower = 1, upper = Inf)\n"
    "      cmp.false <- distr::Truncate(cmp, lower = -Inf, upper = 0)\n"
    "    }\n"
    "    return(c(mass, cmp.true, cmp.false))\n"
    "  }\n"
    "  # F(x ≥ 0) = 1 - F(x < 0) = 1 - F(x ≤ -1)\n"
    "  if (cond == sge || cond == uge) {\n"
    "    mass <- 1 - distr::p(cmp)(0)\n"
    "    if (1 > mass && mass > 0) {\n"
    "      cmp.true <- distr::Truncate(cmp, lower = 0, upper = Inf)\n"
    "      cmp.false <- distr::Truncate(cmp, lower = -Inf, upper = -0.1)\n"
    "    }\n"
    "    return(c(mass, cmp.true, cmp.false))\n"
    "  }\n"
    "  stop(\"unknown cond in llvm::icmp!\")\n"
    "}\n"
    "\n"
    "oeq <- \"oeq\"\n"
    "ogt <- \"ogt\"\n"
    "oge <- \"oge\"\n"
    "olt <- \"olt\"\n"
    "ole <- \"ole\"\n"
    "one <- \"one\"\n"
    "ord <- \"ord\"\n"
    "ueq <- \"ueq\"\n"
    "une <- \"une\"\n"
    "uno <- \"uno\"\n"
    "\n"
    "# https://llvm.org/docs/LangRef.html#fcmp-instruction\n"
    "fcmp <- function(cond, left, right) {\n"
    "  # EXAMPLE ------------------------------\n"
    "  # F(x ≤ 3) = F(x ≤ 3.01)\n"
    "  # F(x < 3) = F(x ≤ 2.99)\n"
    "  # F(x = 3) = F(x ≤ 3.01) - F(x ≤ 2.99)\n"
    "  # F(x ≠ 3) = 1 - F(x = 3) = 1 - F(x ≤ 3.01) + F(x ≤ 2.99)\n"
    "  # F(x > 3) = 1 - F(x ≤ 3) = 1 - F(x ≤ 3.01)\n"
    "  # F(x ≥ 3) = 1 - F(x < 3) = 1 - F(x ≤ 2.99)\n"
    "  # --------------------------------------\n"
    "  # null comparison\n"
    "  if (is.null(left) || is.null(right)) {\n"
    "    # if (null == null)\n"
    "    if (cond == eq) {\n"
    "      if (is.null(left) && is.null(right))\n"
    "        return(c(1, 0, 0))\n"
    "      else\n"
    "        return(c(0, 0, 0))\n"
    "    }\n"
    "    # if (null != null)\n"
    "    else if (cond == ne) {\n"
    "      if (is.null(left) && is.null(right))\n"
    "        return(c(0, 0, 0))\n"
    "      else\n"
    "        return(c(1, 0, 0))\n"
    "    }\n"
    "  }\n"
    "  # pointer comparison\n"
    "  if (is.character(left) || is.character(right)) {\n"
    "    # if (pointer == pointer)\n"
    "    if (cond == \"eq\") {\n"
    "      if (left == right)\n"
    "        return(c(1, 0, 0))\n"
    "      else\n"
    "        return(c(0, 0, 0))\n"
    "    }\n"
    "    # if (pointer != pointer)\n"
    "    else if (cond == \"ne\") {\n"
    "      if (left != right)\n"
    "        return(c(1, 0, 0))\n"
    "      else\n"
    "        return(c(0, 0, 0))\n"
    "    }\n"
    "  }\n"
    "  delta <- 0.01\n"
    "  cmp <- left - right;\n"
    "  if (is.numeric(cmp))cmp <- distr::DiscreteDistribution(cmp);\n"
    "  cmp.true <- cmp; cmp.false <- cmp\n"
    "  # F(x ≤ 0) = F(x ≤ 0.01)\n"
    "  if (cond == ule || cond == ole) {\n"
    "    mass <- distr::p(cmp)(delta)\n"
    "    if (1 > mass && mass > 0) {\n"
    "      cmp.true <- distr::Truncate(cmp, lower = -Inf, upper = 0)\n"
    "      cmp.false <- distr::Truncate(cmp, lower = 0, upper = Inf)\n"
    "    }\n"
    "    return(c(mass, cmp.true, cmp.false))\n"
    "  }\n"
    "  # F(x < 0) = F(x ≤ -0.01)\n"
    "  if (cond == ult || cond == olt) {\n"
    "    mass <- distr::p(cmp)(-delta)\n"
    "    if (1 > mass && mass > 0) {\n"
    "      cmp.true <- distr::Truncate(cmp, lower = -Inf, upper = 0)\n"
    "      cmp.false <- distr::Truncate(cmp, lower = 0, upper = Inf)\n"
    "    }\n"
    "    return(c(mass, cmp.true, cmp.false))\n"
    "  }\n"
    "  # F(x = 0) = F(x ≤ 0.01) - F(x ≤ -0.01)\n"
    "  if (cond == ueq || cond == oeq) {\n"
    "    cmp.true <- distr::DiscreteDistribution(0)\n"
    "    cmp.false <- cmp\n"
    "    return(c(distr::p(cmp)(delta) - distr::p(cmp)(-delta), cmp.true, "
    "cmp.false))\n"
    "  }\n"
    "  # F(x ≠ 0) = 1 - F(x = 0) = 1 - F(x ≤ 0.01) + F(x ≤ -0.01)\n"
    "  if (cond == une || cond == one) {\n"
    "    cmp.false <- distr::DiscreteDistribution(0)\n"
    "    cmp.true <- cmp\n"
    "    return(c(1 - distr::p(cmp)(delta) + distr::p(cmp)(-delta), cmp.true, "
    "cmp.false))\n"
    "  }\n"
    "  # F(x > 0) = 1 - F(x ≤ 0) = 1 - F(x ≤ 0.01)\n"
    "  if (cond == ugt || cond == ogt) {\n"
    "    mass <- 1 - distr::p(cmp)(delta)\n"
    "    if (1 > mass && mass > 0) {\n"
    "      cmp.true <- distr::Truncate(cmp, lower = 0, upper = Inf)\n"
    "      cmp.false <- distr::Truncate(cmp, lower = -Inf, upper = 0)\n"
    "    }\n"
    "    return(c(mass, cmp.true, cmp.false))\n"
    "  }\n"
    "  # F(x ≥ 0) = 1 - F(x < 0) = 1 - F(x ≤ -0.01)\n"
    "  if (cond == uge || cond == oge) {\n"
    "    mass <- 1 - distr::p(cmp)(-delta)\n"
    "    if (1 > mass && mass > 0) {\n"
    "      cmp.true <- distr::Truncate(cmp, lower = 0, upper = Inf)\n"
    "      cmp.false <- distr::Truncate(cmp, lower = -Inf, upper = 0)\n"
    "    }\n"
    "    return(c(mass, cmp.true, cmp.false))\n"
    "  }\n"
    "  # FALSE\n"
    "  if (cond == false) {\n"
    "    return(c(0.00, cmp.true, cmp.false))\n"
    "  }\n"
    "  # TRUE\n"
    "  if (cond == true) {\n"
    "    return(c(1.00, cmp.true, cmp.false))\n"
    "  }\n"
    "  stop(\"unknown cond in llvm::fcmp!\")\n"
    "}\n"
    "\n"
    "# https://llvm.org/docs/LangRef.html#br-instruction\n"
    "br <- function(iftrue, iffalse, cond) {\n"
    "  t_name <- deparse(substitute(iftrue))\n"
    "  if (missing(iffalse)) { #unconditional branch\n"
    "    eval.parent(str2expression(paste0(.block$name, \"_\", t_name, \" <- "
    "round(1.00)\")))\n"
    "  } else { #conditional branch\n"
    "    f_name <- deparse(substitute(iffalse))\n"
    "    c_name <- deparse(substitute(cond))\n"
    "    eval.parent(str2expression(paste0(.block$name, \"_\", t_name, \" <- "
    "\", cond[1])))\n"
    "    eval.parent(str2expression(paste0(.block$name, \"_\", f_name, \" <- 1 "
    "- \", cond[1])))\n"
    "    if (length(cond) > 1) { # this for those cases where phi being used "
    "before br.\n"
    "      if (length(grep(\"sym\\\\$\\\\\\\".*?\\\\\\\"\", c_name))) { # "
    "sym$\\\"2\\\".true => sym$\\\"2.true\\\"\n"
    "        varT <- gsub(\"(sym\\\\$\\\\\\\")(.*?)(\\\\\\\")\", "
    "\"\\\\1\\\\2.true\\\\3\", c_name)\n"
    "        varF <- gsub(\"(sym\\\\$\\\\\\\")(.*?)(\\\\\\\")\", "
    "\"\\\\1\\\\2.true\\\\3\", c_name)\n"
    "        eval.parent(str2expression(paste0(varT, \" <- \", c_name, "
    "\"[[2]]\")))\n"
    "        eval.parent(str2expression(paste0(varF, \" <- \", c_name, "
    "\"[[3]]\")))\n"
    "      } else {\n"
    "        eval.parent(str2expression(paste0(c_name, \".true <- \", c_name, "
    "\"[[2]]\")))\n"
    "        eval.parent(str2expression(paste0(c_name, \".false <- \", c_name, "
    "\"[[3]]\")))\n"
    "      }\n"
    "    }\n"
    "  }\n"
    "  eval.parent(str2expression(paste0(.block$name, \" <- TRUE\")))\n"
    "  for (pred in .block$preds) {\n"
    "    eval.parent(str2expression(paste0(pred, \" <- FALSE\")))\n"
    "  }\n"
    "}\n"
    "\n"
    "memory <- function(...) alloca(null, ...)\n"
    "Mixing <- function(...) distr::UnivarMixingDistribution(...)\n"
    //    "alert  <- function() { }\n"
    //    "error  <- function() { }\n"
    //    "featurize  <- function() { }\n"
    "\n";
