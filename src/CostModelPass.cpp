#include <fstream>
#include <iostream>

#include "llvm/ADT/MapVector.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Support/raw_ostream.h"

using CostPair = std::pair<std::string, std::string>;
using BBCostMap = llvm::MapVector<llvm::BasicBlock*, CostPair>;

struct CostModelPass : public llvm::ModulePass {
  static char ID;
  llvm::MapVector<llvm::Function*, BBCostMap> FunctionBBCosts;

  CostModelPass() : ModulePass(ID) {}

  // ---------------------------------------------------------------------------
  static CostPair parseCost(llvm::StringRef costs) {
    llvm::SmallVector<llvm::StringRef, 4> parsedStrings;
    costs.split(parsedStrings, ";");
    return CostPair(parsedStrings[1], parsedStrings[3]);
  }
  // ---------------------------------------------------------------------------
  static CostPair addCostStrings(CostPair p1, const CostPair& p2) {
    p1.first = p1.first + "+" + p2.first;
    p1.second = p1.second + "+" + p2.second;
    return p1;
  }
  // ---------------------------------------------------------------------------
  static bool isTimingCost(llvm::StringRef mdStr) {
    return mdStr.contains_lower("timing");
  }
  // ---------------------------------------------------------------------------
  static bool isEnergyCost(llvm::StringRef mdStr) {
    return mdStr.contains_lower("energy");
  }
  // ---------------------------------------------------------------------------
  static bool isAboutCost(llvm::StringRef mdStr) {
    return (mdStr.contains_lower("cost") || mdStr.contains_lower("behaviour"));
  }
  // ---------------------------------------------------------------------------
  static void addCalledFunctionsCostToBBCost(llvm::MDNode* n,
                                             llvm::BasicBlock& BB,
                                             BBCostMap& BBCosts) {
    for (int i = 0; i < n->getNumOperands(); ++i) {
      if (!n->isDistinct()) {
        llvm::StringRef reliStr =
            llvm::cast<llvm::MDString>(n->getOperand(i))->getString();
        CostPair costForThisBB = BBCosts[&BB];
        if (isAboutCost(reliStr)) {
          std::string cost = reliStr.split(";").second.str();
          if (isTimingCost(reliStr)) {
            costForThisBB.first += "+" + cost;
          } else if (isEnergyCost(reliStr)) {
            costForThisBB.second += "+" + cost;
          }
          BBCosts[&BB] = costForThisBB;
        }
      }
    }
  }
  // ---------------------------------------------------------------------------
  static void addOpcodeCostToBBCost(llvm::MDNode* n, llvm::BasicBlock& BB,
                                    BBCostMap& BBCosts) {
    if (!n->isDistinct()) {
      llvm::StringRef costStr =
          llvm::cast<llvm::MDString>(n->getOperand(0))->getString();
      CostPair costForThisBB = BBCosts[&BB];
      if (!costForThisBB.first.empty()) {
        CostPair parsedCostForThisInst = parseCost(costStr);
        costForThisBB = addCostStrings(costForThisBB, parsedCostForThisInst);
      } else {
        costForThisBB = parseCost(costStr);
      }
      BBCosts[&BB] = costForThisBB;
    }
  }
  // ---------------------------------------------------------------------------
  static void addExternalEventsBehaviourToBBCost(llvm::MDNode* n,
                                                 llvm::BasicBlock& BB,
                                                 BBCostMap& BBCosts) {
    for (int i = 0; i < n->getNumOperands(); ++i) {
      if (!n->isDistinct()) {
        llvm::StringRef probStr =
            llvm::cast<llvm::MDString>(n->getOperand(i))->getString();
        CostPair costForThisBB = BBCosts[&BB];
        if (isAboutCost(probStr)) {
          std::string cost = probStr.split(";").second.str();
          costForThisBB.first += "+" + cost;
          BBCosts[&BB] = costForThisBB;
        }
      }
    }
  }
  // ---------------------------------------------------------------------------
  static BBCostMap findBBCost(llvm::Function& F) {
    BBCostMap BBCosts;
    for (auto& BB : F) {
      for (auto& I : BB) {
        // add Instruction's opcode cost to total basicblock cost
        if (llvm::MDNode* n = I.getMetadata("cost")) {
          addOpcodeCostToBBCost(n, BB, BBCosts);
        }

        // if its a call instruction, we need to add some different types of
        // cost like called function's total cost
        if (llvm::isa<llvm::CallInst>(I)) {
          // add external event behaviour cost to total basicblock cost like if
          // there is a called stdio scanf function, scanf function is going to
          // wait for user's input from keyboard to console. The behaviour cost
          // is how much it will wait for user
          if (llvm::MDNode* n = I.getMetadata("probability")) {
            addExternalEventsBehaviourToBBCost(n, BB, BBCosts);
          }
          // if called function's cost has already given to us from pragmas add
          // that
          if (llvm::MDNode* n = I.getMetadata("reliability")) {
            addCalledFunctionsCostToBBCost(n, BB, BBCosts);
          }

          llvm::SmallVector<std::pair<unsigned, llvm::MDNode*>, 5> callMDs;
          auto* callI = llvm::cast<llvm::CallInst>(&I);
          auto* calledFunc = callI->getCalledFunction();
          calledFunc->getAllMetadata(callMDs);
          for (auto pair : callMDs) {
            for (int i = 0; i < pair.second->getNumOperands(); ++i) {
              addCalledFunctionsCostToBBCost(pair.second, BB, BBCosts);
            }
          }
        }
      }
    }
    return BBCosts;
  }
  // ---------------------------------------------------------------------------
  void insertCostsToTerminatorInst() {
    for (auto& FuncBBCostPair : FunctionBBCosts) {
      for (auto& BB : *FuncBBCostPair.first) {
        for (auto& I : BB) {
          if (I.isTerminator()) {
            BBCostMap BBCostsMap = FuncBBCostPair.second;
            if (!BBCostsMap[&BB].first.empty()) {
              llvm::LLVMContext& C = I.getContext();
              llvm::SmallVector<llvm::Metadata*, 32> Ops;
              std::string timing = "timing ; " + BBCostsMap[&BB].first;
              std::string energy = "energy ; " + BBCostsMap[&BB].second;
              Ops.push_back(llvm::MDString::get(C, timing));
              Ops.push_back(llvm::MDString::get(C, energy));
              auto* node = llvm::MDTuple::get(C, Ops);
              I.setMetadata("block", node);
            }
          }
        }
      }
    }
  }
  // ---------------------------------------------------------------------------
  bool hasFunctionCostMetadata(llvm::Function& F) {
    llvm::SmallVector<std::pair<unsigned, llvm::MDNode*>, 5> MDs;
    F.getAllMetadata(MDs);
    for (auto pair : MDs) {
      llvm::MDNode* n = pair.second;
      for (int i = 0; i < n->getNumOperands(); ++i) {
        if (!n->isDistinct()) {
          llvm::StringRef mdStr =
              llvm::cast<llvm::MDString>(n->getOperand(i))->getString();
          return isAboutCost(mdStr);
        }
      }
    }
    return false;
  }
  // ---------------------------------------------------------------------------
  void insertFunctionCost(llvm::Function& F) {
    if (F.getName() == "main") return;
    if (F.getBasicBlockList().empty()) return;
    if (hasFunctionCostMetadata(F)) return;

    llvm::LLVMContext& C = F.getContext();
    std::string functTimingCost;
    std::string functEnergyCost;

    for (const auto& pair : FunctionBBCosts[&F]) {
      functTimingCost += pair.second.first;
      functEnergyCost += pair.second.second;
    }
    functTimingCost = "timing ; " + functTimingCost;
    functEnergyCost = "energy ; " + functEnergyCost;
    llvm::MDNode& NTiming =
        *llvm::MDNode::get(C, llvm::MDString::get(C, functTimingCost));
    llvm::MDNode& NEnergy =
        *llvm::MDNode::get(C, llvm::MDString::get(C, functEnergyCost));
    F.addMetadata("reliability", NTiming);
    F.addMetadata("reliability", NEnergy);
  }
  // ---------------------------------------------------------------------------
  void printBBCostsToFile() {
    std::ofstream File;
    for (const auto& FunctionBBCost : FunctionBBCosts) {
      if (FunctionBBCost.first->isDeclaration()) continue;
      File.open(".output/" + (std::string)FunctionBBCost.first->getName() +
                ".bbcost");
      for (const auto& BBCost : FunctionBBCost.second) {
        File << "basicblock: " << (std::string)BBCost.first->getName() << "\n";
        File << "timing: " << (std::string)BBCost.second.first << "\n";
        File << "energy: " << (std::string)BBCost.second.second << "\n";
      }
      File.close();
    }
  }
  // ---------------------------------------------------------------------------
  bool runOnModule(llvm::Module& M) override {
    for (llvm::Function& F : M) {
      BBCostMap bbCostForThisFunction = findBBCost(F);
      FunctionBBCosts[&F] = bbCostForThisFunction;
      insertFunctionCost(F);
    }
    insertCostsToTerminatorInst();
    printBBCostsToFile();
    return false;
  }
};

char CostModelPass::ID = 0;

[[maybe_unused]] static llvm::RegisterPass<CostModelPass> X(
    "bb-cost-model", "Basic Block Cost Model");