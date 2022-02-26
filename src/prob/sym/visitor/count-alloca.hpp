//  ----------------------------------------------------------------------------
//  Header file for the CountAlloca class.                      count-alloca.hpp
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 13, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

#ifndef STANDALONE_APPLICATION_COUNT_ALLOCA_HPP
#define STANDALONE_APPLICATION_COUNT_ALLOCA_HPP

#include "llvm/IR/InstVisitor.h"

namespace prob::sym::visitor {

class CountAlloca : public llvm::InstVisitor<CountAlloca> {
 private:
  unsigned Count;

 public:
  CountAlloca() : Count(0) {}

  void visitAllocaInst(llvm::AllocaInst& AI);

  unsigned getCount() const { return Count; }
};

}  // namespace prob::sym::visitor

#endif  // STANDALONE_APPLICATION_COUNT_ALLOCA_HPP
