//
// Created by enesvarcan on 10/19/20.
//

#include "Parser.h"

void Parser::parseFlags() {
  if (argc <= 1) {
    cerr << "error: no input file given\n";
    exit(1);
  }

  costFile = argv[1];
  for (int i = 2; i < argc; ++i) {
    if (i + 1 < argc) {
      string flag = argv[i];
      if (flag == "-fname" && i + 1 < argc) {
        fname = argv[i + 1];
      } else if (flag == "-P" && i + 1 < argc) {
        pathProFile = argv[i + 1];
      } else if (flag == "-ymax" && i + 1 < argc) {
        ymax = argv[i + 1];
      } else if (flag == "-xmax" && i + 1 < argc) {
        xmax = argv[i + 1];
      }
      i++;
    } else {
      cerr << "error: missing args\n";
      exit(1);
    }
  }
}
pair<map<string, string>, map<string, string>> Parser::parsePathFiles() {
  map<string, string> pathCostMap;
  map<string, string> pathWeightMap;
  unsigned pathCounter = 0;
  ifstream cFile(costFile);

  if (!cFile) {
    cerr << "error: could not open " + costFile + "\n";
    exit(1);
  }
  string line;
  while (getline(cFile, line)) {
    string path = line.substr(0, line.find(';'));
    pathCounter++;
    string cost = line.substr(line.find(';') + 1, line.size());
    if (!fname.empty()) {
      string temp = path.substr(1, path.find('%') - 1);
      if (temp != fname) {
        continue;
      }
    }
    pathCostMap[path] = cost;
  }

  if (!pathProFile.empty()) {
    ifstream pFile(pathProFile);
    if (!pFile) {
      cerr << "error: could not open " + pathProFile + "\n";
      exit(1);
    }
    while (getline(pFile, line)) {
      string path = line.substr(0, line.find(' '));
      string weight = line.substr(line.find(' ') + 1, line.size());
      if (!fname.empty()) {
        string temp = path.substr(1, path.find('%') - 1);
        if (temp != fname) {
          continue;
        }
      }
      pathWeightMap[path] = weight;
    }
  } else {
    for (auto pair : pathCostMap) {
      pathWeightMap[pair.first] = "-1";
    }
  }
  return pair(pathCostMap, pathWeightMap);
}

vector<Path> Parser::createPaths() {
  vector<Path> paths;
  auto parsed = parsePathFiles();
  map<string, string> pathCostMap = parsed.first;
  map<string, string> pathWeightMap = parsed.second;

  for (const auto& pathCostPair : pathCostMap) {
    string weight = "0";
    string path = pathCostPair.first;
    string cost = pathCostPair.second;
    if (!pathWeightMap[path].empty()) {
      weight = pathWeightMap[path];
    }
    Path pathObj(pathCostPair.first, pathCostPair.second, stod(weight), xmax,
                 ymax);
    paths.push_back(pathObj);
  }
  return paths;
}
