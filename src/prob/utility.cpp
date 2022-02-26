//  ----------------------------------------------------------------------------
//  Implementation file for the utility classes.                     utility.cpp
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on December 12, 2019.
//  Copyright (c) 2019 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

#include "utility.hpp"

#include <llvm/IR/DebugInfoMetadata.h>
#include <llvm/IR/Function.h>
#include <llvm/IR/GlobalVariable.h>

#include <ctime>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <vector>

// -----------------------------------------------------------------------------
//
void utility::banner(std::string topic) {
  std::time_t t = std::time(nullptr);
  std::tm tm = *std::localtime(&t);
  std::cout << "\n" << separator();
  std::cout << "\t"
            << "Ferhat Erata"
            << "\n\t"
            << "Yale University"
            << "\n\t";
  if (!topic.empty()) std::cout << topic << "\n\t";
  std::cout << std::put_time(&tm, "%c %Z");
  std::cout << "\n" << separator() << std::endl;
}

// -----------------------------------------------------------------------------
//
void utility::bye() {
  std::cout << "\n" << separator() << "Normal termination.\n";
}

// -----------------------------------------------------------------------------
//
std::string utility::separator() {
  return "---------------------------------------------------------------\n";
}

// -----------------------------------------------------------------------------
//
std::string utility::printStreamState(const std::ios& stream) {
  std::stringstream ss;
  ss << " good()=" << stream.good();
  ss << " eof()=" << stream.eof();
  ss << " fail()=" << stream.fail();
  ss << " bad()=" << stream.bad() << std::endl;
  return ss.str();
}

// -----------------------------------------------------------------------------
// Exception Class Fatal's constructor
utility::fatal::fatal(std::string message) : Message(std::move(message)) {}

// -----------------------------------------------------------------------------
// Exception Class Fatal's what() method
const char* utility::fatal::what() const noexcept { return Message.data(); }

// -----------------------------------------------------------------------------
// read file
std::string utility::read(const std::string& file) {
  std::ifstream in(file.c_str(), std::ios::in | std::ios::binary);
  std::ostringstream contents;
  if (in) {
    contents << in.rdbuf();
    in.close();
  }
  return contents.str();
}

// -----------------------------------------------------------------------------
// attach metadata to a given llvm instruction
std::string utility::attachMetadata(
    llvm::Value* V, const std::string& kind,
    const std::pair<llvm::StringRef, llvm::StringRef>& metadata,
    const std::string& separator, const std::string& concluder) {
  std::string data =
      metadata.first.str() + separator + metadata.second.str() + concluder;
  llvm::LLVMContext& C = V->getContext();
  llvm::MDNode* n = llvm::MDNode::get(C, llvm::MDString::get(C, data));
  if (auto* f = llvm::dyn_cast<llvm::Function>(V))
    f->addMetadata(kind, *n);
  else if (auto* i = llvm::dyn_cast<llvm::Instruction>(V))
    i->setMetadata(kind, n);
  else if (auto* a = llvm::dyn_cast<llvm::Argument>(V))
    a->getParent()->addMetadata(kind, *n);
  else if (auto* g = llvm::dyn_cast<llvm::GlobalVariable>(V))
    g->addMetadata(kind, *n);
  return data;
}

// -----------------------------------------------------------------------------
// attach metadata to a given llvm instruction
std::string utility::attachMetadata(llvm::Instruction& I,
                                    const std::string& kind,
                                    const std::string& metadata) {
  llvm::LLVMContext& C = I.getContext();
  llvm::MDNode* n = llvm::MDNode::get(C, llvm::MDString::get(C, metadata));
  I.setMetadata(kind, n);
  return metadata;
}

// -----------------------------------------------------------------------------
// attach metadata to a given llvm global variable
std::string utility::attachMetadata(llvm::GlobalVariable& G,
                                    const std::string& kind,
                                    const std::string& metadata) {
  llvm::LLVMContext& C = G.getContext();
  llvm::MDNode* n = llvm::MDNode::get(C, llvm::MDString::get(C, metadata));
  G.setMetadata(kind, n);
  return metadata;
}
// -----------------------------------------------------------------------------
// attach metadata to a given llvm function
std::string utility::attachMetadata(llvm::Function& F, const std::string& kind,
                                    const std::string& metadata) {
  llvm::LLVMContext& C = F.getContext();
  llvm::MDNode* n = llvm::MDNode::get(C, llvm::MDString::get(C, metadata));
  F.addMetadata(kind, *n);
  return metadata;
}

// -----------------------------------------------------------------------------
// attach a vector of metadata to a given llvm instruction
std::string utility::attachMetadata(llvm::Instruction& I,
                                    const std::string& kind,
                                    const std::vector<std::string>& metadata,
                                    const std::string& separator) {
  std::string data;
  auto begin = metadata.begin();
  const auto end = metadata.end();
  if (begin != end) {
    data += *begin;
    begin++;
  }

  for (; begin != end; begin++) {
    data += separator;
    data += *begin;
  }

  llvm::LLVMContext& C = I.getContext();
  llvm::MDNode* N = llvm::MDNode::get(C, llvm::MDString::get(C, data));
  I.setMetadata(kind, N);
  return data;
}

// -----------------------------------------------------------------------------
// Given a sequence of basic blocks composing a path, this function prints
// out the filename and line numbers associated with that path in CSV format.
void utility::printPath(llvm::raw_ostream& out,
                        const std::vector<llvm::BasicBlock*>& blocks) {
  unsigned line = 0;
  llvm::StringRef file;
  for (auto* bb : blocks) {
    for (auto& instruction : *bb) {
      llvm::DILocation* loc = instruction.getDebugLoc();
      if (loc && (loc->getLine() != line || loc->getFilename() != file)) {
        line = loc->getLine();
        file = loc->getFilename();
        out << ", " << file.str() << ", " << line;
      }
    }
  }
}

// -----------------------------------------------------------------------------
// Write the debug information of a given llvm instruction
// TODO: not tested
std::string utility::writeDebugInformation(llvm::Instruction& I) {
  std::stringstream ss;
  if (llvm::DILocation* loc = I.getDebugLoc()) {
    unsigned line = loc->getLine();
    llvm::StringRef file = loc->getFilename();
    llvm::StringRef dir = loc->getDirectory();
    ss << dir.str() << "/" << file.str() << ":" << line << "\n";
  }
  return ss.str();
}

// -----------------------------------------------------------------------------
// getLine
std::string utility::line(llvm::Instruction& I, int width,
                          std::string concluder) {
  std::stringstream ss;
  if (llvm::DILocation* loc = I.getDebugLoc()) {
    unsigned line = loc->getLine();
    ss << std::setw(width) << std::right << line << concluder;
  } else
    ss << std::string(width, ' ') << concluder;
  return ss.str();
}

// -----------------------------------------------------------------------------
std::string utility::fixed(llvm::StringRef sf, int width) {
  std::stringstream ss;
  ss << std::setw(width) << std::left << sf.str();
  return ss.str();
}

// -----------------------------------------------------------------------------
// gets the operand name of value of the instruction
std::string utility::name(const llvm::Value* V, const llvm::Module* M) {
  std::string s;
  llvm::raw_string_ostream ss(s);
  V->printAsOperand(ss, false, M);
  return ss.str();  //.substr(1);
}

// -----------------------------------------------------------------------------
//
std::string utility::printType(const llvm::Type* T) {
  std::string s;
  llvm::raw_string_ostream ss(s);
  T->print(ss, true, false);
  return ss.str();
}

// -----------------------------------------------------------------------------
// Replace String
bool utility::replace(std::string& str, const std::string& from,
                      const std::string& to) {
  size_t start_pos = str.find(from);
  if (start_pos == std::string::npos) return false;
  str.replace(start_pos, from.length(), to);
  return true;
}

// -----------------------------------------------------------------------------
// Replace String
std::string utility::replaceAll(std::string subject, const std::string& search,
                                const std::string& replace) {
  size_t pos = 0;
  while ((pos = subject.find(search, pos)) != std::string::npos) {
    subject.replace(pos, search.length(), replace);
    pos += replace.length();
  }
  return subject;
}

// -----------------------------------------------------------------------------
// Concatenate String Expressions
std::string utility::concat(const std::vector<std::string>& metadata,
                            const std::string& separator,
                            const std::string& concluder) {
  std::string datum;
  auto begin = metadata.begin();
  const auto end = metadata.end();
  if (begin != end) {
    datum += *begin++;
  }

  for (; begin != end; begin++) {
    datum += separator + *begin;
  }

  datum += concluder;

  return datum;
}

// -----------------------------------------------------------------------------
// Calculates heat color based on percent of "hotness".
std::string utility::getHeatColor(double percent) {
  if (percent > 1.0) percent = 1.0;
  if (percent < 0.0) percent = 0.0;
  unsigned colorId = unsigned(round(percent * (HeatSize - 1.0)));
  return HeatPalette[colorId];
}

// -----------------------------------------------------------------------------
// Calculates heat color based on current and maximum frequencies.
// maxFreq is the max basic block frequency
std::string utility::getHeatColor(uint64_t freq, uint64_t maxFreq) {
  if (freq > maxFreq) freq = maxFreq;
  double percent = (freq > 0) ? log2(double(freq)) / log2(maxFreq) : 0;
  return getHeatColor(percent);
}

// -----------------------------------------------------------------------------
// Calculates edge width from probability.
std::string utility::getFrequency(double frequency, int count) {
  std::ostringstream ss;
  ss << "[" << std::fixed << std::setprecision(4) << frequency << "][" << count
     << "]\\l";
  return ss.str();
}

// -----------------------------------------------------------------------------
// Calculates edge width from probability.
std::string utility::getEdgeWidth(double probability) {
  std::ostringstream ss;
  ss << std::fixed << std::setprecision(3) << 1 + probability;
  return ss.str();
}

// -----------------------------------------------------------------------------
// pretty print edge probability.
std::string utility::getEdgeLabel(double probability) {
  std::ostringstream ss;
  ss << std::setprecision(4) << std::noshowpoint << probability;
  return ss.str();
}
