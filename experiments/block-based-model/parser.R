# As   Ad
# 00    0 = ^r[0-9]{1,2}$                   => r15
# 01    1 = ^\d+\(r[0-9]{1,2}\)$            => 32(r15)
# 10    - = ^@r[0-9]{1,2}$                  => @r14
# 11    - = ^@r[0-9]{1,2}\+$|^#[0-9A-F]+$   => @r15+  or  #12AF
# variable pattern =[A-Za-z0-9_\-@]+

rm(list = ls(all.names = TRUE)) #will clear all objects includes hidden objects.
library(stringr)
options("StartupBanner" = "off")
library(distr)
distroptions("WarningArith" = FALSE)
INPUT <- "experiments/block-based-model/test2.s"
OUTPUT <- "experiments/block-based-model/continuous-model-3.R"

instruction_parser <- function(line) {
  operand2 <- ""
  operand1 <- ""
  splited_line <- str_split(line, " ", 2)[[1]]
  instruction <- splited_line[[1]]
  if (length(splited_line) > 1) {
    operands <- splited_line[[2]]
    operand1 <- str_split(operands, ", ")[[1]][[1]]
    if (grepl(",", line)) {
      print(line)
      operand2 <- str_split(operands, ", ")[[1]][[2]]
    }
  }
  return(list(inst = tolower(instruction), op1 = operand1, op2 = operand2))
}

readFile <- function(file_name) {
  file <- readLines(file_name)
  file <- str_replace_all(file, "[\\t]+", " ")
  for (i in seq_along(file)) {
    file[[i]] <- str_trim(file[[i]])
  }
  return(file)
}

block_parser <- function() {
  file <- readFile(INPUT)
  func_list <- list()
  func_name <- ""
  block_name <- ""
  for (line in file) {
    if (grepl(line, pattern = "^; ")) next
    if (grepl(":", line)) { # if line is not an instruction
      if (substring(line, 1, 1) == '.') {  # if line is a label (block) name
        line <- gsub(".*; %", "", line)
        block_name <- line
      }else { # if line is a function name
        line <- gsub(":.*", "", line)
        func_name <- line
        func_list[[func_name]] <- append(func_list[[func_name]], list("entry" = list()))
        block_name <- "entry"
      }
    }else { # if line is an instruction
      line <- gsub(";.*", "", line) # if there is a comment remove
      func_list[[func_name]][[block_name]] <- append(func_list[[func_name]][[block_name]], line)
    }
  }
  return(func_list)
}

get_cycle_and_energy <- function(instruction) {
  cyc <- 0
  # Inferred from 50 samples
  am_time_map <- list("000" = distr::Norm(1.04, 0.24),
                      "001" = distr::Norm(3.03, 0.24),
                      "010" = distr::Norm(3.06, 0.24),
                      "011" = distr::Norm(5.04, 0.24),
                      "100" = distr::Norm(2.01, 0.24),
                      "101" = distr::Norm(4.05, 0.24),
                      "110" = distr::Norm(2.01, 0.24),
                      "111" = distr::Norm(4.01, 0.25))

  am_energy_map <- list("000" = distr::Norm(4.52, 0.62),
                        "001" = distr::Norm(7.08, 0.62),
                        "010" = distr::Norm(6.97, 0.62),
                        "011" = distr::Norm(10.1, 0.62),
                        "100" = distr::Norm(5.8, 0.62),
                        "101" = distr::Norm(8.33, 0.62),
                        "110" = distr::Norm(5.55, 0.62),
                        "111" = distr::Norm(8.34, 0.62))
  inst <- instruction$inst
  op1 <- instruction$op1
  op2 <- instruction$op2
  address_mode_s <- "00"
  address_mode_d <- "0"
  # Format I Instructions
  if (nchar(op1) != 0) {
    if (grepl("^r[0-9]{1,2}$", op1)) {
      address_mode_s <- "00"
    }else if (grepl("^\\d+\\(r[0-9]{1,2}\\)$|^&{0,1}[-0-9a-zA-Z_@]+$", op1)) {
      address_mode_s <- "01"
    }else if (grepl("^@r[0-9]{1,2}$", op1)) {
      address_mode_s <- "10"
    }else if (grepl("^@r[0-9]{1,2}\\+$|^#[0-9A-F]+$", op1)) {
      address_mode_s <- "11"
    }
  }
  if (nchar(op2) != 0) {
    if (grepl("^r[0-9]{1,2}$", op2)) {
      address_mode_d <- "0"
    }else if (grepl("^\\d+\\(r[0-9]{1,2}\\)$|^&{0,1}[-0-9a-zA-Z_@]+$", op2)) {
      address_mode_d <- "1"
    }
  }
  # BR has special cases
  if (inst == "br") {
    if (grepl("^@r[0-9]{1,2}\\+$", op1)) {
      return(list(3, distr::Norm(7.08, 0.62)))  # BR @r9+  => 3 cycle
    }else if (address_mode_s == "00") {
      return(list(2, distr::Norm(5.8, 0.62))) # BR R9    => 2 cycle
    }
  }
  address_mode <- paste0(address_mode_s, address_mode_d)

  # FORMAT II Instructions
  if (inst == "rrc" ||
    inst == "pra" ||
    inst == "swpb" ||
    inst == "sxt") {
    inst <- "formatII"
  }
  if (inst == "formatII" ||
    inst == "push" ||
    inst == "call") {
    if (address_mode == "000") {
      return(switch(inst,
                    "formatII" = list(1, distr::Norm(4.52, 0.62)),
                    "push" = list(3, distr::Norm(7.08, 0.62)),
                    "call" = list(4, distr::Norm(8.33, 0.62))))
    }else if (address_mode == "111") {
      return(switch(inst,
                    "formatII" = list(4, distr::Norm(8.33, 0.62)),
                    "push" = list(5, distr::Norm(10.1, 0.62)),
                    "call" = list(5, distr::Norm(10.1, 0.62))))
    }else if (address_mode_s == "10" && grepl("^@r[0-9]{1,2}$", op2)) {
      return(switch(inst,
                    "formatII" = list(3, distr::Norm(7.08, 0.62)),
                    "push" = list(4, distr::Norm(8.33, 0.62)),
                    "call" = list(4, distr::Norm(8.33, 0.62))))
    }else if (address_mode_s == "11" && grepl("^@r[0-9]{1,2}\\+", op2)) {
      return(switch(inst,
                    "formatII" = list(3, distr::Norm(7.08, 0.62)),
                    "push" = list(4, distr::Norm(8.33, 0.62)),
                    "call" = list(5, distr::Norm(10.1, 0.62))))
    }
  }
  # Format III Instructions
  if (grepl("^j[a-z]{1,2}$", inst)) {
    return(list(2, distr::Norm(5.8, 0.62)))
  }
  #  Miscellanous Instructions or Operators
  if (inst == "reti") {
    return(list(5, distr::Norm(10.1, 0.62)))
  }
  # The DADD instruction needs 1 extra cycle.
  if (inst == "dadd") {
    cyc <- cyc + 1
    warning("DADD instructions energy is default 000 addressing mode.")
  }
  cyc <- cyc + am_time_map[[address_mode]]
  energy <- am_energy_map[[address_mode]]
  return(list(cyc, energy))
}

print_to_console <- function(func_blocks_total_cycles_energy) {
  file_total_cycle <- 0
  file_total_energy <- 0
  for (f in seq_along(func_blocks_total_cycles_energy)) {
    func_total_cycle <- 0
    func_total_energy <- 0
    func_name <- names(func_blocks_total_cycles_energy)[[f]]
    cat(func_name, "\n\t")
    for (bb in seq_along(func_blocks_total_cycles_energy[[f]])) {
      bb_name <- names(func_blocks_total_cycles_energy[[f]])[[bb]]
      total_cycle <- func_blocks_total_cycles_energy[[f]][[bb]][[1]]
      total_energy <- func_blocks_total_cycles_energy[[f]][[bb]][[2]]
      func_total_cycle <- func_total_cycle + total_cycle
      func_total_energy <- func_total_energy + total_energy
      cat(bb_name, "--->\nCycle -> ")
      print(total_cycle)
      cat("\nEnergy -> ")
      print(total_energy)
      cat("\n")
    }
    file_total_cycle <- file_total_cycle + func_total_cycle
    file_total_energy <- file_total_energy + func_total_energy
    cat("FUNCTION TOTAL CYCLE:")
    distr::print(func_total_cycle)
    cat("\n")
    cat("FUNCTION TOTAL ENERGY:")
    distr::print(func_total_energy)
    cat("\n")
  }
  cat("\n----- FILE TOTAL CYCLE:")
  distr::print(file_total_cycle)
  cat("\n")
  cat("\n----- FILE TOTAL Energy:")
  distr::print(file_total_energy)
  cat("\n")
}

print_to_file <- function(func_blocks_total_cycles_energy) {
  cat(file = OUTPUT, "")
  for (f in seq_along(func_blocks_total_cycles_energy)) {
    func_name <- names(func_blocks_total_cycles_energy)[[f]]
    for (bb in seq_along(func_blocks_total_cycles_energy[[f]])) {
      bb_name <- names(func_blocks_total_cycles_energy[[f]])[[bb]]
      total_cycle <- func_blocks_total_cycles_energy[[f]][[bb]][[1]]
      total_energy <- func_blocks_total_cycles_energy[[f]][[bb]][[2]]
      if (is.na(sd(total_cycle))) {
        time <- paste0("timing$", func_name, "$", bb_name, " <- ", total_cycle, " # us\n")
      }else {
        time <- paste0("timing$", func_name, "$", bb_name, " <- Norm(mean=", round(mean(total_cycle), 2), ", sd=", round(sd(total_cycle), 2), ") # us\n")
      }
      if (is.na(sd(total_energy))) {
        energy <- paste0("energy$", func_name, "$", bb_name, " <- ", total_energy, " # nj\n")
      }else {
        energy <- paste0("energy$", func_name, "$", bb_name, " <- Norm(mean=", round(mean(total_energy), 2), ", sd=", round(sd(total_energy), 2), ") # nj\n")
      }
      cat(file = OUTPUT, append = TRUE, sep = "", time, energy)
    }
  }
}

main <- function() {
  func_list <- block_parser()
  func_blocks_total_cycles_energy <- list()
  for (f in seq_along(func_list)) {
    func_name <- names(func_list)[[f]]
    if (length(func_list[[f]][[1]]) == 0) { # if block is a data block
      next
    }
    for (bb in seq_along(func_list[[f]])) {
      if (substring(func_list[[f]][[bb]][[1]], 1, 1) == '.') { # if instruction is a data
        break
      }
      bb_name <- names(func_list[[f]])[[bb]]
      total_cycle <- 0
      total_energy <- 0
      for (i in seq_along(func_list[[f]][[bb]])) {

        instruction <- instruction_parser(func_list[[f]][[bb]][[i]])
        pair <- get_cycle_and_energy(instruction)
        total_cycle <- total_cycle + pair[[1]]
        total_energy <- total_energy + pair[[2]]

      }
      func_blocks_total_cycles_energy[[func_name]][[bb_name]] <- append(func_blocks_total_cycles_energy[[func_name]][[bb_name]], list(total_cycle, total_energy))
    }
  }
  #print_to_console(func_blocks_total_cycles_energy)
  print_to_file(func_blocks_total_cycles_energy)

}

main()
