//
// Created by enesvarcan on 10/19/20.
//

#ifndef ANALYSIS_FRAMEWORK_CERN_ROOT_BASED_REPORTING_PATH_H
#define ANALYSIS_FRAMEWORK_CERN_ROOT_BASED_REPORTING_PATH_H
#include "string"

using namespace std;
class Path {
 public:
  string pathName;
  string cost;
  double weight;
  string xmax;
  string ymax;

  Path() {}
  Path(string pathName, string cost, double weight, string xmax, string ymax)
      : pathName(pathName),
        cost(cost),
        weight(weight),
        xmax(xmax),
        ymax(ymax) {}
};

#endif  // ANALYSIS_FRAMEWORK_CERN_ROOT_BASED_REPORTING_PATH_H
