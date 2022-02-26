//  ----------------------------------------------------------------------------
//  Header file for the Pass class.                                     pass.cpp
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 14, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

#include "pass.hpp"

#include "llvm/IR/Constants.h"
#include "llvm/IR/Function.h"
#include "llvm/IR/Module.h"

char prob::conf::inst::Pass::ID = 0;
// -----------------------------------------------------------------------------
void prob::conf::inst::Pass::parseConfigFile(const std::string& fileName) {
  std::string line;
  std::ifstream configFile(fileName);

  if (configFile.is_open()) {
    while (getline(configFile, line)) {
      Configs.push_back(parseLine(line));
    }
  }
  configFile.close();
}
// -----------------------------------------------------------------------------
void prob::conf::inst::Pass::insertModelsIntoIR(llvm::Module& M) {
  for (llvm::Function& F : M) {
    for (llvm::BasicBlock& BB : F) {
      for (llvm::Instruction& I : BB) {
        std::pair<std::string, std::string> p = findModel(I.getOpcodeName());
        attachMetadata(I, p);
      }
    }
  }
}
// -----------------------------------------------------------------------------
prob::conf::inst::Model prob::conf::inst::Pass::parseLine(
    const std::string& str) {
  std::string opcode, models, timingModel, energyModel;
  opcode = str.substr(0, str.find(';'));
  models = str.substr(str.find(';') + 1, str.size());
  timingModel = models.substr(0, models.find(';'));
  energyModel = models.substr(models.find(';') + 1, models.size());

  return Model(opcode, timingModel, energyModel);
}
// -----------------------------------------------------------------------------
void prob::conf::inst::Pass::attachMetadata(
    llvm::Instruction& I, const std::pair<std::string, std::string>& model) {
  std::string metadata = "timing;" + model.first + ";energy;" + model.second;
  llvm::LLVMContext& C = I.getContext();
  llvm::MDNode* N = llvm::MDNode::get(C, llvm::MDString::get(C, metadata));
  I.setMetadata("cost", N);
}
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::conf::inst::Pass::printConfigFile() {
  for (const Model& c : Configs) {
    llvm::errs() << c.OpcodeName + '\t' << c.TimingModel + '\t'
                 << c.EnergyModel + '\n';
  }
}
// -----------------------------------------------------------------------------
std::pair<std::string, std::string> prob::conf::inst::Pass::findModel(
    const std::string& opcode) {
  Model defaultCT;
  for (const auto& c : Configs) {
    if (c.OpcodeName == opcode) return std::pair(c.TimingModel, c.EnergyModel);
    if (c.OpcodeName == "default") defaultCT = c;
  }
  return std::pair(defaultCT.TimingModel, defaultCT.EnergyModel);
}
// -----------------------------------------------------------------------------
[[maybe_unused]] static llvm::RegisterPass<prob::conf::inst::Pass> X(
    "config-pass", "Configuration Pass", false, false);
