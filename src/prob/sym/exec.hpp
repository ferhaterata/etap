//  ----------------------------------------------------------------------------
//  Header file for the Exec class.                                     exec.hpp
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 13, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

#ifndef STANDALONE_APPLICATION_EXEC_HPP
#define STANDALONE_APPLICATION_EXEC_HPP

#include <llvm/Pass.h>
#include <llvm/Support/CommandLine.h>

#include <vector>

#include "../utility.hpp"
#include "visitor/count-alloca.hpp"
#include "visitor/visitor.hpp"

namespace prob::sym {

[[maybe_unused]] llvm::cl::list<std::string> EntryMethod("entry-method",
                                                         llvm::cl::ZeroOrMore);

class Exec : public llvm::ModulePass {
 private:
  void analyze(llvm::Module& m);

 public:
  static char ID;

  Exec() : ModulePass(ID){};

  llvm::StringRef getPassName() const override {
    return "Probabilistic Symbolic Execution Pass";
  }

  void print(llvm::raw_ostream& out, llvm::Module const* m) const override;

  bool runOnModule(llvm::Module& M) override {
    utility::banner(getPassName().str());
    analyze(M);
    utility::bye();
    return true;  // Return true if the pass modifies the program
  }
};

}  // namespace prob::sym

#endif  // STANDALONE_APPLICATION_EXEC_HPP
