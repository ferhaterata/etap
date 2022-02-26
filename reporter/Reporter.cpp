//
// Created by enesvarcan on 10/19/20.
//

#include "include/Path.h"
#include "util/Graph.h"
#include "util/Parser.h"

int main(int argc, char** argv) {
  Parser p(argc, argv);
  p.parseFlags();
  vector<Path> paths = p.createPaths();

  Graph g(p.xmax, p.ymax, paths);
  g.writeToFile();
  return 0;
}