//  ----------------------------------------------------------------------------
//  Header file for the Pass class.                                     pass.hpp
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 14, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

#ifndef STANDALONE_APPLICATION_WRITER_HPP
#define STANDALONE_APPLICATION_WRITER_HPP

#include <llvm/IR/Instruction.h>
#include <llvm/Pass.h>
#include <llvm/Support/CommandLine.h>

#include <fstream>
#include <vector>

#include "model.hpp"

namespace prob::conf::inst {

llvm::cl::list<std::string> FileParam("model-file", llvm::cl::ZeroOrMore);

class Pass : public llvm::ModulePass {
 public:
  static char ID;
  std::vector<Model> Configs;
  Pass() : ModulePass(ID) { parseConfigFile(FileParam.front()); };

  bool runOnModule(llvm::Module& M) override {
    insertModelsIntoIR(M);
    return true;
  }

 private:
  void parseConfigFile(const std::string& fileName);

  static Model parseLine(const std::string& str);

  [[maybe_unused]] void printConfigFile();

  std::pair<std::string, std::string> findModel(const std::string& opcode);

  void insertModelsIntoIR(llvm::Module& M);

  static void attachMetadata(llvm::Instruction& I,
                             const std::pair<std::string, std::string>& model);
};

}  // namespace prob::conf::inst

#endif  // STANDALONE_APPLICATION_WRITER_HPP
