#include <map>

#include "llvm/IR/BasicBlock.h"
#include "llvm/Passes/PassBuilder.h"

#define BLOCK_MAX_INST_LIMIT 4

/*
 * RUNNING THE PASS:
 * cmake .
 * make .
 * opt -S -load ./passes/libBlockSplitterPass.so -block-splitter <INPUT_DIR> -o
 * <OUTPUT_DIR>
 */

struct BlockSplitterPass : public llvm::ModulePass {
  static char ID;
  BlockSplitterPass() : ModulePass(ID) {}

  int CheckpointCounter = 0;

  void splitCheckpoint(llvm::Module& M) {
    for (auto& F : M) {
      for (auto& BB : F) {
        llvm::BasicBlock::iterator I = BB.begin();
        I++;  // skip first instruction
        for (; I != BB.end(); I++) {
          if (auto* callInst = llvm::dyn_cast<llvm::CallInst>(&*I)) {
            if (callInst->getCalledFunction()->getName() == "checkpoint") {
              BB.splitBasicBlock(
                  I, "checkpoint." + llvm::Twine(++CheckpointCounter));
              break;  // skip to next block
            }
          }
        }
      }
    }
  }

  llvm::Instruction* getSplittingPoint(llvm::BasicBlock* BB, int index) {
    auto inst = BB->begin();
    for (int i = 0; i < index; ++i) inst++;
    return &*inst;
  }

  std::map<llvm::BasicBlock*, llvm::Instruction*> findBlocksToSplit(
      llvm::Function& F) {
    std::map<llvm::BasicBlock*, llvm::Instruction*> blocksToSplit;
    for (auto& BB : F) {
      auto instructionSize = BB.getInstList().size();
      if (instructionSize > BLOCK_MAX_INST_LIMIT) {
        auto instructionDivident = BB.begin();
        for (int i = 0; i < instructionSize / 2; ++i) {
          instructionDivident++;
        }
        blocksToSplit[&BB] = &*instructionDivident;
      }
    }
    return blocksToSplit;
  }

  void split(llvm::BasicBlock* BB, llvm::Instruction* I) {
    auto* bb = BB->splitBasicBlock(I, BB->getName());
    if (bb->getInstList().size() > BLOCK_MAX_INST_LIMIT) {
      split(bb, getSplittingPoint(bb, bb->getInstList().size() / 2));
    }
  }

  bool runOnModule(llvm::Module& M) override {
    splitCheckpoint(M);

    //    for (auto& F : M) {
    //      auto map = findBlocksToSplit(F);
    //      for (auto pair : map) {
    //        split(pair.first, pair.second);
    //      }
    //    }
    return true;
  }
};

char BlockSplitterPass::ID = 0;

[[maybe_unused]] static llvm::RegisterPass<BlockSplitterPass> X(
    "block-splitter", "Block Splitter Pass");
