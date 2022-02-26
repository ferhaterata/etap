#include <fstream>
#include <iostream>
#include <map>
#include <utility>
#include <vector>

#include "llvm/Analysis/LoopInfo.h"
#include "llvm/IR/Function.h"
#include "llvm/Pass.h"
#include "llvm/Support/raw_ostream.h"

// Number of times the loop runs
#define LOOP_COUNT 3

// Typedefs
using BBAdjMap = std::map<llvm::BasicBlock*, std::vector<llvm::BasicBlock*>>;
using BBVector = std::vector<llvm::BasicBlock*>;
using PathMap = std::map<std::string, BBVector>;
using PathCostStrMap = std::map<std::string, std::string>;

namespace {
struct CFGPath : public llvm::ModulePass {
  static char ID;
  PathMap pathMap;
  PathCostStrMap timingCostMap;
  PathCostStrMap energyCostMap;

  CFGPath() : ModulePass(ID){};

  // Fill the adjacency list to represent the graph
  static BBAdjMap createAdjList(llvm::Function& F) {
    BBAdjMap adj;
    // Initialize the successors vector
    BBVector successors;
    // For each BasicBlock in the Function,
    for (llvm::BasicBlock& BB : F) {
      // for each Instruction in the BasicBlock,
      for (llvm::Instruction& Inst : BB) {
        // If this instruction is a TerminatorInst, search all the successors
        if (Inst.isTerminator()) {
          for (unsigned I = 0, NSucc = Inst.getNumSuccessors(); I < NSucc;
               ++I) {
            llvm::BasicBlock* Succ = Inst.getSuccessor(I);
            if (Succ)
              // If a successor is found, add it to the vector
              successors.push_back(Succ);
          }
        }
      }
      // For the BasicBlock we loop through, add successor vector to the map
      adj[&BB] = successors;
      // Successors vector has to be cleared to avoid infinite loops
      successors.clear();
    }
    return adj;
  }

  // Print the adjacency list
  [[maybe_unused]] static void printAdjList(const BBAdjMap& adj) {
    llvm::errs() << "**-- ADJACENCY LIST --**\n";
    for (const auto& entry : adj) {
      llvm::errs() << "Node: " << entry.first->getName() << '\n';
      for (const auto& v : entry.second) {
        llvm::errs() << v->getName();
      }
      llvm::errs() << '\n';
    }
  }

  // Starting point of the DFS algorithm
  void printAllPaths(llvm::BasicBlock* src, llvm::BasicBlock* dst, BBAdjMap adj,
                     const std::string& functionName) {
    BBVector currentPath;
    currentPath.push_back(src);

    unsigned loopCount = LOOP_COUNT;

    // loopCount variable must be incremented one, otherwise loop node
    // will be ignored
    DFS(src, dst, currentPath, std::move(adj), loopCount + 1, nullptr,
        functionName);
  }

  void appendToPathMap(const BBVector& currentPath,
                       const std::string& functionName) {
    BBVector BBs;
    std::vector<std::string> BBNames;
    std::map<llvm::BasicBlock*, unsigned> BBCount;
    for (auto node : currentPath) {
      if (!BBCount[node]) {
        BBCount[node] = 0;
        BBNames.push_back('%' + (std::string)node->getName() + ".0");
      } else {
        BBNames.push_back('%' + (std::string)node->getName() + "." +
                          std::to_string(BBCount[node]));
      }
      BBCount[node]++;
      BBs.push_back(node);
    }

    std::string pathStr = '@' + functionName;
    for (const auto& name : BBNames) {
      pathStr += name;
    }
    pathMap[pathStr] = BBs;
  }

  // Find if a node repeats in a path
  static bool findIfRecurs(const BBVector& vector, llvm::BasicBlock* BBtoFind) {
    for (auto& BB : vector) {
      if (BB == BBtoFind) {
        return true;
      }
    }
    return false;
  }

  void DFS(llvm::BasicBlock* u, llvm::BasicBlock* d, BBVector currentPath,
           BBAdjMap adj, unsigned loopCount, llvm::BasicBlock* loopNode,
           const std::string& functionName) {
    // If the destination is found, print it
    if (u == d) {
      appendToPathMap(currentPath, functionName);
      return;
    }

    // For each adjacent node,
    for (auto node : adj[u]) {
      // If not all the paths are found yet,
      // (this is the line that limits the algorithm not to go to infinite
      // recursion)
      if (loopCount > 0) {
        // find the node that causes a loop if it is not found yet
        if (loopNode == nullptr) {
          findIfRecurs(currentPath, node) ? loopNode = node : loopNode;
        }
        // If the current node is the loop node, decrease the count by one
        if (node == loopNode) loopCount--;
        // Continue to traverse recursively
        currentPath.push_back(node);
        DFS(node, d, currentPath, adj, loopCount, loopNode, functionName);
        currentPath.pop_back();
      }
    }
  }

  // Find destination node
  static llvm::BasicBlock* findDestination(llvm::Function& F) {
    for (auto& BB : F) {
      for (llvm::Instruction& Inst : BB) {
        if (Inst.isTerminator()) {
          if (Inst.getNumSuccessors() == 0) {
            // Destination node has no successors
            return &BB;
          }
        }
      }
    }
    return nullptr;
  }

  void fillCostMap() {
    for (const auto& pair : pathMap) {
      std::string timingCostStr;
      std::string energyCostStr;
      for (auto *bb : pair.second) {
        llvm::Instruction* i = bb->getTerminator();
        if (llvm::MDNode* n = i->getMetadata("block")) {
          timingCostStr +=
              "+" + (std::string)llvm::cast<llvm::MDString>(n->getOperand(0))
                        ->getString()
                        .split(";")
                        .second;
          energyCostStr +=
              "+" + (std::string)llvm::cast<llvm::MDString>(n->getOperand(1))
                        ->getString()
                        .split(";")
                        .second;
        }
        timingCostMap[pair.first] =
            timingCostStr.substr(1, timingCostStr.size());
        energyCostMap[pair.first] =
            energyCostStr.substr(1, energyCostStr.size());
      }
    }
  }

  void createCostFiles() {
    fillCostMap();
    std::ofstream TimingFile(".output/timing.costs");
    std::ofstream EnergyFile(".output/energy.costs");

    for (const auto& pair : timingCostMap) {
      TimingFile << pair.first << ";" << pair.second << "\n";
    }
    TimingFile.close();

    for (const auto& pair : energyCostMap) {
      EnergyFile << pair.first << ";" << pair.second << "\n";
    }
    EnergyFile.close();
  }

  bool runOnModule(llvm::Module& M) override {
    for (auto& F : M) {
      std::string functionName = (std::string)F.getName();
      BBAdjMap adj = createAdjList(F);

      auto *entryNode = &F.getEntryBlock();
      auto *targetNode = findDestination(F);
      printAllPaths(entryNode, targetNode, adj, functionName);
      createCostFiles();
    }
    return false;
  }
};
}  // namespace

// Registering the pass

char CFGPath::ID = 0;

static llvm::RegisterPass<CFGPath> X("normal-execution",
                                     "Normal Execution Analysis Pass", false,
                                     false);
