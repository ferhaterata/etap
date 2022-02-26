//
// Created by numan on 18.03.2021.
//

#ifndef STANDALONE_APPLICATION_MSP430_H
#define STANDALONE_APPLICATION_MSP430_H

#include <cmath>
#include <fstream>
#include <iostream>
#include <map>
#include <regex>
#include <sstream>
#include <string>
#include <utility>
#include <vector>

class Msp430 {
 private:
  const std::string Name;  // filename which will be given constructor
  std::map<std::string, std::string> UTimingMap;
  std::map<std::string, std::string> UEnergyMap;
  std::map<std::string, std::string> BlockCallTiming;
  std::map<std::string, std::string> BlockCallEnergy;

  const std::pair<double, double> Time1{1.02, 0.01};
  const std::pair<double, double> Time2{3.02, 0.01};
  const std::pair<double, double> Time3{3.02, 0.01};
  const std::pair<double, double> Time4{5.02, 0.01};
  const std::pair<double, double> Time5{2.02, 0.01};
  const std::pair<double, double> Time6{4.02, 0.01};
  const std::pair<double, double> Time7{2.02, 0.01};
  const std::pair<double, double> Time8{4.02, 0.01};

  std::map<std::string, std::pair<double, double>> AmTimeMap{
      {"000", Time1}, {"001", Time2}, {"010", Time3}, {"011", Time4},
      {"100", Time5}, {"101", Time6}, {"110", Time7}, {"111", Time8}};

  const std::pair<double, double> Energy1{4.52, 0.62};
  const std::pair<double, double> Energy2{7.08, 0.62};
  const std::pair<double, double> Energy3{6.97, 0.62};
  const std::pair<double, double> Energy4{10.1, 0.62};
  const std::pair<double, double> Energy5{5.8, 0.62};
  const std::pair<double, double> Energy6{8.33, 0.62};
  const std::pair<double, double> Energy7{5.55, 0.62};
  const std::pair<double, double> Energy8{8.34, 0.62};

  std::map<std::string, std::pair<double, double>> AmEnergyMap{
      {"000", Energy1}, {"001", Energy2}, {"010", Energy3}, {"011", Energy4},
      {"100", Energy5}, {"101", Energy6}, {"110", Energy7}, {"111", Energy8}};

 public:
  explicit Msp430(std::string filename,
                      std::map<std::string, std::string> timingMap = {},
                      std::map<std::string, std::string> energyMap = {})
      : Name(std::move(filename)) {
    UTimingMap = timingMap;
    UEnergyMap = energyMap;
  }
  std::string getText();
  std::vector<std::string> stringToLine();
  std::vector<std::array<std::string, 3>> instructionParser(
      std::vector<std::string>);
  std::vector<std::pair<double, double>> calculateTimeEnergy(
      std::vector<std::string>, std::string, std::string);
  std::map<std::string, std::map<std::string, std::vector<std::string>>>
      blockParser(std::vector<std::string>);
  static double findOutlierValue(std::vector<double>);
  void printToFile(
      std::map<std::string, std::map<std::string, std::vector<std::string>>>
          funcList,
      std::vector<double> meanVectorTime, std::vector<double> stdVectorTime,
      std::vector<double> meanVectorEnergy, std::vector<double> stdVectorEnergy,
      std::string fileName);
  void instructionCounter(
      std::map<std::string, std::map<std::string, std::vector<std::string>>>,
      std::string);
};

#endif  // STANDALONE_APPLICATION_MSP430_H
