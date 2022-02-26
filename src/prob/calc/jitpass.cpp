#include <llvm/IR/Function.h>
#include <llvm/IR/IRBuilder.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>

#include <memory>
#include <string>
#include <vector>

#include "llvm/ADT/iterator_range.h"
#include "llvm/ExecutionEngine/ExecutionEngine.h"
#include "llvm/ExecutionEngine/GenericValue.h"
#include "llvm/ExecutionEngine/JITSymbol.h"
#include "llvm/ExecutionEngine/Orc/CompileUtils.h"
#include "llvm/ExecutionEngine/Orc/LLJIT.h"
#include "llvm/ExecutionEngine/Orc/ObjectLinkingLayer.h"
#include "llvm/ExecutionEngine/RTDyldMemoryManager.h"
#include "llvm/ExecutionEngine/RuntimeDyld.h"
#include "llvm/IR/BasicBlock.h"
#include "llvm/IR/Constant.h"
#include "llvm/IR/DerivedTypes.h"
#include "llvm/IR/Instructions.h"
#include "llvm/IR/Mangler.h"
#include "llvm/IR/Verifier.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Support/CommandLine.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/Utils/Cloning.h"
/*
 * RUNNING THE PASS:
 * cmake .
 * make
 * opt-12 -S -load ./passes/libJitPass.so -jit-pass -func sum -param 5 -param 4
 * -input .llvm/sum.ll -output .llvm/entry.ll .llvm/sum.ll -o .llvm/sum.ll
 */
llvm::cl::opt<std::string> FUNCNAME("func", llvm::cl::desc("func file name"),
                                    llvm::cl::value_desc("file name"));
llvm::cl::opt<std::string> INPUT("input", llvm::cl::desc("input .ll file name"),
                                 llvm::cl::value_desc("file name"));
llvm::cl::opt<std::string> OUTPUT("output",
                                  llvm::cl::desc("output .ll file name"),
                                  llvm::cl::value_desc("file name"));
// llvm::cl::opt<std::string> PARAM("param",
//                                   llvm::cl::desc("param function
//                                   parameters"), llvm::cl::value_desc("integer
//                                   parameters"));

llvm::cl::list<std::string> PARAMS("param", llvm::cl::desc("<Input files>"),
                                   llvm::cl::OneOrMore);

using namespace llvm;
using namespace llvm::orc;
ExitOnError ExitOnErr;

struct JitPass : public llvm::ModulePass {
  static char ID;
  JitPass() : llvm::ModulePass(ID) {}

  void generateEntry(llvm::Module& M) {
    std::vector<Type*> paramTypes;
    for (auto& arg : M.getFunction(FUNCNAME)->args()) {
      auto* type = arg.getType();
      paramTypes.push_back(type);
    }

    LLVMContext& Context = M.getContext();
    IRBuilder<> Builder(Context);

    FunctionType* funcType = llvm::FunctionType::get(
        M.getFunction(FUNCNAME)->getFunctionType()->getReturnType(), false);

    auto* fooFunc =
        Function::Create(funcType, Function::ExternalLinkage, "entry", M);
    //    M.getOrInsertFunction("entry", funcType);
    //    Function* fooFunc = M.getFunction("entry");
    BasicBlock* entry = BasicBlock::Create(Context, "entryBlock", fooFunc);
    std::vector<Value*> v;
    for (int i = 0; i < PARAMS.size(); i++) {
      if (paramTypes.at(i)->isIntegerTy(1)) {
        v.push_back(Builder.getInt1(std::stoi(PARAMS[i])));
      } else if (paramTypes.at(i)->isIntegerTy(8)) {
        v.push_back(Builder.getInt8(std::stoi(PARAMS[i])));
      } else if (paramTypes.at(i)->isIntegerTy(16)) {
        v.push_back(Builder.getInt16(std::stoi(PARAMS[i])));
      } else if (paramTypes.at(i)->isIntegerTy(32)) {
        v.push_back(Builder.getInt32(std::stoi(PARAMS[i])));
      }
      //       else if (paramTypes.at(i)->isFloatTy()) {
      //        v.push_back(Builder.getFloatTy());
      //      }
    }

    ArrayRef<Value*> args(v);

    CallInst* ci = CallInst::Create(M.getFunction(FUNCNAME), v, "tmp", entry);

    Value* val = ci;
    Instruction* ret = ReturnInst::Create(Context, val, entry);

    std::unique_ptr<Module> Owner = CloneModule(M);

    Module* MM = Owner.get();

    ExecutionEngine* EE = EngineBuilder(std::move(Owner)).create();

    outs() << "We just constructed this LLVM module:\n\n" << *MM;
    outs() << "\n\nRunning entry: "
           << "\n";

    std::vector<GenericValue> noargs;
    GenericValue gv = EE->runFunction(MM->getFunction("entry"), noargs);
    //
    //     Import result of execution:
    outs() << "Result: " << gv.IntVal << "\n";
    ////    delete EE;
    ////    llvm_shutdown();
  }

  bool runOnModule(llvm::Module& M) override {
    generateEntry(M);
    return false;
  }
};

char JitPass::ID = 0;

[[maybe_unused]] static llvm::RegisterPass<JitPass> X("jit-pass", "JIT Pass");
