#include "llvm/IR/BasicBlock.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Support/CommandLine.h"
#include "msp430.h"
/*
 * RUNNING THE PASS:
 * cmake .
 * make
 * opt-11 -S -load ./passes/libMsp430.so -msp430-pass -input .llvm/input-split.s
 * -output .output/model.conf.R .llvm/input.ll -o .llvm/input.ll
 */
llvm::cl::opt<std::string> INPUT("input", llvm::cl::desc("input .s file name"),
                                 llvm::cl::value_desc("file name"));
llvm::cl::opt<std::string> OUTPUT("output",
                                  llvm::cl::desc("output .conf.R file name"),
                                  llvm::cl::value_desc("file name"));

struct Msp430Pass : public llvm::ModulePass {
  static char ID;
  Msp430Pass() : ModulePass(ID) {}
  std::string getMetaData(llvm::Function* F, std::string metaData) {
    std::string cost{""};
    if (llvm::MDNode* n = F->getMetadata(metaData)) {
      if (!n->isDistinct()) {
        cost = llvm::cast<llvm::MDString>(n->getOperand(0))->getString().str();
      }
    }
    return cost;
  }
  std::map<std::string, std::string> TimingMap;
  std::map<std::string, std::string> EnergyMap;

  void generateModelConf() {
    // test block here

    Msp430 c(INPUT, TimingMap, EnergyMap);
    std::vector<double> meanVectorEnergy;
    std::vector<double> meanVectorTime;
    std::vector<double> stdVectorEnergy;
    std::vector<double> stdVectorTime;

    std::map<std::string, std::map<std::string, std::vector<std::string>>>
        funcList = c.blockParser(c.stringToLine());

    for (auto& funct : funcList) {
      for (auto& block : funct.second) {
        std::vector<std::pair<double, double>> result;
        result = c.calculateTimeEnergy(block.second, block.first, funct.first);
        meanVectorEnergy.push_back(result.at(1).first);
        meanVectorTime.push_back(result.at(0).first);
        stdVectorEnergy.push_back(result.at(1).second);
        stdVectorTime.push_back(result.at(0).second);
      }
    }
    c.printToFile(funcList, meanVectorTime, stdVectorTime, meanVectorEnergy,
                  stdVectorEnergy, OUTPUT);
  }
  bool runOnModule(llvm::Module& M) override {
    for (llvm::Function& F : M) {
      for (llvm::BasicBlock& BB : F) {
        for (llvm::Instruction& I : BB) {
          if (llvm::isa<llvm::CallInst>(I)) {
            llvm::Function* calledFunction =
                llvm::cast<llvm::CallInst>(I).getCalledFunction();
            std::string timing = getMetaData(calledFunction, "timing");
            TimingMap[calledFunction->getName().str()] = timing;
            std::string energy = getMetaData(calledFunction, "energy");
            EnergyMap[calledFunction->getName().str()] = energy;
          }
        }
      }
    }

    generateModelConf();
    return false;
  }
};

char Msp430Pass::ID = 0;

[[maybe_unused]] static llvm::RegisterPass<Msp430Pass> X("msp430-pass",
                                                         "MSP430 Pass");
