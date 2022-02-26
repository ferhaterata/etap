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
  const std::string Name; // filename which will be given constructor
  std::map<std::string, std::string> UTimingMap;
  std::map<std::string, std::string> UEnergyMap;
  std::map<std::string, std::string> BlockCallTiming;
  std::map<std::string, std::string> BlockCallEnergy;

  //  version 1
  // 1MHz
  const std::pair<double, double> Time1_1{1.02, 0.01};
  const std::pair<double, double> Time2_1{3.02, 0.01};
  const std::pair<double, double> Time3_1{3.02, 0.01};
  const std::pair<double, double> Time4_1{5.02, 0.01};
  const std::pair<double, double> Time5_1{2.02, 0.01};
  const std::pair<double, double> Time6_1{4.02, 0.01};
  const std::pair<double, double> Time7_1{2.02, 0.01};
  const std::pair<double, double> Time8_1{4.02, 0.01};

  // 4 MHz
  const std::pair<double, double> Time1_4{0.3, 0.08};
  const std::pair<double, double> Time2_4{0.84, 0.07};
  const std::pair<double, double> Time3_4{0.83, 0.07};
  const std::pair<double, double> Time4_4{1.43, 0.08};
  const std::pair<double, double> Time5_4{0.63, 0.09};
  const std::pair<double, double> Time6_4{1.06, 0.07};
  const std::pair<double, double> Time7_4{0.7, 0.08};
  const std::pair<double, double> Time8_4{1.2, 0.08};

  // 8 MHz
  const std::pair<double, double> Time1_8{0.24, 0.08};
  const std::pair<double, double> Time2_8{0.48, 0.09};
  const std::pair<double, double> Time3_8{0.61, 0.08};
  const std::pair<double, double> Time4_8{0.75, 0.09};
  const std::pair<double, double> Time5_8{0.46, 0.08};
  const std::pair<double, double> Time6_8{0.67, 0.08};
  const std::pair<double, double> Time7_8{0.49, 0.08};
  const std::pair<double, double> Time8_8{0.69, 0.09};

  // 16 MHz
  const std::pair<double, double> Time1_16{2.00+ 0.06};
  const std::pair<double, double> Time2_16{2.15+ 0.06};
  const std::pair<double, double> Time3_16{2.76+ 0.07};
  const std::pair<double, double> Time4_16{2.23+ 0.07};
  const std::pair<double, double> Time5_16{2.12+ 0.07};
  const std::pair<double, double> Time6_16{2.22+ 0.06};
  const std::pair<double, double> Time7_16{2.62+ 0.06};
  const std::pair<double, double> Time8_16{3.03+ 0.08};
  //  version 2
  //  const std::pair<double, double> Time1{1.37, 0.46};
  //  const std::pair<double, double> Time2{3.35, 0.46};
  //  const std::pair<double, double> Time3{3.43, 0.46};
  //  const std::pair<double, double> Time4{5.47, 0.46};
  //  const std::pair<double, double> Time5{2.38, 0.46};
  //  const std::pair<double, double> Time6{4.4, 0.46};
  //  const std::pair<double, double> Time7{2.36, 0.46};
  //  const std::pair<double, double> Time8{4.34, 0.46};

  //  version 3
  //  const std::pair<double, double> Time1{1.15, 0.47};
  //  const std::pair<double, double> Time2{3.19, 0.47};
  //  const std::pair<double, double> Time3{3.23, 0.47};
  //  const std::pair<double, double> Time4{5.27, 0.47};
  //  const std::pair<double, double> Time5{2.24, 0.47};
  //  const std::pair<double, double> Time6{4.23, 0.47};
  //  const std::pair<double, double> Time7{2.08, 0.47};
  //  const std::pair<double, double> Time8{4.14, 0.46};

  //  version 4
  //  const std::pair<double, double> Time1{1.26, 0.46};
  //  const std::pair<double, double> Time2{3.2, 0.46};
  //  const std::pair<double, double> Time3{3.22, 0.46};
  //  const std::pair<double, double> Time4{5.3, 0.46};
  //  const std::pair<double, double> Time5{2.24, 0.46};
  //  const std::pair<double, double> Time6{4.14, 0.46};
  //  const std::pair<double, double> Time7{2.21, 0.46};
  //  const std::pair<double, double> Time8{4.23, 0.46};

  std::map<std::string, std::pair<double, double>> AmTime1MHzMap{
      {"000", Time1_1}, {"001", Time2_1}, {"010", Time3_1}, {"011", Time4_1},
      {"100", Time5_1}, {"101", Time6_1}, {"110", Time7_1}, {"111", Time8_1}};
  std::map<std::string, std::pair<double, double>> AmTime4MHzMap{
      {"000", Time1_4}, {"001", Time2_4}, {"010", Time3_4}, {"011", Time4_4},
      {"100", Time5_4}, {"101", Time6_4}, {"110", Time7_4}, {"111", Time8_4}};
  std::map<std::string, std::pair<double, double>> AmTime8MHzMap{
      {"000", Time1_8}, {"001", Time2_8}, {"010", Time3_8}, {"011", Time4_8},
      {"100", Time5_8}, {"101", Time6_8}, {"110", Time7_8}, {"111", Time8_8}};
  std::map<std::string, std::pair<double, double>> AmTime16MHzMap{
      {"000", Time1_16}, {"001", Time2_16}, {"010", Time3_16},
      {"011", Time4_16}, {"100", Time5_16}, {"101", Time6_16},
      {"110", Time7_16}, {"111", Time8_16}};

  //  version 1
  // 1MHz
  const std::pair<double, double> Energy1_1{4.52, 0.62};
  const std::pair<double, double> Energy2_1{7.08, 0.62};
  const std::pair<double, double> Energy3_1{6.97, 0.62};
  const std::pair<double, double> Energy4_1{10.1, 0.62};
  const std::pair<double, double> Energy5_1{5.8, 0.62};
  const std::pair<double, double> Energy6_1{8.33, 0.62};
  const std::pair<double, double> Energy7_1{5.55, 0.62};
  const std::pair<double, double> Energy8_1{8.34, 0.62};

  // 4MHz
  const std::pair<double, double> Energy1_4{2.77, 0.05};
  const std::pair<double, double> Energy2_4{3.56, 0.08};
  const std::pair<double, double> Energy3_4{4.05, 0.06};
  const std::pair<double, double> Energy4_4{4.37, 0.11};
  const std::pair<double, double> Energy5_4{3.15, 0.07};
  const std::pair<double, double> Energy6_4{3.94, 0.11};
  const std::pair<double, double> Energy7_4{3.66, 0.05};
  const std::pair<double, double> Energy8_4{1.76, 0.12};

  // 8MHz
  const std::pair<double, double> Energy1_8{2.61, 0.07};
  const std::pair<double, double> Energy2_8{3.22, 0.1};
  const std::pair<double, double> Energy3_8{3.82, 0.09};
  const std::pair<double, double> Energy4_8{3.84, 0.13};
  const std::pair<double, double> Energy5_8{2.94, 0.07};
  const std::pair<double, double> Energy6_8{3.6, 0.13};
  const std::pair<double, double> Energy7_8{3.42, 0.06};
  const std::pair<double, double> Energy8_8{1.32, 0.11};

  // 16MHz
  const std::pair<double, double> Energy1_16{6.5, 0.04};
  const std::pair<double, double> Energy2_16{6.96, 0.05};
  const std::pair<double, double> Energy3_16{8.72, 0.08};
  const std::pair<double, double> Energy4_16{7.44, 0.08};
  const std::pair<double, double> Energy5_16{6.77, 0.07};
  const std::pair<double, double> Energy6_16{7.19, 0.07};
  const std::pair<double, double> Energy7_16{8.36, 0.04};
  const std::pair<double, double> Energy8_16{10.35, 0.06};

  //  version 2
  //  const std::pair<double, double> Energy1{0.97, 0.62};
  //  const std::pair<double, double> Energy2{3.38, 0.62};
  //  const std::pair<double, double> Energy3{3.33, 0.62};
  //  const std::pair<double, double> Energy4{8.1, 0.62};
  //  const std::pair<double, double> Energy5{2.21, 0.62};
  //  const std::pair<double, double> Energy6{4.62, 0.62};
  //  const std::pair<double, double> Energy7{1.96, 0.62};
  //  const std::pair<double, double> Energy8{4.65, 0.62};

  //  version 3
  //  const std::pair<double, double> Energy1{1.85, 0.6};
  //  const std::pair<double, double> Energy2{4.32, 0.6};
  //  const std::pair<double, double> Energy3{4.19, 0.6};
  //  const std::pair<double, double> Energy4{8.94, 0.6};
  //  const std::pair<double, double> Energy5{3.1, 0.6};
  //  const std::pair<double, double> Energy6{5.51, 0.6};
  //  const std::pair<double, double> Energy7{2.78, 0.6};
  //  const std::pair<double, double> Energy8{5.56, 0.6};

  //  version 4
  //  const std::pair<double, double> Energy1{1.54, 0.6};
  //  const std::pair<double, double> Energy2{3.61, 0.6};
  //  const std::pair<double, double> Energy3{3.47, 0.6};
  //  const std::pair<double, double> Energy4{7.95, 0.6};
  //  const std::pair<double, double> Energy5{2.58, 0.6};
  //  const std::pair<double, double> Energy6{4.6, 0.6};
  //  const std::pair<double, double> Energy7{2.32, 0.6};
  //  const std::pair<double, double> Energy8{4.74, 0.6};

  std::map<std::string, std::pair<double, double>> AmEnergy1MHzMap{
      {"000", Energy1_1}, {"001", Energy2_1}, {"010", Energy3_1},
      {"011", Energy4_1}, {"100", Energy5_1}, {"101", Energy6_1},
      {"110", Energy7_1}, {"111", Energy8_1}};
  std::map<std::string, std::pair<double, double>> AmEnergy4MHzMap{
      {"000", Energy1_4}, {"001", Energy2_4}, {"010", Energy3_4},
      {"011", Energy4_4}, {"100", Energy5_4}, {"101", Energy6_4},
      {"110", Energy7_4}, {"111", Energy8_4}};
  std::map<std::string, std::pair<double, double>> AmEnergy8MHzMap{
      {"000", Energy1_8}, {"001", Energy2_8}, {"010", Energy3_8},
      {"011", Energy4_8}, {"100", Energy5_8}, {"101", Energy6_8},
      {"110", Energy7_8}, {"111", Energy8_8}};
  std::map<std::string, std::pair<double, double>> AmEnergy16MHzMap{
      {"000", Energy1_16}, {"001", Energy2_16}, {"010", Energy3_16},
      {"011", Energy4_16}, {"100", Energy5_16}, {"101", Energy6_16},
      {"110", Energy7_16}, {"111", Energy8_16}};

public:
  explicit Msp430(std::string filename,
                  std::map<std::string, std::string> timingMap = {},
                  std::map<std::string, std::string> energyMap = {})
      : Name(std::move(filename)) {
    UTimingMap = timingMap;
    UEnergyMap = energyMap;
  }
  std::map<std::pair<std::string, std::string>,
           std::vector<std::pair<double, double>>>
      functionBBCosts;
  std::string getText();
  std::vector<std::string> stringToLine();
  std::vector<std::array<std::string, 3>>
      instructionParser(std::vector<std::string>);
  void calculateTimeEnergy(std::vector<std::string>, std::string, std::string,
                           std::string);
  void calculateTimeEnergy1MHz(std::vector<std::string>, std::string,
                               std::string);
  void calculateTimeEnergy4MHz(std::vector<std::string>, std::string,
                               std::string);
  void calculateTimeEnergy8MHz(std::vector<std::string>, std::string,
                               std::string);
  void calculateTimeEnergy16MHz(std::vector<std::string>, std::string,
                                std::string);

  std::map<std::string, std::map<std::string, std::vector<std::string>>>
      blockParser(std::vector<std::string>);
  static double findOutlierValue(std::vector<double>);
  void printToFile(
      const std::map<std::string,
                     std::map<std::string, std::vector<std::string>>> &funcList,
      std::vector<double> meanVectorTime, std::vector<double> stdVectorTime,
      std::vector<double> meanVectorEnergy, std::vector<double> stdVectorEnergy,
      const std::string &fileName);
  void instructionCounter(
      std::map<std::string, std::map<std::string, std::vector<std::string>>>,
      std::string);
};

#endif // STANDALONE_APPLICATION_MSP430_H
