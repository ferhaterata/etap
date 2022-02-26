//
// Created by gokcin on 19.10.2
#include "Graph.h"

Graph::Graph(const string& x, const string& y, vector<Path> paths) {
  stringstream ssxmax(x);
  ssxmax >> xmax;
  stringstream ssymax(y);
  ssymax >> ymax;
  this->paths = std::move(paths);
}

void Graph::groupPathsForFunc() {
  for (const Path& path : paths) {
    string funcName = path.pathName.substr(1, path.pathName.find('%') - 1);
    funcPathsMap[funcName].push_back(path);
  }
}

void Graph::writeToFile() {
  groupPathsForFunc();
  for (const auto& x : funcPathsMap) {
    ofstream myfile;
    myfile.open(".temp/" + x.first);

    for (const auto& p : x.second) {
      double w = p.weight;
      if (p.weight == -1.0) {
        w = 1.0 / x.second.size();
      }
      myfile << "(" << p.cost << ")" << ';' << w << '\n';
    }
    myfile.close();
  }
}
