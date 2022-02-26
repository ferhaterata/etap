//  ----------------------------------------------------------------------------
//  The Probabilistic Symbolic Execution class.                         exec.cpp
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 13, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

#include "exec.hpp"

#include <llvm/IR/Function.h>
#include <llvm/IR/Module.h>

char prob::sym::Exec::ID = 0;

// -----------------------------------------------------------------------------
void prob::sym::Exec::analyze(llvm::Module& M) {
  prob::sym::visitor::Visitor visitor;
  visitor.visit(M);
  llvm::outs() << visitor;
}

// -----------------------------------------------------------------------------
void prob::sym::Exec::print(llvm::raw_ostream& out,
                            const llvm::Module* M) const {
  Pass::print(out, M);
}

// -----------------------------------------------------------------------------
static llvm::RegisterPass<prob::sym::Exec> X(
    "prob-sym-exec", "Probabilistic Symbolic Execution Pass", false, false);
