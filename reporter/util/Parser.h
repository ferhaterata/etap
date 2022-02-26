//
// Created by enesvarcan on 10/19/20.
//

#ifndef ANALYSIS_FRAMEWORK_CERN_ROOT_BASED_REPORTING_PARSER_H
#define ANALYSIS_FRAMEWORK_CERN_ROOT_BASED_REPORTING_PARSER_H

#include <fstream>
#include <iostream>
#include <map>
#include <vector>

#include "../include/Path.h"

using namespace std;
class Parser {
  char** argv;
  int argc;
  string fname;
  string pathProFile;
  string costFile;

 public:
  string xmax = "50";
  string ymax = "1.0";

 public:
  Parser(int argc, char** argv) : argv(argv), argc(argc) {}
  void parseFlags();
  pair<map<string, string>, map<string, string>> parsePathFiles();
  vector<Path> createPaths();
};

#endif  // ANALYSIS_FRAMEWORK_CERN_ROOT_BASED_REPORTING_PARSER_H
