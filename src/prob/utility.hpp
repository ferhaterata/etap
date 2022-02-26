//  ----------------------------------------------------------------------------
//  Header file for the utility classes.                             utility.hpp
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on December 12, 2019.
//  Copyright (c) 2019 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

#ifndef UTILITY_HPP
#define UTILITY_HPP

#include <llvm/IR/BasicBlock.h>
#include <llvm/IR/DebugInfo.h>
#include <llvm/IR/Instruction.h>

#include <string>

namespace utility {

// -----------------------------------------------------------------------------
// Prints a neat header on the output.
void banner(std::string topic = "");

// -----------------------------------------------------------------------------
//  Prints termination message.
void bye();

// -----------------------------------------------------------------------------
//  Generates a separator string
std::string separator();

// -----------------------------------------------------------------------------
// Prints stream state for debugging purposes.
std::string printStreamState(const std::ios& stream);

// -----------------------------------------------------------------------------
// Fatal class is derived from std::exception; std::exception has virtual
// destructor and virtual "exception::what()" method that returns a C-style
// character string describing the general cause of the current error.
class fatal : public std::exception {
 private:
  const std::string Message;

 public:
  explicit fatal(std::string message);

  [[nodiscard]] const char* what() const noexcept override;
};

// -----------------------------------------------------------------------------
// read file and returns string
std::string read(const std::string& file);

// -----------------------------------------------------------------------------
// attach a vector of metadata to a given llvm instruction
std::string attachMetadata(llvm::Instruction& I, const std::string& kind,
                           const std::vector<std::string>& metadata,
                           const std::string& separator = "; ");

// -----------------------------------------------------------------------------
// Given a sequence of basic blocks composing a path, this function prints
// out the filename and line numbers associated with that path in CSV format.
void printPath(llvm::raw_ostream& out,
               const std::vector<llvm::BasicBlock*>& blocks);

// -----------------------------------------------------------------------------
// Write the debug information of a given llvm instruction
std::string writeDebugInformation(llvm::Instruction& I);

// -----------------------------------------------------------------------------
std::string attachMetadata(llvm::Instruction& I, const std::string& kind,
                           const std::string& metadata);

// -----------------------------------------------------------------------------
std::string attachMetadata(llvm::GlobalVariable& G, const std::string& kind,
                           const std::string& metadata);

// -----------------------------------------------------------------------------
std::string attachMetadata(llvm::Function& F, const std::string& kind,
                           const std::string& metadata);

// -----------------------------------------------------------------------------
std::string attachMetadata(
    llvm::Value* F, const std::string& kind,
    const std::pair<llvm::StringRef, llvm::StringRef>& metadata,
    const std::string& separator = " <- ", const std::string& concluder = "");

// -----------------------------------------------------------------------------
std::string name(const llvm::Value* V, const llvm::Module* M);

// -----------------------------------------------------------------------------
std::string printType(const llvm::Type* T);

// -----------------------------------------------------------------------------
std::string line(llvm::Instruction& I, int width = 3,
                 std::string concluder = "|");

// -----------------------------------------------------------------------------
std::string fixed(llvm::StringRef sf, int width = 40);

// -----------------------------------------------------------------------------
bool replace(std::string& str, const std::string& from, const std::string& to);

// -----------------------------------------------------------------------------
std::string replaceAll(std::string subject, const std::string& search,
                       const std::string& replace);

// -----------------------------------------------------------------------------
std::string concat(const std::vector<std::string>& metadata,
                   const std::string& separator = "; ",
                   const std::string& concluder = "");

// -----------------------------------------------------------------------------
static const unsigned HeatSize = 100;
static const char HeatPalette[HeatSize][8] = {
    "#3d50c3", "#4055c8", "#4358cb", "#465ecf", "#4961d2", "#4c66d6", "#4f69d9",
    "#536edd", "#5572df", "#5977e3", "#5b7ae5", "#5f7fe8", "#6282ea", "#6687ed",
    "#6a8bef", "#6c8ff1", "#7093f3", "#7396f5", "#779af7", "#7a9df8", "#7ea1fa",
    "#81a4fb", "#85a8fc", "#88abfd", "#8caffe", "#8fb1fe", "#93b5fe", "#96b7ff",
    "#9abbff", "#9ebeff", "#a1c0ff", "#a5c3fe", "#a7c5fe", "#abc8fd", "#aec9fc",
    "#b2ccfb", "#b5cdfa", "#b9d0f9", "#bbd1f8", "#bfd3f6", "#c1d4f4", "#c5d6f2",
    "#c7d7f0", "#cbd8ee", "#cedaeb", "#d1dae9", "#d4dbe6", "#d6dce4", "#d9dce1",
    "#dbdcde", "#dedcdb", "#e0dbd8", "#e3d9d3", "#e5d8d1", "#e8d6cc", "#ead5c9",
    "#ecd3c5", "#eed0c0", "#efcebd", "#f1ccb8", "#f2cab5", "#f3c7b1", "#f4c5ad",
    "#f5c1a9", "#f6bfa6", "#f7bca1", "#f7b99e", "#f7b599", "#f7b396", "#f7af91",
    "#f7ac8e", "#f7a889", "#f6a385", "#f5a081", "#f59c7d", "#f4987a", "#f39475",
    "#f29072", "#f08b6e", "#ef886b", "#ed8366", "#ec7f63", "#e97a5f", "#e8765c",
    "#e57058", "#e36c55", "#e16751", "#de614d", "#dc5d4a", "#d85646", "#d65244",
    "#d24b40", "#d0473d", "#cc403a", "#ca3b37", "#c53334", "#c32e31", "#be242e",
    "#bb1b2c", "#b70d28"};

// Calculates heat color based on percent of "hotness".
std::string getHeatColor(double percent);

// Calculates heat color based on current and maximum frequencies.
std::string getHeatColor(uint64_t freq, uint64_t maxFreq);

// gets pretty printed blocks frequency
std::string getFrequency(double frequency, int count);

// Calculates edge width from probability.
std::string getEdgeWidth(double probability);

// pretty print edge probability.
std::string getEdgeLabel(double probability);

}  // namespace utility

namespace symbol {
inline const auto Alpha = "\u03B1";
inline const auto Beta = "\u03B2";
inline const auto Gamma = "\u03B3";
inline const auto Delta = "\u03B4";
inline const auto Epsilon = "\u03B5";
inline const auto Zeta = "\u03B6";
inline const auto Eta = "\u03B7";
inline const auto Theta = "\u03B8";
inline const auto Iota = "\u03B9";
inline const auto Kappa = "\u03BA";
inline const auto Lambda = "\u03BB";
inline const auto Mu = "\u03BC";
inline const auto Nu = "\u03BD";
inline const auto Xi = "\u03BE";
inline const auto Omicron = "\u03BF";
inline const auto Pi = "\u03C0";
inline const auto Rho = "\u03C1";
inline const auto Sigma = "\u03C3";
inline const auto Tau = "\u03C4";
inline const auto Upsilon = "\u03C5";
inline const auto Phi = "\u03C6";
inline const auto Chi = "\u03C7";
inline const auto Psi = "\u03C8";
inline const auto Omega = "\u03C9";
}  // namespace symbol

namespace color {
inline const auto Red = "\033[0;31m";
inline const auto Green = "\033[0;32m";
inline const auto Yellow = "\033[0;33m";
inline const auto Blue = "\033[0;34m";
inline const auto Magenta = "\033[0;35m";
inline const auto Cyan = "\033[0;36m";
inline const auto Bold = "\033[1m";
inline const auto ResetBold = "\033[21m";
inline const auto Underline = "\033[4m";
inline const auto ResetUnderline = "\033[24m";
inline const auto Reset = "\033[0m";
}  // namespace color

#endif  // UTILITY_HPP
