//  ----------------------------------------------------------------------------
//  Header file for the test class.        test.cpp
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 25, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------
#include <iostream>
#include <vector>

// -----------------------------------------------------------------------------
// Concatenate String Expressions
std::string concat(const std::vector<std::string>& metadata,
                   const std::string& separator, const std::string& concluder) {
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

int main() {
  std::vector<std::string> str{"ferhat", "mete", "erata"};
  std::cout << concat(str, "; ", ".") << std::endl;

  std::vector<std::string> str1{"ferhat", "erata"};
  std::cout << concat(str1, "; ", ".") << std::endl;

  std::vector<std::string> str2{"ferhat"};
  std::cout << concat(str2, "; ", ".") << std::endl;
  return 0;
}