//  ----------------------------------------------------------------------------
//  Implementation file for the CountAlloca class.              count-alloca.cpp
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 13, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

#include "count-alloca.hpp"

#include "../../utility.hpp"

// -----------------------------------------------------------------------------
void prob::sym::visitor::CountAlloca::visitAllocaInst(llvm::AllocaInst& AI) {
  ++Count;
  auto* bb = AI.getParent();
  auto* f = bb->getParent();
  std::string first = (f->getName() + "::" + bb->getName()).str();
  std::pair<llvm::StringRef, llvm::StringRef> pair =
      std::pair(first, std::to_string(Count));
  utility::attachMetadata((llvm::Value*)&AI, "count", pair);
}
