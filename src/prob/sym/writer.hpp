//  ----------------------------------------------------------------------------
//  Header file for the Pass class.                                     pass.hpp
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 24, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

#ifndef STANDALONE_APPLICATION_WRITER_HPP
#define STANDALONE_APPLICATION_WRITER_HPP

#include <llvm/Pass.h>
#include <llvm/Support/CommandLine.h>

#include <fstream>
#include <iostream>
#include <string>

#include "../utility.hpp"

namespace prob::sym {

static llvm::cl::opt<bool> ExecuteMachines(
    "execute-machines", llvm::cl::init(true), llvm::cl::Hidden,
    llvm::cl::desc("Execute Probabilistic Symbolic Simulation"));

static llvm::cl::opt<bool> GenerateCFG(
    "generate-cfg", llvm::cl::init(true), llvm::cl::Hidden,
    llvm::cl::desc("Generate CFG .dot files"));

static llvm::cl::opt<bool> PrintCFG("print-cfg", llvm::cl::init(true),
                                    llvm::cl::Hidden,
                                    llvm::cl::desc("Print New CFG files"));

static llvm::cl::opt<int> MaxLoopCount("max-loop-count", llvm::cl::init(8),
                                       llvm::cl::Hidden,
                                       llvm::cl::desc("maximum loop count"));

static llvm::cl::opt<bool> GlobalIdiom(
    "global-idiom", llvm::cl::init(true), llvm::cl::Hidden,
    llvm::cl::desc("Use global idiom for edge probabilities"));

static llvm::cl::opt<bool> PlotReturnValue(
    "plot-return", llvm::cl::init(false), llvm::cl::Hidden,
    llvm::cl::desc("Plot the return value if it is a Distribution or Scalar"));

enum ExecutionSemantics { Normal, Intermittent, Speculative, ETAP };

static llvm::cl::opt<ExecutionSemantics> Execution(
    "execution", llvm::cl::desc("Choose execution semantics:"),
    llvm::cl::values(clEnumVal(Normal, "Normal Execution"),
                     clEnumVal(Intermittent, "Intermittent Execution"),
                     clEnumVal(Speculative, "Speculative Execution"),
                     clEnumVal(ETAP, "Energy-aware Timing Analysis")),
    llvm::cl::init(Normal));

static llvm::cl::opt<bool> BlockBased(
    "block-based", llvm::cl::init(true), llvm::cl::Hidden,
    llvm::cl::desc("The default expected model is block-based; if it is false "
                   "then the model is instruction-based."));

static llvm::cl::opt<bool> Verbose(
    "verbose", llvm::cl::init(false), llvm::cl::Hidden,
    llvm::cl::desc("Verbose Output Mode (default false)"));

static llvm::cl::opt<std::string> FunctionName(
    "function-name", llvm::cl::init(""), llvm::cl::Hidden,
    llvm::cl::desc("Function Under Analysis"));

class Writer : public llvm::ModulePass {
 private:
  static std::string MetaFunctions;
  static std::string Prologue;
  static std::string MaxLoop;
  static std::string Capacitor;
  static std::string BlockTemplate;
  static std::string Predecessors;
  static std::string NamePredecessors;
  static std::string Successors;
  static std::string NameSuccessors;
  static std::string Frequencies;
  static std::string NameFrequencies;
  static std::string Visited;
  static std::string NameVisited;
  static std::string Color;
  static std::string NameColor;
  static std::string TotalVisit;
  static std::string NameTotalVisit;
  static std::string EdgeProbabilities;
  static std::string NameEdgeProbabilities;
  static std::string FunctionTemplate;
  static std::string FileTemplate;
  static std::string NormalInstructionBasedMachine;
  static std::string NormalBlockBasedMachine;
  static std::string IntermittentMachine;
  static std::string RunNormalMachine;
  static std::string RunIntermittentMachine;
  static std::string ETAPMachine;
  static std::string PlotReturn;
  static std::string PlotTiming;
  static std::string Epilogue;
  static std::string BlockBasedFunctions;
  static std::string CheckpointRestoreForNormalExecution;
  static std::string InstructionBasedFunctions;

  // ---------------------------------------------------------------------------
  std::string instruction(const std::string& I) const;
  std::string type(const llvm::Type* T) const;
  std::string symbol(const llvm::Value* V, const llvm::Module* M) const;
  std::string constant(const llvm::Constant* C, const llvm::Module* M) const;
  // ---------------------------------------------------------------------------
  void write(const llvm::Module& M) const;
  // ---------------------------------------------------------------------------
  void execute(const llvm::Module& M) const;
  // ---------------------------------------------------------------------------
  void cfg(const llvm::Module& M) const;  // control-flow graph
  // ---------------------------------------------------------------------------
  void pfg(const llvm::Module& M) const;  // probability-flow graph
  // ---------------------------------------------------------------------------
  void svg(const std::string& file) const;
  // ---------------------------------------------------------------------------
  void pdf(const std::string& file) const;
  // ---------------------------------------------------------------------------
  void open(const std::string& file) const;
  // ---------------------------------------------------------------------------
  std::string formals(const llvm::Function& F, bool verbose = true) const;
  // ---------------------------------------------------------------------------
  std::vector<std::string> metadata(const llvm::Function& F,
                                    bool verbose = true) const;
  // ---------------------------------------------------------------------------
  std::string store(const llvm::Function& F) const;
  // ---------------------------------------------------------------------------
  std::string function(const llvm::Function& F,
                       const std::vector<std::string>& blocks,
                       const std::vector<std::string>& globals,
                       const std::vector<std::string>& types) const;
  // ---------------------------------------------------------------------------
  std::string qualified(const llvm::BasicBlock& BB) const;
  // ---------------------------------------------------------------------------
  std::string block(const llvm::BasicBlock& BB,
                    const std::vector<std::string>& insts) const;
  // ---------------------------------------------------------------------------
  std::string instruction(std::string Store, std::string Update,
                          std::string Energy, std::string Timing) const;
  // ---------------------------------------------------------------------------
  std::string loopCount(int N = MaxLoopCount) const;
  // ---------------------------------------------------------------------------
  std::string capacitorInitializer(std::string Min, std::string Max) const;
  // ---------------------------------------------------------------------------
  std::pair<std::string, std::string> capacitor(const llvm::Module& M) const;
  // ---------------------------------------------------------------------------
  std::string pred(const llvm::BasicBlock& BB) const;
  // ---------------------------------------------------------------------------
  std::string namePred(const std::vector<std::string>& blocks) const;
  // ---------------------------------------------------------------------------
  std::string succ(const llvm::BasicBlock& BB) const;
  // ---------------------------------------------------------------------------
  std::string nameSucc(const std::vector<std::string>& blocks) const;
  // ---------------------------------------------------------------------------
  std::string block(const std::vector<std::string>& blocks) const;
  // ---------------------------------------------------------------------------
  std::string edge(const llvm::Function& F) const;
  // ---------------------------------------------------------------------------
  std::string run(const llvm::Function& F) const;
  // ---------------------------------------------------------------------------
  std::string epilogue(const llvm::Function& F) const;
  // ---------------------------------------------------------------------------
  std::string getMetaDataCalledFunc(llvm::Function* F,
                                    std::string metaData) const;

 public:
  static char ID;

  Writer() : ModulePass(ID){};

  llvm::StringRef getPassName() const override {
    return "Probabilistic Symbolic Machine Writer";
  }

  bool runOnModule(llvm::Module& M) override {
    utility::banner(getPassName().str());
    std::cout << "Generating machines for probabilistic execution...\n";
    write(M);
    if (ExecuteMachines.getValue()) {
      std::cout << "Executing machines to obtain path probabilities...\n";
      execute(M);
      if (PrintCFG.getValue()) {
        if (GenerateCFG.getValue()) cfg(M);
        pfg(M);
      }
    }
    utility::bye();
    return false;  // Return true if the pass modifies the program
  }
};

}  // namespace prob::sym

#endif  // STANDALONE_APPLICATION_WRITER_HPP
