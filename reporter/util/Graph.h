//
// Created by gokcin on 21.10.2020.
//

#ifndef ANALYSIS_FRAMEWORK_CERN_ROOT_BASED_REPORTING_GRAPH_H
#define ANALYSIS_FRAMEWORK_CERN_ROOT_BASED_REPORTING_GRAPH_H

#include <fstream>
#include <iostream>
#include <map>
#include <sstream>
#include <string>
#include <utility>
#include <vector>

#include "../include/Path.h"

using namespace std;
class Graph {
 public:
  float xmax;
  float ymax;
  vector<Path> paths;

  map<string, vector<Path>> funcPathsMap;

  Graph(const string& xmax, const string& ymax, vector<Path> paths);
  void groupPathsForFunc();
  void writeToFile();
};

#endif  // ANALYSIS_FRAMEWORK_CERN_ROOT_BASED_REPORTING_GRAPH_H
