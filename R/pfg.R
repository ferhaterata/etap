#!/usr/bin/env Rscript
library("stringr")
library("readr")

cmdArgs <- commandArgs(TRUE)
method <- cmdArgs[1]

pattern_blockname <- "(?<=\\=\"\\{)(.+?)(?=[\\}\\|:])"
pattern_nodename <- "(Node)(.+?)(?=[ \\[|:])"

fromNodetoBasicBlock <- function(method) {
  lines <- readLines(method)
  for (i in seq_along(lines)) {
    if (str_detect(lines[i], pattern = pattern_nodename)) {
      nodename <- str_extract(lines[i], pattern = pattern_nodename)
      if (str_detect(lines[i], pattern = pattern_blockname))
        blockname <- str_extract(lines[i], pattern_blockname)
      else next
      lines <- str_replace_all(lines, pattern = paste0("(", nodename, ")"), replacement = paste0("\"", blockname, "\""))
    }
  }
  writeLines(lines, con = method)
}

fromNodetoBasicBlock(paste0(".dots/.cfg.", method, ".dot"))


