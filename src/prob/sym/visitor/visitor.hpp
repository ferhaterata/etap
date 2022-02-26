//  ----------------------------------------------------------------------------
//  Header file for the Main Visitor class.                          visitor.hpp
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 16, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

#ifndef STANDALONE_APPLICATION_VISITOR_HPP
#define STANDALONE_APPLICATION_VISITOR_HPP

#include <llvm/Analysis/ScalarEvolution.h>
#include <llvm/IR/InstVisitor.h>

#include <sstream>

#include "../../utility.hpp"

namespace prob::sym::visitor {

class Visitor : public llvm::InstVisitor<Visitor> {
 private:
  const std::string Discrete = "0";    //"DiscreteDistribution(0)";
  const std::string Continuous = "0";  //"Unif(0, 0.01)";
  const std::string Deterministic = "0";
  llvm::Module* Module;
  // ---------------------------------------------------------------------------
  static std::string symbol(const llvm::Value* V, const llvm::Module* M);
  // ---------------------------------------------------------------------------
  std::string getGEP(llvm::GEPOperator* gep, llvm::Module* module);
  // ---------------------------------------------------------------------------
  std::string getGEP(llvm::GetElementPtrInst& gep, llvm::Module* module);
  // ---------------------------------------------------------------------------
  std::string type(const llvm::Type* T);
  // ---------------------------------------------------------------------------
  std::string constant(llvm::Constant* C, llvm::Module* M);
  // ---------------------------------------------------------------------------
  std::string global(llvm::Module& M);
  // ---------------------------------------------------------------------------
  struct BinaryOperation {
    const std::string Name;
    const std::string Left;
    const std::string Right;
    BinaryOperation(llvm::BinaryOperator& op)
        : Name(symbol(&op, op.getModule())),
          Left(symbol(op.getOperand(0), op.getModule())),
          Right(symbol(op.getOperand(1), op.getModule())) {}
  };

 public:
  std::stringstream R;  // Random Variables
  // ---------------------------------------------------------------------------
  llvm::raw_ostream& print(llvm::raw_ostream& out) const;
  std::ostream& write(std::ostream& out) const;
  // ---------------------------------------------------------------------------
  void visitModule(llvm::Module& M);

  void visitFunction(llvm::Function& F);

  void visitBasicBlock(llvm::BasicBlock& BB);

  void visitUnaryOperator(llvm::UnaryOperator& UI);

  void visitTerminator(llvm::Instruction& I);

  void visitReturnInst(llvm::ReturnInst& I);

  void visitBranchInst(llvm::BranchInst& I);

  void visitSwitchInst(llvm::SwitchInst& I);

  void visitIndirectBrInst(llvm::IndirectBrInst& I);

  void visitResumeInst(llvm::ResumeInst& I);

  void visitUnreachableInst(llvm::UnreachableInst& I);

  void visitCleanupReturnInst(llvm::CleanupReturnInst& I);

  void visitCatchReturnInst(llvm::CatchReturnInst& I);

  void visitCatchSwitchInst(llvm::CatchSwitchInst& I);

  void visitCastInst(llvm::CastInst& CI);

  void visitAllocaInst(llvm::AllocaInst& I);

  void visitLoadInst(llvm::LoadInst& I);

  void visitStoreInst(llvm::StoreInst& I);

  void visitGetElementPtr(llvm::GetElementPtrInst& I);

  void visitFence(llvm::FenceInst& I);

  void visitAtomicCmpXchg(llvm::AtomicCmpXchgInst& I);

  void visitAtomicRMW(llvm::AtomicRMWInst& I);

  void visitAdd(llvm::BinaryOperator& I);

  void visitFAdd(llvm::BinaryOperator& I);

  void visitSub(llvm::BinaryOperator& I);

  void visitFSub(llvm::BinaryOperator& I);

  void visitMul(llvm::BinaryOperator& I);

  void visitFMul(llvm::BinaryOperator& I);

  void visitUDiv(llvm::BinaryOperator& I);

  void visitSDiv(llvm::BinaryOperator& I);

  void visitFDiv(llvm::BinaryOperator& I);

  void visitURem(llvm::BinaryOperator& I);

  void visitSRem(llvm::BinaryOperator& I);

  void visitFRem(llvm::BinaryOperator& I);

  void visitShl(llvm::BinaryOperator& I);

  void visitLShr(llvm::BinaryOperator& I);

  void visitAShr(llvm::BinaryOperator& I);

  void visitAnd(llvm::BinaryOperator& I);

  void visitOr(llvm::BinaryOperator& I);

  void visitXor(llvm::BinaryOperator& I);

  void visitBinaryOperator(llvm::BinaryOperator& I);

  void visitFNeg(llvm::UnaryOperator& I);

  void visitFuncletPadInst(llvm::FuncletPadInst& I);

  void visitCleanupPad(llvm::CleanupPadInst& I);

  void visitCatchPad(llvm::CatchPadInst& I);

  void visitPHINode(llvm::PHINode& I);

  void visitCmpInst(llvm::CmpInst& I);

  void visitICmpInst(llvm::ICmpInst& I);

  void visitFCmpInst(llvm::FCmpInst& I);

  void visitCallInst(llvm::CallInst& CI);

  void visitSelectInst(llvm::SelectInst& I);

  void visitExtractElementInst(llvm::ExtractElementInst& I);

  void visitInsertElementInst(llvm::InsertElementInst& I);

  void visitShuffleVectorInst(llvm::ShuffleVectorInst& I);

  void visitExtractValueInst(llvm::ExtractValueInst& I);

  void visitInsertValueInst(llvm::InsertValueInst& I);

  void visitLandingPadInst(llvm::LandingPadInst& I);

  void visitFreezeInst(llvm::FreezeInst& I);

  void visitInvokeInst(llvm::InvokeInst& I);

  void visitCallBrInst(llvm::CallBrInst& I);

  void visitIntrinsicInst(llvm::IntrinsicInst& I);

  void visitDbgVariableIntrinsic(llvm::DbgVariableIntrinsic& I);

  void visitDbgDeclareInst(llvm::DbgDeclareInst& I);

  void visitDbgValueInst(llvm::DbgValueInst& I);

  void visitDbgLabelInst(llvm::DbgLabelInst& I);

  void visitDbgInfoIntrinsic(llvm::DbgInfoIntrinsic& I);

  void visitMemIntrinsic(llvm::MemIntrinsic& I);

  void visitMemTransferInst(llvm::MemTransferInst& I);

  void visitMemSetInst(llvm::MemSetInst& I);

  void visitMemCpyInst(llvm::MemCpyInst& I);

  void visitMemMoveInst(llvm::MemMoveInst& I);

  void visitVAStartInst(llvm::VAStartInst& I);

  void visitVAEndInst(llvm::VAEndInst& I);

  void visitVACopyInst(llvm::VACopyInst& I);

  void visitVAArgInst(llvm::VAArgInst& I);

  void visitTruncInst(llvm::TruncInst& I);

  void visitZExtInst(llvm::ZExtInst& I);

  void visitSExtInst(llvm::SExtInst& I);

  void visitFPTruncInst(llvm::FPTruncInst& I);

  void visitFPExtInst(llvm::FPExtInst& I);

  void visitFPToUIInst(llvm::FPToUIInst& I);

  void visitFPToSIInst(llvm::FPToSIInst& I);

  void visitUIToFPInst(llvm::UIToFPInst& I);

  void visitSIToFPInst(llvm::SIToFPInst& I);

  void visitPtrToIntInst(llvm::PtrToIntInst& I);

  void visitIntToPtrInst(llvm::IntToPtrInst& I);

  void visitBitCastInst(llvm::BitCastInst& I);

  void visitAddrSpaceCastInst(llvm::AddrSpaceCastInst& I);

  std::string useDefChain(llvm::Value* V);
  std::string inverseLoad(llvm::LoadInst* I);
};

}  // namespace prob::sym::visitor

// serialize a part to output stream
inline std::ostream& operator<<(std::ostream& out,
                                const prob::sym::visitor::Visitor& visitor) {
  return visitor.write(out);
}

inline llvm::raw_ostream& operator<<(llvm::raw_ostream& OS,
                                     const prob::sym::visitor::Visitor& V) {
  return V.print(OS);
}
#endif  // STANDALONE_APPLICATION_VISITOR_HPP
