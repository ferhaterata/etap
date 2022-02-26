//
// Created by numan on 18.03.2021.
//
#include <chrono>

#include "msp430.h"

int main(int argc, char* argv[]) {
  // test block here

  Msp430 c(argv[1]);
  // std::string profile = ".output/main_dijkstra.profile";
  std::vector<double> meanVectorEnergy;
  std::vector<double> meanVectorTime;
  std::vector<double> stdVectorEnergy;
  std::vector<double> stdVectorTime;

  //  auto start = std::chrono::high_resolution_clock::now();
  std::map<std::string, std::map<std::string, std::vector<std::string>>>
      funcList = c.blockParser(c.stringToLine());
  // c.instruction_counter(funcList,profile);

  for (auto& funct : funcList) {
    for (auto& block : funct.second) {
      std::vector<std::pair<double, double>> result;
      result = c.calculateTimeEnergy(block.second, block.first, funct.first);
      meanVectorEnergy.push_back(result.at(1).first);
      meanVectorTime.push_back(result.at(0).first);
      stdVectorEnergy.push_back(result.at(1).second);
      stdVectorTime.push_back(result.at(0).second);
    }
  }
  //  double outlier = Calculator::findOutlierValue(meanVectorEnergy);
  //  std::cout << "outlier value is : " << outlier << "\n";
  //  std::cout << "max value is: " <<
  //  *std::max_element(meanVectorEnergy.begin(), meanVectorEnergy.end()) <<
  //  "\n"; for (auto& funct : funcList){
  //    for (auto& block : funct.second){
  //      if(c.calculateTimeEnergy(block.second).at(1).first > outlier )
  //      std::cout << funct.first + " " + block.first << "\n";
  //    }
  //  }

  c.printToFile(funcList, meanVectorTime, stdVectorTime, meanVectorEnergy,
                stdVectorEnergy, argv[2]);
  //  auto stop = std::chrono::high_resolution_clock::now();

  //  auto duration = std::chrono::duration_cast<std::chrono::microseconds>(stop
  //  - start); std::cout << "Time taken by function: "
  //       << duration.count() << " microseconds" << std::endl;
  return 0;
}
