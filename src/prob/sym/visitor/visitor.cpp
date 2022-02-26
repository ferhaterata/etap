//  ----------------------------------------------------------------------------
//  Implementation file for the Main Visitor class.                  visitor.cpp
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 16, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

#include "visitor.hpp"

#include <llvm/IR/CFG.h>

#include <regex>

// -----------------------------------------------------------------------------
std::string prob::sym::visitor::Visitor::getGEP(llvm::GEPOperator* gep,
                                                llvm::Module* module) {
  std::string sym = symbol(gep->getOperand(0), Module);
  std::string base = symbol(gep->getOperand(1), Module);
  std::string typ = type(gep->getSourceElementType());
  std::string expr = "gep(" + typ + ", " + sym + ", " + base;
  for (int i = 2; i < gep->getNumOperands(); ++i) {
    std::string offset = symbol(gep->getOperand(i), Module);
    expr = expr + ", " + offset;
  }
  expr = expr + ")";
  return expr;
}
// -----------------------------------------------------------------------------
std::string prob::sym::visitor::Visitor::getGEP(llvm::GetElementPtrInst& gep,
                                                llvm::Module* module) {
  std::string sym = symbol(gep.getOperand(0), Module);
  std::string base = symbol(gep.getOperand(1), Module);
  std::string typ = type(gep.getSourceElementType());
  std::string expr = "gep(" + typ + ", " + sym + ", " + base;
  for (int i = 2; i < gep.getNumOperands(); ++i) {
    std::string offset = symbol(gep.getOperand(i), Module);
    expr = expr + ", " + offset;
  }
  expr = expr + ")";
  return expr;
}
// -----------------------------------------------------------------------------
std::string prob::sym::visitor::Visitor::constant(llvm::Constant* C,
                                                  llvm::Module* M) {
  if (C->getType()->isArrayTy()) {
    std::string list;
    int i = 0;
    for (; i < C->getType()->getArrayNumElements(); ++i) {
      llvm::Constant* c = C->getAggregateElement(i);
      list += constant(c, M) + ", ";
    }
    if (i > 0) {
      list.pop_back();
      list.pop_back();
    }
    return list;
  }
  if (C->getType()->isStructTy()) {
    std::string list;
    int i = 0;
    for (; i < C->getType()->getStructNumElements(); ++i) {
      llvm::Constant* c = C->getAggregateElement(i);
      list += constant(c, M) + ", ";
    }
    if (i > 0) {
      list.pop_back();
      list.pop_back();
    }
    return list;
  }
  if (C->getType()->isPointerTy()) {
    return symbol(C, M);
  }
  if (C->getType()->isIntegerTy() || C->getType()->isFloatingPointTy()) {
    return symbol(C, M);
  }
  return "error";
}
// -----------------------------------------------------------------------------
// sym$"name"
std::string prob::sym::visitor::Visitor::symbol(const llvm::Value* V,
                                                const llvm::Module* M) {
  std::string name = utility::name(V, M);
  if (name == "null") return name;
  if (auto* c = llvm::dyn_cast<llvm::Constant>(V)) {
    if (c->getType()->isIntegerTy() || c->getType()->isFloatingPointTy())
      return name;
  }
  if (auto* bb = llvm::dyn_cast<llvm::BasicBlock>(V))
    return bb->getName().str();
  return "sym$\\\"" + name.replace(0, 1, "") + "\\\"";
}
// -----------------------------------------------------------------------------
// prints type
std::string prob::sym::visitor::Visitor::type(const llvm::Type* T) {
  std::string s;
  llvm::raw_string_ostream ss(s);
  if (auto* st = llvm::dyn_cast<llvm::StructType>(T))
    ss << "%" << st->getName();
  else
    T->print(ss, true, false);
  return "\\\"" + ss.str() + "\\\"";
}
// -----------------------------------------------------------------------------
// Creates a Constant or Global Variable
std::string prob::sym::visitor::Visitor::global(llvm::Module& M) {
  std::stringstream ss;
  // Global Variables
  for (llvm::GlobalVariable& G : M.globals()) {
    if (!G.hasInitializer()) continue;
    std::string sym = symbol(&G, &M);
    llvm::Constant* initializer = G.getInitializer();
    std::string typ = type(initializer->getType());
    std::string value = constant(initializer, &M);
    std::string inst = sym + " <- " + "galloc(" + typ + ", " + value + ")";
    //    utility::attachMetadata(G, "global", Visitor::instruction(inst));
    ss << inst << "\n";
    R << ss.str();
  }
  return ss.str();
}

// -----------------------------------------------------------------------------
// Visit Module -> Function -> BasicBlock
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitModule(
    llvm::Module& M) {
  llvm::outs() << llvm::raw_ostream::CYAN << "Module             | "
               << M.getName() << llvm::raw_ostream::RESET << "\n";
  // initialize module.
  Module = &M;

  // Struct Types (it seems we don't need types on R)
  // Add types to the each functions with a special metadata.
  llvm::outs() << llvm::raw_ostream::MAGENTA << "Types              | "
               << llvm::raw_ostream::GREEN << symbol::Sigma << "{\n";
  for (const auto& st : M.getIdentifiedStructTypes()) {
    std::string expr = utility::printType(st);
    std::smatch match;
    std::regex pattern("(%\\S*) = type \\{ (.*?) \\}");
    std::regex_search(expr, match, pattern);
    if (match.empty()) continue;
    std::string sym = match[1].str();
    std::string type = match[2].str();
    const std::string inst =
        "typ$\\\"" + sym + "\\\" <- " + "\\\"" + type + "\\\"";
    llvm::outs() << inst << "\n";
    R << inst << "\n";
  }
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;

  // Globals
  llvm::outs() << llvm::raw_ostream::MAGENTA << "Globals            | "
               << llvm::raw_ostream::GREEN << symbol::Sigma << "{\n";
  llvm::outs() << global(M);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitFunction(
    llvm::Function& F) {
  // prologue
  llvm::outs() << llvm::raw_ostream::MAGENTA << "Function           | "
               << F.getName() << "  " << llvm::raw_ostream::RESET
               << llvm::raw_ostream::GREEN << symbol::Sigma << "{";

  std::string s;
  llvm::raw_string_ostream ss(s);

  // get distributions pragmas of parameters if exists
  llvm::StringMap<std::string> par2distr;
  llvm::SmallVector<llvm::MDNode*, 5> metadata;
  F.getMetadata("distribution", metadata);
  for (const auto& datum : metadata) {
    llvm::StringRef distr =
        llvm::cast<llvm::MDString>(datum->getOperand(0))->getString();
    llvm::SmallVector<llvm::StringRef, 2> split;
    distr.split(split, "<-");
    if (!split.empty()) {
      std::string key =
          std::regex_replace(split[0].str(), std::regex("^ +| +$|( ) +"), "$1");
      key = "sym$\\\"" + key + "\\\"";
      std::string value =
          std::regex_replace(split[1].str(), std::regex("^ +| +$|( ) +"), "$1");
      par2distr[key] = value;
      llvm::outs() << key << " <- " << value << "\n";
    }
  }

  // if the function is a declaration then skip it.
  if (F.isDeclaration()) {
    llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
    return;
  }

  // insert block initialization for PHI nodes
  if (!F.getEntryBlock().empty()) {
    std::vector<std::string> block_inits;
    for (auto& B : F) {
      block_inits.push_back(B.getName().str() + " <- FALSE");
    }
    std::string stmts = utility::concat(block_inits);
    utility::attachMetadata(F, "store", stmts);
  }

  for (auto& arg : F.args()) {
    std::string expression;
    std::string name = Visitor::symbol(&arg, Module);
    auto found = par2distr.find(name);
    if (found != par2distr.end()) {
      expression = found->getValue();
    } else {
      auto* type = arg.getType();
      // if this is one of the six floating-point types
      if (type->isFloatingPointTy()) expression = Continuous;
      // if this is instance of Integer type
      else if (type->isIntegerTy())
        expression = Discrete;
      else if (type->isPointerTy() &&
               type->getPointerElementType()->isIntegerTy())
        expression = "galloc(\\\"i32\\\", 0)";
      else if (type->isPointerTy() &&
               type->getPointerElementType()->isFloatingPointTy())
        expression = "galloc(\\\"float\\\", 0)";
      else {
        expression =
            "\"Type is not supported: " + utility::printType(type) + "\"";
      }
    }
    R << utility::attachMetadata((llvm::Value*)&arg, "formal",
                                 std::make_pair(name, expression));
    R << '\n';
    ss << name << " <- " << expression << "; ";
  }
  // epilogue
  llvm::outs() << ss.str() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitBasicBlock(
    llvm::BasicBlock& BB) {
  llvm::outs() << llvm::raw_ostream::RED << " Basic Block       | ";
  BB.printAsOperand(llvm::outs(), false, Module);

  llvm::outs() << llvm::raw_ostream::CYAN << " Pred={";
  for (llvm::BasicBlock* pred : llvm::predecessors(&BB)) {
    pred->printAsOperand(llvm::outs(), false, Module);
    llvm::outs() << " ";
  }
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// Unary Operator
// -----------------------------------------------------------------------------
// Abstract Visitor
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitUnaryOperator(
    llvm::UnaryOperator& I) {
  llvm::outs() << utility::line(I) << " Unary         |" << I << "\n";
}
// -----------------------------------------------------------------------------
// FNeg
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitFNeg(
    llvm::UnaryOperator& I) {
  llvm::outs() << utility::line(I) << " FNeg          |" << I << "\n";
}
// -----------------------------------------------------------------------------
// va_list
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitVAArgInst(
    llvm::VAArgInst& I) {
  llvm::outs() << utility::line(I) << " VAArg         |" << I << "\n";
}
// -----------------------------------------------------------------------------
// Cast operators ...
// -----------------------------------------------------------------------------
// Abstract Visitor
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitCastInst(
    llvm::CastInst& I) {
  llvm::outs() << utility::line(I) << " Cast          |" << I << "\n";
}
// -----------------------------------------------------------------------------
// Trunc (Truncation of integer types)
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitTruncInst(
    llvm::TruncInst& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
               << " Trunc         |" << llvm::raw_ostream::RESET << I
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  std::string lvalue = symbol(&I, Module);
  std::string value = symbol(I.getOperand(0), Module);
  std::string from = type(I.getSrcTy());
  std::string to = type(I.getDestTy());
  std::string rvalue = "trunc(" + from + ", " + value + ", " + to + ")";
  std::string expression = lvalue + " <- " + rvalue;

  R << expression << "\n";
  llvm::outs() << utility::attachMetadata(I, "store", expression);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// ZExt (Zero extension of integer types)
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitZExtInst(
    llvm::ZExtInst& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
               << " ZExt          |" << llvm::raw_ostream::RESET << I
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  std::string lvalue = symbol(&I, Module);
  std::string value = symbol(I.getOperand(0), Module);
  std::string from = type(I.getSrcTy());
  std::string to = type(I.getDestTy());
  std::string rvalue = "zext(" + from + ", " + value + ", " + to + ")";
  std::string expression = lvalue + " <- " + rvalue;

  R << expression << "\n";
  llvm::outs() << utility::attachMetadata(I, "store", expression);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// SExt (Sign extension of integer types)
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitSExtInst(
    llvm::SExtInst& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
               << " SExt          |" << llvm::raw_ostream::RESET << I
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  std::string lvalue = symbol(&I, Module);
  std::string value = symbol(I.getOperand(0), Module);
  std::string from = type(I.getSrcTy());
  std::string to = type(I.getDestTy());
  std::string rvalue = "sext(" + from + ", " + value + ", " + to + ")";
  std::string expression = lvalue + " <- " + rvalue;

  R << expression << "\n";
  llvm::outs() << utility::attachMetadata(I, "store", expression);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// FPTrunc (Truncation of floating point types)
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitFPTruncInst(
    llvm::FPTruncInst& I) {
  llvm::outs() << utility::line(I) << " FPTrunc       |" << I << "\n";
}
// -----------------------------------------------------------------------------
// FPExt (Extension of floating point types)
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitFPExtInst(
    llvm::FPExtInst& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
               << " FPExt         |" << llvm::raw_ostream::RESET << I
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  std::string lvalue = symbol(&I, Module);
  std::string value = symbol(I.getOperand(0), Module);
  std::string from = type(I.getSrcTy());
  std::string to = type(I.getDestTy());
  std::string rvalue = "fpext(" + from + ", " + value + ", " + to + ")";
  std::string expression = lvalue + " <- " + rvalue;

  R << expression << "\n";
  llvm::outs() << utility::attachMetadata(I, "store", expression);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// FPToUI (cast from floating point to unsigned integer)
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitFPToUIInst(
    llvm::FPToUIInst& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
               << " FPToUI        |" << llvm::raw_ostream::RESET << I
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  std::string lvalue = symbol(&I, Module);
  std::string value = symbol(I.getOperand(0), Module);
  std::string from = type(I.getSrcTy());
  std::string to = type(I.getDestTy());
  std::string rvalue = "fptoui(" + from + ", " + value + ", " + to + ")";
  std::string expression = lvalue + " <- " + rvalue;

  R << expression << "\n";
  llvm::outs() << utility::attachMetadata(I, "store", expression);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// FPToSI (cast from floating point to signed integer)
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitFPToSIInst(
    llvm::FPToSIInst& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
               << " FPToSI        |" << llvm::raw_ostream::RESET << I
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  std::string lvalue = symbol(&I, Module);
  std::string value = symbol(I.getOperand(0), Module);
  std::string from = type(I.getSrcTy());
  std::string to = type(I.getDestTy());
  std::string rvalue = "fptosi(" + from + ", " + value + ", " + to + ")";
  std::string expression = lvalue + " <- " + rvalue;

  R << expression << "\n";
  llvm::outs() << utility::attachMetadata(I, "store", expression);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// UIToSI (cast from unsigned integer to floating point)
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitUIToFPInst(
    llvm::UIToFPInst& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
               << " UIToFP        |" << llvm::raw_ostream::RESET << I
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  std::string lvalue = symbol(&I, Module);
  std::string value = symbol(I.getOperand(0), Module);
  std::string from = type(I.getSrcTy());
  std::string to = type(I.getDestTy());
  std::string rvalue = "uitosi(" + from + ", " + value + ", " + to + ")";
  std::string expression = lvalue + " <- " + rvalue;

  R << expression << "\n";
  llvm::outs() << utility::attachMetadata(I, "store", expression);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// SIToFP (cast from signed integer to floating point)
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitSIToFPInst(
    llvm::SIToFPInst& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
               << " SIToFP        |" << llvm::raw_ostream::RESET << I
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  std::string lvalue = symbol(&I, Module);
  std::string value = symbol(I.getOperand(0), Module);
  std::string from = type(I.getSrcTy());
  std::string to = type(I.getDestTy());
  std::string rvalue = "sitofp(" + from + ", " + value + ", " + to + ")";
  std::string expression = lvalue + " <- " + rvalue;

  R << expression << "\n";
  llvm::outs() << utility::attachMetadata(I, "store", expression);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// PtrToInt (cast from pointer to integer)
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitPtrToIntInst(
    llvm::PtrToIntInst& I) {
  llvm::outs() << utility::line(I) << " PtrToInt      |" << I << "\n";
}
// -----------------------------------------------------------------------------
// IntToPtr (cast from integer to pointer)
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitIntToPtrInst(
    llvm::IntToPtrInst& I) {
  llvm::outs() << utility::line(I) << " IntToPtr      |" << I << "\n";
}
// -----------------------------------------------------------------------------
// BitCast (noop cast from one type to another)
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitBitCastInst(
    llvm::BitCastInst& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
               << " BitCast       |" << llvm::raw_ostream::RESET << I
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  std::string lvalue = symbol(&I, Module);
  std::string value = symbol(I.getOperand(0), Module);
  std::string from = type(I.getSrcTy());
  std::string to = type(I.getDestTy());
  std::string rvalue = "bitcast(" + from + ", " + value + ", " + to + ")";
  std::string expression = lvalue + " <- " + rvalue;

  R << expression << "\n";
  llvm::outs() << utility::attachMetadata(I, "store", expression);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// AddrSpaceCast (conversion between pointers from one address space to
// another)
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitAddrSpaceCastInst(
    llvm::AddrSpaceCastInst& I) {
  llvm::outs() << utility::line(I) << " AddrSpaceCast |" << I << "\n";
}
// -----------------------------------------------------------------------------
// Memory operators...
// -----------------------------------------------------------------------------
// Alloca
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitAllocaInst(
    llvm::AllocaInst& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
               << " Alloca        |" << llvm::raw_ostream::RESET << I
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  std::string lvalue = symbol(&I, Module);

  std::string typ = type(I.getAllocatedType());
  std::string expression = lvalue + " <- alloca(" + typ + ")";
  R << expression << "\n";
  llvm::outs() << utility::attachMetadata(I, "store", expression);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}

// -----------------------------------------------------------------------------
// Load
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitLoadInst(
    llvm::LoadInst& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
               << " Load          |" << llvm::raw_ostream::RESET << I
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  std::string lvalue = symbol(&I, Module);
  std::string rvalue;
  if (llvm::isa<llvm::GetElementPtrInst>(I.getPointerOperand())) {
    rvalue = symbol(I.getPointerOperand(), Module);
  } else if (llvm::GEPOperator* gep =
                 llvm::dyn_cast<llvm::GEPOperator>(I.getPointerOperand())) {
    rvalue = getGEP(gep, Module);
  } else {
    rvalue = symbol(I.getPointerOperand(), Module);
  }

  std::string expression = lvalue + " <- load(" + rvalue + ")";
  R << expression << "\n";
  llvm::outs() << utility::attachMetadata(I, "store", expression);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// Store
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitStoreInst(
    llvm::StoreInst& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
               << " Store         |" << llvm::raw_ostream::RESET << I
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  std::string value;
  if (llvm::isa<llvm::GetElementPtrInst>(I.getValueOperand())) {
    value = symbol(I.getValueOperand(), Module);
  } else if (llvm::GEPOperator* gep =
                 llvm::dyn_cast<llvm::GEPOperator>(I.getValueOperand())) {
    value = getGEP(gep, Module);
  } else {
    value = symbol(I.getValueOperand(), Module);
  }

  std::string pointer;
  if (llvm::isa<llvm::GetElementPtrInst>(I.getPointerOperand())) {
    pointer = symbol(I.getPointerOperand(), Module);
  } else if (llvm::GEPOperator* gep =
                 llvm::dyn_cast<llvm::GEPOperator>(I.getPointerOperand())) {
    pointer = getGEP(gep, Module);
  } else {
    pointer = symbol(I.getPointerOperand(), Module);
  }

  std::string expression = "store(" + value + ", " + pointer + ")";

  R << expression << "\n";
  llvm::outs() << utility::attachMetadata(I, "store", expression);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// GetElementPtr
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitGetElementPtr(
    llvm::GetElementPtrInst& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
               << " GetElementPtr |" << llvm::raw_ostream::RESET << I
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  std::string lvalue;
  std::string pointer;
  std::string expression;
  if (auto* innerGep = llvm::dyn_cast<llvm::GEPOperator>(I.getOperand(0))) {
    std::string sym = symbol(innerGep->getOperand(0), Module);
    std::string base = symbol(innerGep->getOperand(1), Module);
    std::string typ = type(innerGep->getSourceElementType());
    expression = "sym$tempGep <- gep(" + typ + ", " + sym + ", " + base;
    for (int i = 2; i < innerGep->getNumOperands(); ++i) {
      std::string offset = symbol(innerGep->getOperand(i), Module);
      expression = expression + ", " + offset;
    }
    expression = expression + "); ";

    lvalue = symbol(&I, Module);
    expression = expression + lvalue + " <- ";
    base = symbol(I.getOperand(1), Module);
    typ = type(I.getSourceElementType());
    expression = expression + "gep(" + typ + ", sym$tempGep, " + base;
    for (int i = 2; i < I.getNumOperands(); ++i) {
      std::string offset = symbol(I.getOperand(i), Module);
      expression = expression + ", " + offset;
    }
    expression = expression + ")";

  } else {
    lvalue = symbol(&I, Module);
    pointer = getGEP(I, Module);
    expression = lvalue + " <- " + pointer;
  }

  R << expression << "\n";
  llvm::outs() << utility::attachMetadata(I, "store", expression);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// Fence
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitFence(
    llvm::FenceInst& I) {
  llvm::outs() << utility::line(I) << " Fence              |" << I << "\n";
  InstVisitor::visitFence(I);
}
// -----------------------------------------------------------------------------
// AtomicCmpXchg
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitAtomicCmpXchg(
    llvm::AtomicCmpXchgInst& I) {
  llvm::outs() << utility::line(I) << " AtomicCmpXchg      |" << I << "\n";
  InstVisitor::visitAtomicCmpXchg(I);
}
// -----------------------------------------------------------------------------
// AtomicRMW
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitAtomicRMW(
    llvm::AtomicRMWInst& I) {
  llvm::outs() << utility::line(I) << " AtomicRMW          |" << I << "\n";
  InstVisitor::visitAtomicRMW(I);
}
// -----------------------------------------------------------------------------
// Standard binary operators...
// -----------------------------------------------------------------------------
// Abstract Visitor
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitBinaryOperator(
    llvm::BinaryOperator& I) {}
// -----------------------------------------------------------------------------
// Add
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitAdd(
    llvm::BinaryOperator& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
               << " Add           |" << llvm::raw_ostream::RESET << I
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  BinaryOperation op(I);
  std::string lvalue = op.Name;
  std::string rvalue = "add(" + op.Left + ", " + op.Right + ")";

  std::string expression = lvalue + " <- " + rvalue;

  R << expression << "\n";
  llvm::outs() << utility::attachMetadata(I, "store", expression);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// FAdd
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitFAdd(
    llvm::BinaryOperator& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
               << " FAdd          |" << llvm::raw_ostream::RESET << I
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  BinaryOperation op(I);
  std::string lvalue = op.Name;
  std::string rvalue = "add(" + op.Left + ", " + op.Right + ")";

  std::string expression = lvalue + " <- " + rvalue;

  R << expression << "\n";
  llvm::outs() << utility::attachMetadata(I, "store", expression);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// Sub
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitSub(
    llvm::BinaryOperator& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
               << " Sub           |" << llvm::raw_ostream::RESET << I
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  BinaryOperation op(I);
  std::string lvalue = op.Name;
  std::string rvalue = "sub(" + op.Left + ", " + op.Right + ")";

  std::string expression = lvalue + " <- " + rvalue;

  R << expression << "\n";
  llvm::outs() << utility::attachMetadata(I, "store", expression);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// FSub
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitFSub(
    llvm::BinaryOperator& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
               << " FSub          |" << llvm::raw_ostream::RESET << I
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  BinaryOperation op(I);
  std::string lvalue = op.Name;
  std::string rvalue = "sub(" + op.Left + ", " + op.Right + ")";

  std::string expression = lvalue + " <- " + rvalue;

  R << expression << "\n";
  llvm::outs() << utility::attachMetadata(I, "store", expression);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// Mul
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitMul(
    llvm::BinaryOperator& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
               << " Mul           |" << llvm::raw_ostream::RESET << I
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  BinaryOperation op(I);
  std::string lvalue = op.Name;
  std::string rvalue = "mul(" + op.Left + ", " + op.Right + ")";

  std::string expression = lvalue + " <- " + rvalue;

  R << expression << "\n";
  llvm::outs() << utility::attachMetadata(I, "store", expression);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// FMul
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitFMul(
    llvm::BinaryOperator& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
               << " FMul          |" << llvm::raw_ostream::RESET << I
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  BinaryOperation op(I);
  std::string lvalue = op.Name;
  std::string rvalue = "mul(" + op.Left + ", " + op.Right + ")";

  std::string expression = lvalue + " <- " + rvalue;

  R << expression << "\n";
  llvm::outs() << utility::attachMetadata(I, "store", expression);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// UDiv
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitUDiv(
    llvm::BinaryOperator& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
               << " UDiv          |" << llvm::raw_ostream::RESET << I
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  BinaryOperation op(I);
  std::string lvalue = op.Name;
  std::string rvalue = "div(" + op.Left + ", " + op.Right + ")";

  std::string expression = lvalue + " <- " + rvalue;

  R << expression << "\n";
  llvm::outs() << utility::attachMetadata(I, "store", expression);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// SDiv
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitSDiv(
    llvm::BinaryOperator& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
               << " SDiv          |" << llvm::raw_ostream::RESET << I
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  BinaryOperation op(I);
  std::string lvalue = op.Name;
  std::string rvalue = "div(" + op.Left + ", " + op.Right + ")";

  std::string expression = lvalue + " <- " + rvalue;

  R << expression << "\n";
  llvm::outs() << utility::attachMetadata(I, "store", expression);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// FDiv
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitFDiv(
    llvm::BinaryOperator& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
               << " FDiv          |" << llvm::raw_ostream::RESET << I
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  BinaryOperation op(I);
  std::string lvalue = op.Name;
  std::string rvalue = "div(" + op.Left + ", " + op.Right + ")";

  std::string expression = lvalue + " <- " + rvalue;

  R << expression << "\n";
  llvm::outs() << utility::attachMetadata(I, "store", expression);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// URem
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitURem(
    llvm::BinaryOperator& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
               << " URem           |" << llvm::raw_ostream::RESET << I
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  BinaryOperation op(I);
  std::string lvalue = op.Name;
  std::string rvalue = "rem(" + op.Left + ", " + op.Right + ")";

  std::string expression = lvalue + " <- " + rvalue;

  R << expression << "\n";
  llvm::outs() << utility::attachMetadata(I, "store", expression);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// SRem
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitSRem(
    llvm::BinaryOperator& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
               << " SRem           |" << llvm::raw_ostream::RESET << I
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  BinaryOperation op(I);
  std::string lvalue = op.Name;
  std::string rvalue = "rem(" + op.Left + ", " + op.Right + ")";

  std::string expression = lvalue + " <- " + rvalue;

  R << expression << "\n";
  llvm::outs() << utility::attachMetadata(I, "store", expression);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// FRem
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitFRem(
    llvm::BinaryOperator& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
               << " FRem           |" << llvm::raw_ostream::RESET << I
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  BinaryOperation op(I);
  std::string lvalue = op.Name;
  std::string rvalue = "rem(" + op.Left + ", " + op.Right + ")";

  std::string expression = lvalue + " <- " + rvalue;

  R << expression << "\n";
  llvm::outs() << utility::attachMetadata(I, "store", expression);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// Logical operators (integer operands)
// -----------------------------------------------------------------------------
// Shl
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitShl(
    llvm::BinaryOperator& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
               << " Shl           |" << llvm::raw_ostream::RESET << I
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  std::string lvalue = symbol(&I, Module);
  std::string op1 = symbol(I.getOperand(0), Module);
  std::string op2 = symbol(I.getOperand(1), Module);
  std::string typ = type(I.getType());
  std::string rvalue = "shl(" + typ + ", " + op1 + ", " + op2 + ")";
  std::string expression = lvalue + " <- " + rvalue;

  R << expression << "\n";
  llvm::outs() << utility::attachMetadata(I, "store", expression);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// LShr
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitLShr(
    llvm::BinaryOperator& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
               << " LShr          |" << llvm::raw_ostream::RESET << I
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  std::string lvalue = symbol(&I, Module);
  std::string op1 = symbol(I.getOperand(0), Module);
  std::string op2 = symbol(I.getOperand(1), Module);
  std::string typ = type(I.getType());
  std::string rvalue = "lshr(" + typ + ", " + op1 + ", " + op2 + ")";
  std::string expression = lvalue + " <- " + rvalue;

  R << expression << "\n";
  llvm::outs() << utility::attachMetadata(I, "store", expression);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// AShr
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitAShr(
    llvm::BinaryOperator& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
               << " AShr          |" << llvm::raw_ostream::RESET << I
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  std::string lvalue = symbol(&I, Module);
  std::string op1 = symbol(I.getOperand(0), Module);
  std::string op2 = symbol(I.getOperand(1), Module);
  std::string typ = type(I.getType());
  std::string rvalue = "ashr(" + typ + ", " + op1 + ", " + op2 + ")";
  std::string expression = lvalue + " <- " + rvalue;

  R << expression << "\n";
  llvm::outs() << utility::attachMetadata(I, "store", expression);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// And
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitAnd(
    llvm::BinaryOperator& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
               << " And           |" << llvm::raw_ostream::RESET << I
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  std::string lvalue = symbol(&I, Module);
  std::string op1 = symbol(I.getOperand(0), Module);
  std::string op2 = symbol(I.getOperand(1), Module);
  std::string rvalue = "and(" + op1 + ", " + op2 + ")";
  std::string expression = lvalue + " <- " + rvalue;

  R << expression << "\n";
  llvm::outs() << utility::attachMetadata(I, "store", expression);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// Or
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitOr(
    llvm::BinaryOperator& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
               << " Or            |" << llvm::raw_ostream::RESET << I
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  std::string lvalue = symbol(&I, Module);
  std::string op1 = symbol(I.getOperand(0), Module);
  std::string op2 = symbol(I.getOperand(1), Module);
  std::string rvalue = "or(" + op1 + ", " + op2 + ")";
  std::string expression = lvalue + " <- " + rvalue;

  R << expression << "\n";
  llvm::outs() << utility::attachMetadata(I, "store", expression);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// Xor
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitXor(
    llvm::BinaryOperator& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
               << " Xor           |" << llvm::raw_ostream::RESET << I
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  std::string lvalue = symbol(&I, Module);
  std::string op1 = symbol(I.getOperand(0), Module);
  std::string op2 = symbol(I.getOperand(1), Module);
  std::string rvalue = "xor(" + op1 + ", " + op2 + ")";
  std::string expression = lvalue + " <- " + rvalue;

  R << expression << "\n";
  llvm::outs() << utility::attachMetadata(I, "store", expression);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// Terminator Instructions
// -----------------------------------------------------------------------------
// Abstract Visitor
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitTerminator(
    llvm::Instruction& I) {
  llvm::outs() << utility::line(I) << " Terminator    |" << I << "\n";
}
// -----------------------------------------------------------------------------
// Ret
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitReturnInst(
    llvm::ReturnInst& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
               << " Return        |" << llvm::raw_ostream::RESET << I
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  std::string retVal = (I.getReturnValue() == nullptr)
                           ? "\\\"void\\\""
                           : symbol(I.getReturnValue(), Module);

  std::vector<std::string> metadata;
  if (I.getFunction()->getReturnType()->isVoidTy() ||
      I.getFunction()->getReturnType()->isPointerTy()) {
    metadata.push_back("ret(" + retVal + ")");
  } else {
    metadata.push_back("path.return <<- c(path.return, ret(" + retVal + "))");
  }

  metadata.push_back(I.getParent()->getName().str() + " <- TRUE");
  for (llvm::BasicBlock* pred : llvm::predecessors(I.getParent())) {
    metadata.push_back(pred->getName().str() + " <- FALSE");
  }

  R << utility::attachMetadata(I, "store", metadata);

  llvm::outs() << ".ret <- ret(" << retVal << ")";
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// Br
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitBranchInst(
    llvm::BranchInst& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::MAGENTA
               << " Branch        |" << llvm::raw_ostream::RESET << I
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  std::string metadata;

  if (I.isConditional()) {  // getNumOperands() == 3
    std::string cond = symbol(I.getCondition(), Module);
    // REVIEW: why True leg is the last operand?
    std::string t = symbol(I.getOperand(2), Module);
    std::string f = symbol(I.getOperand(1), Module);
    metadata = "br(" + t + ", " + f + ", " + cond + ")";

    // conditional knowledge update (pseudo phi instructions are added)
    llvm::StringRef update;
    if (llvm::MDNode* nodeU = I.getMetadata("update")) {
      update = llvm::cast<llvm::MDString>(nodeU->getOperand(0))->getString();
    }
    if (!update.empty()) {
      std::string name = I.getCondition()->getName().str();
      std::string t_leg =
          cond + " <- sym$\\\"" + name + ".true\\\"; " + update.str();
      std::string f_leg =
          cond + " <- sym$\\\"" + name + ".false\\\"; " + update.str();
      std::string t_phi =
          "if(" + I.getParent()->getName().str() + ") {" + t_leg + "};";
      std::string f_phi =
          "if(" + I.getParent()->getName().str() + ") {" + f_leg + "};";

      {
        // find true block's first instruction
        llvm::BasicBlock::iterator i = I.getSuccessor(0)->begin();
        llvm::Instruction& inst = *i;
        // get the annotation and append the update
        std::string annotation;
        if (llvm::MDNode* nodeU = inst.getMetadata("undo")) {
          annotation =
              llvm::cast<llvm::MDString>(nodeU->getOperand(0))->getString();
        }
        // add update instruction
        annotation += t_phi;
        utility::attachMetadata(inst, "undo", annotation);
      }
      {
        // find true block's first instruction
        llvm::BasicBlock::iterator i = I.getSuccessor(1)->begin();
        llvm::Instruction& inst = *i;
        // get the annotation and append the update
        std::string annotation;
        if (llvm::MDNode* nodeU = inst.getMetadata("undo")) {
          annotation =
              llvm::cast<llvm::MDString>(nodeU->getOperand(0))->getString();
        }
        // add update instruction
        annotation += f_phi;
        utility::attachMetadata(inst, "undo", annotation);
      }
    }
  } else {
    std::string t = symbol(I.getOperand(0), Module);
    metadata = "br(" + t + ")";
  }

  R << utility::attachMetadata(I, "store", metadata);
  llvm::outs() << metadata;
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// Switch
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitSwitchInst(
    llvm::SwitchInst& I) {
  llvm::outs() << utility::line(I) << " Switch Inst.       |" << I << "\n";
}
// -----------------------------------------------------------------------------
// IndirectBr
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitIndirectBrInst(
    llvm::IndirectBrInst& I) {
  llvm::outs() << utility::line(I) << " IndirectBr Inst.   |" << I << "\n";
}
// -----------------------------------------------------------------------------
// Resume
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitResumeInst(
    llvm::ResumeInst& I) {
  llvm::outs() << utility::line(I) << " Resume Inst.       |" << I << "\n";
}
// -----------------------------------------------------------------------------
// Unreachable
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitUnreachableInst(
    llvm::UnreachableInst& I) {
  llvm::outs() << utility::line(I) << " Unreachable Inst.  |" << I << "\n";
}
// -----------------------------------------------------------------------------
// CleanupRet
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitCleanupReturnInst(
    llvm::CleanupReturnInst& I) {
  llvm::outs() << utility::line(I) << " CleanupReturn Inst.|" << I << "\n";
}
// -----------------------------------------------------------------------------
// CatchRet
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitCatchReturnInst(
    llvm::CatchReturnInst& I) {
  llvm::outs() << utility::line(I) << " CatchReturn Inst.  |" << I << "\n";
}
// -----------------------------------------------------------------------------
// CatchSwitch
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitCatchSwitchInst(
    llvm::CatchSwitchInst& I) {
  llvm::outs() << utility::line(I) << " CatchSwitch Instr. |" << I << "\n";
}
// -----------------------------------------------------------------------------
// FuncLetPad Instructions
// -----------------------------------------------------------------------------
// Abstract FuncletPad
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitFuncletPadInst(
    llvm::FuncletPadInst& I) {
  llvm::outs() << utility::line(I) << " FuncletPad Instr.  |" << I << "\n";
}
// -----------------------------------------------------------------------------
// CleanupPad
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitCleanupPad(
    llvm::CleanupPadInst& I) {
  llvm::outs() << utility::line(I) << " Cleanup Instr.     |" << I << "\n";
}
// -----------------------------------------------------------------------------
// CatchPad
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitCatchPad(
    llvm::CatchPadInst& I) {
  llvm::outs() << utility::line(I) << " CatchPad Instr.    |" << I << "\n";
}
// -----------------------------------------------------------------------------
// Compare Instructions
// -----------------------------------------------------------------------------
// Abstract
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitCmpInst(
    llvm::CmpInst& I) {
  llvm::outs() << utility::line(I) << " Cmp Instruction    |" << I << "\n";
}

//
std::string prob::sym::visitor::Visitor::inverseLoad(llvm::LoadInst* I) {
  std::string lvalue = symbol(I, Module);
  std::string rvalue;
  if (llvm::isa<llvm::GetElementPtrInst>(I->getPointerOperand())) {
    rvalue = symbol(I->getPointerOperand(), Module);
    if (llvm::isa<llvm::GlobalVariable>(I->getPointerOperand()) ||
        llvm::isa<llvm::Argument>(I->getPointerOperand()))
      if (I->getPointerOperand()->getType()->isPointerTy())
        ;  // rvalue = "ptr(" + rvalue + ")";
  } else if (llvm::GEPOperator* gep =
                 llvm::dyn_cast<llvm::GEPOperator>(I->getPointerOperand())) {
    rvalue = getGEP(gep, Module);
  } else if (llvm::isa<llvm::GlobalVariable>(I->getPointerOperand()) ||
             llvm::isa<llvm::Argument>(I->getPointerOperand())) {
    if (I->getPointerOperand()->getType()->isPointerTy())
      rvalue = symbol(I->getPointerOperand(), Module);
    //      rvalue = "ptr(" + symbol(I->getPointerOperand(), Module) + ")";
    else
      rvalue = symbol(I->getPointerOperand(), Module);
  } else {
    rvalue = symbol(I->getPointerOperand(), Module);
  }
  return "store(" + lvalue + ", " + rvalue + "); ";
}

// V is an operand
std::string prob::sym::visitor::Visitor::useDefChain(llvm::Value* V) {
  std::string ret;
  llvm::outs() << symbol(V, Module) << "\n";
  if (auto* arg = llvm::dyn_cast<llvm::Argument>(V)) {
    llvm::outs() << *arg << "\n";
  } else if (auto* inst = llvm::dyn_cast<llvm::Instruction>(V)) {
    // if it is an instruction, start getting inverses
    llvm::outs() << *inst << "\n";
    // if it is a load, take the inverse.
    if (auto* load = llvm::dyn_cast<llvm::LoadInst>(V)) ret = inverseLoad(load);
    // if it not a phi instruction
    if (inst->getOpcode() != llvm::Instruction::PHI) {
      // for each operand of the instruction
      for (llvm::Use& U : inst->operands()) {
        llvm::Value* value = U.get();
        if (auto* c = llvm::dyn_cast<llvm::Constant>(value)) {
          if (c->getType()->isIntegerTy() || c->getType()->isFloatingPointTy())
            continue;
        }
        // if the instruction is cmp, take the current operand's inverse
        if (auto* c = llvm::dyn_cast<llvm::CmpInst>(inst)) {
          std::string cmp = symbol(c, Module);
          std::string op1 = symbol(c->getOperand(0), Module);
          std::string op2 = symbol(c->getOperand(1), Module);
          if (c->getOperand(0) == value)
            ret += "{if (is(" + op1 + ", \\\"Distribution\\\")) " + op1 +
                   " <- add(" + cmp + ", " + op2 + ")};";
          else if (c->getOperand(1) == value)
            ret += "{if (is(" + op2 + ", \\\"Distribution\\\")) " + op2 +
                   " <- sub(" + op1 + ", " + cmp + ")};";
        }
        ret += useDefChain(value);
      }
    }
  }
  return ret;
}

// -----------------------------------------------------------------------------
// ICmp
// -----------------------------------------------------------------------------
// ICMP_EQ = 32,  ///< equal
// ICMP_NE = 33,  ///< not equal
// ICMP_UGT = 34, ///< unsigned greater than
// ICMP_UGE = 35, ///< unsigned greater or equal
// ICMP_ULT = 36, ///< unsigned less than
// ICMP_ULE = 37, ///< unsigned less or equal
// ICMP_SGT = 38, ///< signed greater than
// ICMP_SGE = 39, ///< signed greater or equal
// ICMP_SLT = 40, ///< signed less than
// ICMP_SLE = 41, ///< signed less or equal
[[maybe_unused]] void prob::sym::visitor::Visitor::visitICmpInst(
    llvm::ICmpInst& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::MAGENTA
               << " ICmp          |" << I << llvm::raw_ostream::RESET
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";
  std::string lvalue = symbol(&I, Module);
  std::string rvalue = "icmp(" + I.getPredicateName(I.getPredicate()).str() +
                       ", " + symbol(I.getOperand(0), Module) + ", " +
                       symbol(I.getOperand(1), Module) + ")";

  std::string expression = lvalue + " <- " + rvalue;

  R << expression << "\n";
  llvm::outs() << utility::attachMetadata(I, "store", expression);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;

  std::string update = useDefChain(&I);

  llvm::outs() << llvm::raw_ostream::GREEN << "  " << symbol::Rho << "{";
  auto* terminator = I.getParent()->getTerminator();
  llvm::outs() << utility::attachMetadata(*terminator, "update", update);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// FCmp
// -----------------------------------------------------------------------------
//    Opcode            U L G E    Intuitive operation
// FCMP_FALSE = 0, ///< 0 0 0 0    Always false (always folded)
// FCMP_OEQ = 1,   ///< 0 0 0 1    True if ordered and equal
// FCMP_OGT = 2,   ///< 0 0 1 0    True if ordered and greater than
// FCMP_OGE = 3,   ///< 0 0 1 1    True if ordered and greater than or equal
// FCMP_OLT = 4,   ///< 0 1 0 0    True if ordered and less than
// FCMP_OLE = 5,   ///< 0 1 0 1    True if ordered and less than or equal
// FCMP_ONE = 6,   ///< 0 1 1 0    True if ordered and operands are unequal
// FCMP_ORD = 7,   ///< 0 1 1 1    True if ordered (no nans)
// FCMP_UNO = 8,   ///< 1 0 0 0    True if unordered: isnan(X) | isnan(Y)
// FCMP_UEQ = 9,   ///< 1 0 0 1    True if unordered or equal
// FCMP_UGT = 10,  ///< 1 0 1 0    True if unordered or greater than
// FCMP_UGE = 11,  ///< 1 0 1 1    True if unordered, greater than, or equal
// FCMP_ULT = 12,  ///< 1 1 0 0    True if unordered or less than
// FCMP_ULE = 13,  ///< 1 1 0 1    True if unordered, less than, or equal
// FCMP_UNE = 14,  ///< 1 1 1 0    True if unordered or not equal
// FCMP_TRUE = 15, ///< 1 1 1 1    Always true (always folded)
[[maybe_unused]] void prob::sym::visitor::Visitor::visitFCmpInst(
    llvm::FCmpInst& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::MAGENTA
               << " FCmp          |" << I << llvm::raw_ostream::RESET
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  std::string lvalue = symbol(&I, Module);
  std::string rvalue = "fcmp(" + I.getPredicateName(I.getPredicate()).str() +
                       ", " + symbol(I.getOperand(0), Module) + ", " +
                       symbol(I.getOperand(1), Module) + ")";

  std::string expression = lvalue + " <- " + rvalue;

  R << expression << "\n";
  llvm::outs() << utility::attachMetadata(I, "store", expression);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;

  std::string update = useDefChain(&I);

  llvm::outs() << llvm::raw_ostream::GREEN << "  " << symbol::Rho << "{";
  auto* terminator = I.getParent()->getTerminator();
  llvm::outs() << utility::attachMetadata(*terminator, "update", update);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// Vector Instructions
// -----------------------------------------------------------------------------
// ExtractElement
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitExtractElementInst(
    llvm::ExtractElementInst& I) {
  llvm::outs() << utility::line(I) << " ExtractElement|" << I << "\n";
}
// -----------------------------------------------------------------------------
// InsertElement
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitInsertElementInst(
    llvm::InsertElementInst& I) {
  llvm::outs() << utility::line(I) << " InsertElement |" << I << "\n";
}
// -----------------------------------------------------------------------------
// ShuffleVector
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitShuffleVectorInst(
    llvm::ShuffleVectorInst& I) {
  llvm::outs() << utility::line(I) << " ShuffleVector |" << I << "\n";
}
// -----------------------------------------------------------------------------
// Aggregate Instructions
// -----------------------------------------------------------------------------
// ExtractValue
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitExtractValueInst(
    llvm::ExtractValueInst& I) {
  llvm::outs() << utility::line(I) << " ExtractValue  |" << I << "\n";
}
// -----------------------------------------------------------------------------
// InsertValue
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitInsertValueInst(
    llvm::InsertValueInst& I) {
  llvm::outs() << utility::line(I) << " InsertValue   |" << I << "\n";
}
// -----------------------------------------------------------------------------
// Other Operators
// -----------------------------------------------------------------------------
// PHI
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitPHINode(
    llvm::PHINode& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
               << " PHI Node      |" << llvm::raw_ostream::RESET << I
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  std::string ret = symbol(&I, Module);
  std::vector<std::string> stmts;
  for (const auto& value : I.incoming_values()) {
    std::string condition =
        "if (" + I.getIncomingBlock(value)->getName().str() + ") ";
    std::string stmt = condition + symbol(value, Module);
    stmts.push_back(stmt);
  }
  std::string metadata = ret + " <- " + utility::concat(stmts, " else ", "");
  utility::attachMetadata(I, "store", metadata);
  R << metadata;
  llvm::outs() << metadata;
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// Select
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitSelectInst(
    llvm::SelectInst& I) {
  llvm::outs() << utility::line(I) << " Select        |" << I << "\n";
}
// -----------------------------------------------------------------------------
// Exception Handling
// -----------------------------------------------------------------------------
// LandingPad
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitLandingPadInst(
    llvm::LandingPadInst& I) {
  llvm::outs() << utility::line(I) << " LandingPad    |" << I << "\n";
}
// -----------------------------------------------------------------------------
// Freeze
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitFreezeInst(
    llvm::FreezeInst& I) {
  llvm::outs() << utility::line(I) << " Freeze        |" << I << "\n";
}
// -----------------------------------------------------------------------------
// Intrinsic Instructions (They are functions `calls`)
// -----------------------------------------------------------------------------
// Abstract Visitor
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitIntrinsicInst(
    llvm::IntrinsicInst& I) {
  llvm::outs() << utility::line(I) << " Intrinsic     |" << I << "\n";
}
// -----------------------------------------------------------------------------
// DbgVariableIntrinsic
// -----------------------------------------------------------------------------
// Abstract Visitor
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitDbgVariableIntrinsic(
    llvm::DbgVariableIntrinsic& I) {
  llvm::outs() << utility::line(I) << " DbgVariable   |" << I << "\n";
}
// -----------------------------------------------------------------------------
// dbg_declare
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitDbgDeclareInst(
    llvm::DbgDeclareInst& I) {
  llvm::outs() << utility::line(I) << " DbgDeclare    |" << I << "\n";
}
// -----------------------------------------------------------------------------
// dbg_value
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitDbgValueInst(
    llvm::DbgValueInst& I) {
  llvm::outs() << utility::line(I) << " DbgValue      |" << I << "\n";
}
// -----------------------------------------------------------------------------
// dbg_label
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitDbgLabelInst(
    llvm::DbgLabelInst& I) {
  llvm::outs() << utility::line(I) << " DbgLabel      |" << I << "\n";
}
// -----------------------------------------------------------------------------
// Abstract ??
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitDbgInfoIntrinsic(
    llvm::DbgInfoIntrinsic& I) {
  llvm::outs() << utility::line(I) << " DbgInfo       |" << I << "\n";
}
// -----------------------------------------------------------------------------
// MemIntrinsics
// -----------------------------------------------------------------------------
// Abstract
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitMemIntrinsic(
    llvm::MemIntrinsic& I) {
  llvm::outs() << utility::line(I) << " Mem Intrinsic |" << I << "\n";
}
// -----------------------------------------------------------------------------
// wraps llvm.memcpy/memmove intrinsics.
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitMemTransferInst(
    llvm::MemTransferInst& I) {
  llvm::outs() << utility::line(I) << " MemTransfer   |" << I << "\n";
}
// -----------------------------------------------------------------------------
// memset
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitMemSetInst(
    llvm::MemSetInst& I) {
  llvm::outs() << utility::line(I) << " MemSet        |" << I << "\n";
}
// -----------------------------------------------------------------------------
// memcpy
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitMemCpyInst(
    llvm::MemCpyInst& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
               << " MemCpy        |" << llvm::raw_ostream::RESET << I
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  std::string arg1 = symbol(I.getArgOperand(0), Module);
  std::string arg2 = symbol(I.getArgOperand(1)->stripPointerCasts(), Module);
  auto* pt = llvm::cast<llvm::PointerType>(
      I.getArgOperand(1)->stripPointerCasts()->getType());
  std::string typ = type(pt->getElementType());
  std::string expression = "memcpy(" + arg1 + ", " + arg2 + ", " + typ + ")";
  R << expression << "\n";
  llvm::outs() << utility::attachMetadata(I, "store", expression);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// memmve
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitMemMoveInst(
    llvm::MemMoveInst& I) {
  llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
               << " MemMove       |" << llvm::raw_ostream::RESET << I
               << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

  std::string arg1 = symbol(I.getArgOperand(0), Module);
  std::string arg2 = symbol(I.getArgOperand(1)->stripPointerCasts(), Module);
  auto* pt = llvm::cast<llvm::PointerType>(
      I.getArgOperand(1)->stripPointerCasts()->getType());
  std::string typ = type(pt->getElementType());
  std::string expression = "memmve(" + arg1 + ", " + arg2 + ", " + typ + ")";
  R << expression << "\n";
  llvm::outs() << utility::attachMetadata(I, "store", expression);
  llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
}
// -----------------------------------------------------------------------------
// llvm.va_start
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitVAStartInst(
    llvm::VAStartInst& I) {
  llvm::outs() << utility::line(I) << " VAStart       |" << I << "\n";
}
// -----------------------------------------------------------------------------
// llvm.va_end
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitVAEndInst(
    llvm::VAEndInst& I) {
  llvm::outs() << utility::line(I) << " VAEnd         |" << I << "\n";
}
// -----------------------------------------------------------------------------
// llvm.va_copy
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitVACopyInst(
    llvm::VACopyInst& I) {
  llvm::outs() << utility::line(I) << " VACopy        |" << I << "\n";
}
// ----------------------------------------------------------------------------
// CallBase
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitCallInst(
    llvm::CallInst& I) {
  llvm::Function* called = I.getCalledFunction();

  // check function owning a reliability metadata

  //  llvm::SmallVector<llvm::MDNode*, 5> Metadata;
  //  called->getFunction().getMetadata("timing", Metadata);
  //  for (const auto& Datum : Metadata) {
  //    llvm::StringRef Store =
  //        llvm::cast<llvm::MDString>(Datum->getOperand(0))->getString();
  //    std::string cap = Store.str();
  //    std::smatch match;
  //    std::regex pattern("(\\S*)");
  //    std::regex_search(cap, match, pattern);
  //    if (!match.empty()) {
  //      break;
  //    }
  //  }

  if (called->getName() == "malloc" || called->getName() == "_Znwm") {
    llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
                 << " Call          |" << llvm::raw_ostream::RESET << I
                 << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

    std::string lvalue = symbol(&I, Module);
    std::string size = symbol(I.getOperand(0), Module);
    std::string expression = lvalue + " <- malloc(" + size + ")";

    R << expression << "\n";
    llvm::outs() << utility::attachMetadata(I, "store", expression);
    llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
  } else if (called->getName() == "memcmp") {
    llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
                 << " Call          |" << llvm::raw_ostream::RESET << I
                 << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

    std::string lvalue = symbol(&I, Module);
    std::string arg1 = symbol(I.getArgOperand(0), Module);
    std::string arg2 = symbol(I.getArgOperand(1), Module);
    std::string arg3 = symbol(I.getArgOperand(2), Module);
    std::string expression =
        lvalue + " <- memcmp(" + arg1 + ", " + arg2 + ", " + arg3 + ")";

    R << expression << "\n";
    llvm::outs() << utility::attachMetadata(I, "store", expression);
    llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
  } else if (called->getName() == "checkpoint") {
    llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
                 << " Call          |" << llvm::raw_ostream::RESET << I
                 << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

    std::string expression = "checkpoint()";

    R << expression << "\n";
    llvm::outs() << utility::attachMetadata(I, "store", expression);
    llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
  }
  //  else if (called->getName() == "alert") {
  //    llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
  //                 << " Call          |" << llvm::raw_ostream::RESET << I
  //                 << llvm::raw_ostream::GREEN << "  " << symbol::Sigma <<
  //                 "{";
  //
  //    std::string expression = "alert()";
  //
  //    R << expression << "\n";
  //    llvm::outs() << utility::attachMetadata(I, "store", expression);
  //    llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
  //  }
  //  else if (called->getName() == "featurize") {
  //    llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
  //                 << " Call          |" << llvm::raw_ostream::RESET << I
  //                 << llvm::raw_ostream::GREEN << "  " << symbol::Sigma <<
  //                 "{";
  //
  //    std::string expression = "featurize()";
  //
  //    R << expression << "\n";
  //    llvm::outs() << utility::attachMetadata(I, "store", expression);
  //    llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
  //  }
  //  else if (called->getName() == "error") {
  //    llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
  //                 << " Call          |" << llvm::raw_ostream::RESET << I
  //                 << llvm::raw_ostream::GREEN << "  " << symbol::Sigma <<
  //                 "{";
  //
  //    std::string expression = "error()";
  //
  //    R << expression << "\n";
  //    llvm::outs() << utility::attachMetadata(I, "store", expression);
  //    llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
  //  }
  else if (called->getName() == "sin") {
    llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
                 << " Call          |" << llvm::raw_ostream::RESET << I
                 << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

    std::string lvalue = symbol(&I, Module);
    std::string arg1 = symbol(I.getArgOperand(0), Module);
    std::string expression = lvalue + " <- sin(" + arg1 + ")";

    R << expression << "\n";
    llvm::outs() << utility::attachMetadata(I, "store", expression);
    llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
  } else if (called->getName() == "cos") {
    llvm::outs() << utility::line(I) << llvm::raw_ostream::CYAN
                 << " Call          |" << llvm::raw_ostream::RESET << I
                 << llvm::raw_ostream::GREEN << "  " << symbol::Sigma << "{";

    std::string lvalue = symbol(&I, Module);
    std::string arg1 = symbol(I.getArgOperand(0), Module);
    std::string expression = lvalue + " <- cos(" + arg1 + ")";

    R << expression << "\n";
    llvm::outs() << utility::attachMetadata(I, "store", expression);
    llvm::outs() << "}\n" << llvm::raw_ostream::RESET;
  } else {
    llvm::outs() << utility::line(I) << " Call          |" << I << "\n";
  }
}
// -----------------------------------------------------------------------------
// Invoke
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitInvokeInst(
    llvm::InvokeInst& I) {
  llvm::outs() << utility::line(I) << " Invoke        |" << I << "\n";
}
// -----------------------------------------------------------------------------
// CallBr
// -----------------------------------------------------------------------------
[[maybe_unused]] void prob::sym::visitor::Visitor::visitCallBrInst(
    llvm::CallBrInst& I) {
  llvm::outs() << utility::line(I) << " CallBr        |" << I << "\n";
}
// -----------------------------------------------------------------------------
//
// -----------------------------------------------------------------------------
std::ostream& prob::sym::visitor::Visitor::write(std::ostream& out) const {
  return out << R.str() << "\n";
}
// -----------------------------------------------------------------------------
llvm::raw_ostream& prob::sym::visitor::Visitor::print(
    llvm::raw_ostream& out) const {
  return out << R.str() << "\n";
}
