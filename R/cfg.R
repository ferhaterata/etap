#!/usr/bin/env Rscript
options("StartupBanner" = "off")
library("distr")
library("distrEx")
library("stringr")
library("readr")
distroptions("WarningArith" = FALSE)

inc <- function(x) eval.parent(substitute(x <- x + 1))
openHTML <- function(x) browseURL(paste0('file://', file.path(getwd(), x)))

svgStyle <- "
  <style>
  .node:hover {
  fill: #a9a9a9;
  opacity: 0.9;
  }

  .node:target polygon{
  fill: none;
  stroke: black;
  }

  .node:target polyline{
  fill: none;
  stroke: black;
  }
  </style>
  </svg>
  "
pattern_blockname <- "(?<=\\=\"\\{)(.+?)(?=[\\}\\|:])"
pattern_nodename <- "(Node)(.+?)(?=[ \\[|:])"

pattern_svg_node <- "(?<=\\<g id\\=\")(.+?)(?=\" class\\=\"node\"\\>)"
pattern_svg_title <- "(?<=\\<title\\>)(.+?)(?=\\</title\\>)"

fromNodetoBasicBlock <- function(x) {
  lines <- readLines(x)
  for (i in seq_along(lines)) {
    if (str_detect(lines[i], pattern = pattern_nodename)) {
      nodename <- str_extract(lines[i], pattern = pattern_nodename)
      if (str_detect(lines[i], pattern = pattern_blockname))
        blockname <- str_extract(lines[i], pattern_blockname)
      else next
      lines <- str_replace_all(lines, pattern = paste0("(", nodename, ")"), replacement = paste0("\"", blockname, "\""))
    }
  }
  writeLines(lines, con = x)
}

fromNodetoTitleInSvg <- function(x) {
  lines <- readLines(x)
  for (i in seq_along(lines)) {
    if (str_detect(lines[i], pattern = pattern_svg_title)) {
      title <- str_extract(lines[i], pattern = pattern_svg_title)
      if (str_detect(lines[i - 1], pattern = pattern_svg_node)) {
        node <- str_extract(lines[i - 1], pattern = pattern_svg_node)
        lines[i - 1] <- str_replace(lines[i - 1], pattern = paste0("(", node, ")"), replacement = title)
      }
    }
  }
  writeLines(lines, con = x)
}

appendStyle <- function(x) {
  text <- read_file(file = x)
  if (str_detect(text, "(</svg>)")) {
    change <- str_replace(text, "(</svg>)", svgStyle)
    writeLines(change, con = x)
  }
  else
    warning(paste0("svn is errorous!: ", x))
  x
}


readBBCostFile <- function(filename) {
  method <- strsplit(filename, "/|\\.")
  method <- unlist(method)
  method <- paste0(".", method[3])

  data <- readLines(filename)
  cnt <- 0
  for (i in seq_along(data)) {
    line <- strsplit(data[i], ":")
    line <- unlist(line)
    if (line[1] == "basicblock") {
      Name <- trimws(line[2])
      inc(cnt)
    }
    if (line[1] == "timing") {
      Timing <- eval(parse(text = trimws(line[2])))
      inc(cnt)
    }
    if (line[1] == "energy") {
      Energy <- eval(parse(text = trimws(line[2])))
      inc(cnt)
    }

    if (cnt == 3) {

      color <- sample(hcl.colors(100, palette = "Berlin"), 1)
      #color <- sample(grDevices::colors()[grep('gr(a|e)y', grDevices::colors(), invert = T)], 1)
      #color <- rgb(sample(0:255, 1), sample(0:255, 1), sample(0:255, 1), maxColorValue = 255)

      newDotFile <- paste0(".dots/", method, "/timing/", Name, ".svg")
      dir.create(dirname(newDotFile), showWarnings = FALSE, recursive = TRUE)

      svg(newDotFile)
      opar <- par()      # make a copy of current settings
      par(col = color)
      plot(Timing, to.draw.arg = "d", mfColRow = FALSE, bty = "7", panel.first = grid(lwd = 2), lwd = 2, vertical = FALSE,
           inner = list(paste("Probability Function of ", Name)), col.points = c("red", "black"), cex.points = 1.8, xlab = "")
      title(xlab = paste0("E(x) = ", round(E(Timing), 2), "  Var(x) = ", round(var(Timing), 2)))
      par(opar)          # restore original settings
      dev.off()

      newDotFile <- paste0(".dots/", method, "/energy/", Name, ".svg")
      dir.create(dirname(newDotFile), showWarnings = FALSE, recursive = TRUE)

      svg(newDotFile)
      opar <- par()      # make a copy of current settings
      par(col = color)
      plot(Energy, to.draw.arg = "d", mfColRow = FALSE, bty = "7", panel.first = grid(lwd = 2), lwd = 2, vertical = FALSE,
           inner = list(paste("Probability Function of ", Name)), col.points = c("red", "black"), cex.points = 1.8, xlab = "")
      title(xlab = paste0("E(x) = ", round(E(Energy), 2), "  Var(x) = ", round(var(Energy), 2)))
      dev.off()
      par(opar)          # restore original settings
      cnt <- 0
    }
  }

  # Generate CFG dot file
  fromNodetoBasicBlock(paste0(".dots/", method, ".dot"))
  command <- paste0("cd .dots && ", "dot -Tsvg -Nfontname=Roboto -Nfontsize=10 -Efontname=Roboto -Efontsize=10 -Gfontname=Roboto -Gfontsize=12 -O ", method, ".dot")
  try(system(command, intern = TRUE, ignore.stderr = TRUE))
  svgFile <- paste0(".dots/", method, ".dot.svg")
  fromNodetoTitleInSvg(svgFile)
  openHTML(appendStyle(svgFile))

  fromNodetoBasicBlock(paste0(".dots/.cfg", method, ".dot"))
  command <- paste0("cd .dots && ", "dot -Tsvg -Nfontname=Roboto -Nfontsize=10 -Efontname=Roboto -Efontsize=10 -Gfontname=Roboto -Gfontsize=12 -O .cfg", method, ".dot")
  try(system(command, intern = TRUE, ignore.stderr = TRUE))
  svgFile <- paste0(".dots/.cfg", method, ".dot.svg")
  fromNodetoTitleInSvg(svgFile)
  openHTML(appendStyle(svgFile))

  dotting("timing", method)
  dotting("energy", method)
}

dotting <- function(property, method) {
  replacement_port <- "[margin = 0, label = < <TABLE ID=\"#BLOCKNAME#\" TITLE=\"#BLOCKNAME#\" HREF=\"../../.cfg#FILENAME#.dot.svg##BLOCKNAME#\" BORDER=\"0\" CELLBORDER=\"1\" CELLSPACING=\"0\"> <TR> <TD colspan=\"2\" fixedsize=\"true\" width=\"200\" height=\"200\"><img src=\"#BLOCKNAME#.svg\" /></TD> </TR> <TR> <TD PORT=\"s0\">T</TD><TD PORT=\"s1\">F </TD> </TR> </TABLE>>];"
  replacement <- "[margin = 0, label = < <TABLE ID=\"#BLOCKNAME#\" TITLE=\"#BLOCKNAME#\" HREF=\"../../.cfg#FILENAME#.dot.svg##BLOCKNAME#\" BORDER=\"0\" CELLBORDER=\"1\" CELLSPACING=\"0\"> <TR> <TD colspan=\"2\" fixedsize=\"true\" width=\"200\" height=\"200\"><img src=\"#BLOCKNAME#.svg\" /></TD> </TR> </TABLE>>];"

  directory <- paste0(".dots/", method, "/", property, "/")
  newDotFile <- paste0(directory, method, ".dot")
  dir.create(dirname(newDotFile), showWarnings = FALSE, recursive = TRUE)

  dotFile <- paste0(".dots/", method, ".dot")
  conn <- file(dotFile, open = "r")
  lines <- readLines(conn)
  cnt <- 1
  for (i in seq_along(lines)) {
    if (cnt == 1) {
      write(lines[i], file = newDotFile, append = TRUE)
      inc(cnt)
    }
    else if (cnt == 2) {
      write(lines[i], file = newDotFile, append = TRUE)
      write("    node [shape = plaintext]", file = newDotFile, append = TRUE)
      inc(cnt)
    }
    else if (str_detect(lines[i], pattern_blockname)) {
      result <- str_extract(lines[i], pattern_blockname)
      if (str_detect(lines[i], "(\\{<s0>T\\|<s1>F\\})")) {
        embedAttributes <- str_replace_all(replacement_port, "(#BLOCKNAME#)", result)
        embedAttributes <- str_replace_all(embedAttributes, "(#FILENAME#)", method)
      }
      else {
        embedAttributes <- str_replace_all(replacement, "(#BLOCKNAME#)", result)
        embedAttributes <- str_replace_all(embedAttributes, "(#FILENAME#)", method)
      }
      changedNode <- str_replace(lines[i], "\\[(.+?)(\\]\\;)", embedAttributes)
      write(changedNode, file = newDotFile, append = TRUE)
    }
    else {
      if (lines[i] != "")
        write(lines[i], file = newDotFile, append = TRUE)
      inc(cnt)
    }
  }
  close(conn)

  # Generate distr. embedded control flow
  cd <- paste0("cd ", directory)
  command <- paste0(cd, " && ", "dot -Tsvg -Nfontname=Roboto -Nfontsize=10  -Efontname=Roboto -Efontsize=10 -Gfontname=Roboto -Gfontsize=12 -O ", method, ".dot")
  try(system(command, intern = TRUE, ignore.stderr = TRUE))
  svgFile <- paste0(directory, method, ".dot.svg")
  fromNodetoTitleInSvg(svgFile)
  openHTML(appendStyle(svgFile))
}

run <- function(inputDir = ".") {
  fileList <- list.files(inputDir)
  for (i in fileList) {
    if (str_detect(i, "(.bbcost)")) {
      readBBCostFile(paste0(inputDir, i))
    }
  }
}

run(".output/")
