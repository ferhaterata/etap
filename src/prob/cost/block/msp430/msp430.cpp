//
// Created by numan on 18.03.2021.
//

#include "msp430.h"

std::string Msp430::getText() {
  std::ifstream ifs(Name);
  std::string content((std::istreambuf_iterator<char>(ifs)),
                      (std::istreambuf_iterator<char>()));
  return content;
}
// given test string needs to be transform
std::vector<std::string> Msp430::stringToLine() {
  std::stringstream ss(getText());
  std::string line;
  std::vector<std::string> v;
  while (std::getline(ss, line, '\n')) {
    if (line == "") continue;
    line = std::regex_replace(line, std::regex("^\\s*"), "");
    line = std::regex_replace(line, std::regex("\\t"), " ");

    v.push_back(line);
  }
  return v;
}

// given input text was split to function. each function has own blocks.
// each block has own instructions.
std::map<std::string, std::map<std::string, std::vector<std::string>>>
Msp430::blockParser(std::vector<std::string> text) {
  std::map<std::string, std::map<std::string, std::vector<std::string>>>
      functionList;
  std::vector<std::string> blockInstructions;
  std::string funcName{""};
  std::string blockName{""};
  int inst_count = 0;
  int block_count = 0;
  for (auto line : text) {
    if (line.rfind(";", 0) == 0) continue;      // comment line
    if (line.find(":") != std::string::npos) {  // if line is not an instruction
      if (line[0] == '.') {  // if line is a label (block) name
        block_count++;
        line = std::regex_replace(line, std::regex(".*; %"), "");
        if (line[0] == '.') continue;
        blockName = line;
      } else {  // if line is a function name
        line = std::regex_replace(line, std::regex(":.*"), "");
        funcName = line;
        functionList[funcName]["entry"] = blockInstructions;
        blockName = "entry";
        block_count++;
      }
    } else {  // if line is an instruction
      if (line[0] == '.') continue;
      inst_count++;
      line = std::regex_replace(line, std::regex("\\s*?;.*"),
                                "");  // if there is a comment, remove
      functionList[funcName][blockName].push_back(line);
    }
  }
  //  std::cout << "inst_count: " << inst_count << " block_count: " <<
  //  block_count << "\n";
  return functionList;
}
[[maybe_unused]] void Msp430::instructionCounter(
    std::map<std::string, std::map<std::string, std::vector<std::string>>>
        functName,
    std::string profile) {
  int inst_counter = 0;
  int block_counter = 0;
  std::ifstream ifs(profile);
  std::string content((std::istreambuf_iterator<char>(ifs)),
                      (std::istreambuf_iterator<char>()));
  content = content.substr(0, content.find_first_of(':'));
  std::vector<std::string> blockNames;
  std::stringstream s(content);
  std::string block;
  while (std::getline(s, block, '%')) {
    block_counter++;
    for (auto function : functName) {
      inst_counter += function.second[block].size();
    }
  }
  //  std::cout << "block count: " << block_counter << "\n";
  //  std::cout << "inst count: " << inst_counter << "\n";
}
// regex for capturing instruction and operands
// ([a-zA-Z]+) ?(#\d+|r[0-9]{1,2}|-?\d+\(r[0-9]{1,2}\))?,?
// ?(#\d+|r[0-9]{1,2}|-?\d+\(r[0-9]{1,2}\))?
std::vector<std::array<std::string, 3>> Msp430::instructionParser(
    std::vector<std::string> instructionVector) {
  std::vector<std::array<std::string, 3>> parsed_vector;
  std::regex reg_ex(
      R"(([a-zA-Z]+)[\t* *]?(&[a-zA-Z]+|#\d+|r[0-9]{1,2}|-?\d+\(r[0-9]{1,2}\)|.*)?,? ?(&[a-zA-Z]+|#\d+|r[0-9]{1,2}|-?\d+\(r[0-9]{1,2}\))?)");
  std::smatch matches;
  for (auto instruction : instructionVector) {
    std::regex_search(instruction, matches, reg_ex);
    std::array<std::string, 3> str_arr;
    // capturing group 1: instruction
    // capturing group 2: operand 1 ( if exist )
    // capturing group 3: operand 2 ( if exist )
    for (int i = 1; i < matches.size(); ++i) {
      str_arr[i - 1] = matches[i].str();
    }
    parsed_vector.push_back(str_arr);
  }
  return parsed_vector;
}

/*
  As   Ad
  00    0 = ^r[0-9]{1,2}$                   => r15
  01    1 = ^\d+\(r[0-9]{1,2}\)$            => 32(r15)
  10    - = ^@r[0-9]{1,2}$                  => @r14
  11    - = ^@r[0-9]{1,2}\+$|^#[0-9A-F]+$   => @r15+  or  #12AF
*/

std::vector<std::pair<double, double>> Msp430::calculateTimeEnergy(
    std::vector<std::string> instructionVector, std::string blockName,
    std::string functionName) {
  std::string address_mode_s{"00"};
  std::string address_mode_d{"0"};
  std::string address_mode;                // default: 000
  std::pair<double, double> cycle{0, 0};   // initial time cost
  std::pair<double, double> energy{0, 0};  // initial energy cost
  std::vector<std::pair<double, double>> result;
  std::regex reg1{"^r[0-9]{1,2}$"};
  std::regex reg2{R"(^\d+\(r[0-9]{1,2}\)$)"};
  std::regex reg3{"^@r[0-9]{1,2}$"};
  std::regex reg4{"^@r[0-9]{1,2}\\+$|^#[0-9A-F]+$"};
  std::smatch m;

  std::vector<std::array<std::string, 3>> ins_op1_op2 =
      instructionParser(instructionVector);
  for (auto line : ins_op1_op2) {
    // FORMAT I Instruction
    if (line[1].length() != 0) {
      if (std::regex_search(line[1], m, reg1))
        address_mode_s = "00";
      else if (std::regex_search(line[1], m, reg2))
        address_mode_s = "01";
      else if (std::regex_search(line[1], m, reg3))
        address_mode_s = "10";
      else if (std::regex_search(line[1], m, reg4))
        address_mode_s = "11";
    }
    if (line[2].length() != 0) {
      if (std::regex_search(line[2], m, reg1))
        address_mode_d = "0";
      else if (std::regex_search(line[2], m, reg2))
        address_mode_d = "1";
    }
    // BR has special cases
    if (line[0] == "br") {
      if (std::regex_search(line[1], m, reg4)) {
        cycle.first += 3;
        energy.first += 7.08;
        energy.second += pow(0.62, 2);
        continue;
      }
      if (address_mode_s == "00") {
        cycle.first += 2;
        energy.first += 5.8;
        energy.second += pow(0.62, 2);
        continue;
      }
    }

    address_mode = address_mode_s + address_mode_d;
    if (line[0] == "call" && line[1] == "__mspabi_mpyi") {
      cycle.first += 15.94;
      cycle.second += pow(0.27, 2);
      energy.first += 16.38;
      energy.second += pow(0.23, 2);
      continue;
    }
    if (line[0] == "call" && line[1] == "__mspabi_divu") {
      cycle.first += 16.39;
      cycle.second += pow(0.23, 2);
      energy.first += 16.68;
      energy.second += pow(0.17, 2);
      continue;
    }

    if (line[0] == "call") {
      if (UTimingMap[line[1]] != "") {
        BlockCallTiming[functionName + "$" + blockName] +=
            " + " + UTimingMap[line[1]];
      }
      if (UEnergyMap[line[1]] != "") {
        BlockCallEnergy[functionName + "$" + blockName] +=
            " + " + UEnergyMap[line[1]];
      }
    }
    // FORMAT II Instructions
    if (line[0] == "rrc" || line[0] == "pra" || line[0] == "swpb" ||
        line[0] == "sxt")
      line[0] = "formatII";
    if (line[0] == "formatII" || line[0] == "push" || line[0] == "call") {
      if (address_mode == "000") {
        if (line[0] == "formatII") {
          cycle.first += 1;
          energy.first += 4.52;
          energy.second += pow(0.62, 2);
          continue;
        }
        if (line[0] == "push") {
          cycle.first += 3.01;
          energy.first += 7.08;
          energy.second += pow(0.62, 2);
          continue;
        }
        if (line[0] == "call") {
          cycle.first += 3.02;
          energy.first += 8.33;
          energy.second += pow(0.62, 2);
          continue;
        }
      } else if (address_mode_s == "01") {
        if (line[0] == "formatII") {
          cycle.first += 4;
          energy.first += 8.33;
          energy.second += pow(0.62, 2);
          continue;
        }
        if (line[0] == "push") {
          cycle.first += 4.02;
          energy.first += 10.1;
          energy.second += pow(0.62, 2);
          continue;
        }
        if (line[0] == "call") {
          cycle.first += 4.02;
          energy.first += 10.1;
          energy.second += pow(0.62, 2);
          continue;
        }
      } else if (address_mode_s == "10" &&
                 std::regex_search(line[2], m, reg3)) {
        if (line[0] == "formatII") {
          cycle.first += 3;
          energy.first += 7.08;
          energy.second += pow(0.62, 2);
          continue;
        }
        if (line[0] == "push") {
          cycle.first += 3.52;
          energy.first += 8.33;
          energy.second += pow(0.62, 2);
          continue;
        }
        if (line[0] == "call") {
          cycle.first += 3.02;
          energy.first += 8.33;
          energy.second += pow(0.62, 2);
          continue;
        }
      } else if (address_mode_s == "11" &&
                 std::regex_search(line[2], m, reg4)) {
        if (line[0] == "formatII") {
          cycle.first += 3;
          energy.first += 7.08;
          energy.second += pow(0.62, 2);
          continue;
        }
        if (line[0] == "push") {
          cycle.first += 3.02;
          energy.first += 8.33;
          energy.second += pow(0.62, 2);
          continue;
        }
        if (line[0] == "call") {
          cycle.first += 4.02;
          energy.first += 10.1;
          energy.second += pow(0.62, 2);
          continue;
        }
      }
    }

    // FORMAT III Instructions
    std::regex jump("^j[a-z]{1,2}$");
    if (std::regex_search(line[0], m, jump)) {
      cycle.first += 2;
      energy.first += 5.8;
      energy.second += pow(0.62, 2);
      continue;
    }
    if (line[0] == "reti") {
      cycle.first += 5;
      energy.first += 10.1;
      energy.second += pow(0.62, 2);
      continue;
    }
    if (line[0] == "dadd") {
      cycle.first += 1;
      energy.first += AmEnergyMap["000"].first;
      energy.second += pow(AmEnergyMap["000"].second, 2);
      continue;
    }
    cycle.first += AmTimeMap[address_mode].first;
    cycle.second += pow(AmTimeMap[address_mode].second, 2);

    energy.first += AmEnergyMap[address_mode].first;
    energy.second += pow(AmEnergyMap[address_mode].second, 2);
  }
  energy.second = round(sqrt(energy.second) * 100) / 100;
  cycle.second = round(sqrt(cycle.second) * 100) / 100;
  result.push_back(cycle);
  result.push_back(energy);

  return result;  // result.at(0) --> timing,   result.at(1) --> energy
}

void Msp430::printToFile(
    std::map<std::string, std::map<std::string, std::vector<std::string>>>
        funcList,
    std::vector<double> meanVectorTime, std::vector<double> stdVectorTime,
    std::vector<double> meanVectorEnergy, std::vector<double> stdVectorEnergy,
    std::string fileName) {
  std::ofstream modelConf;
  modelConf.open(fileName);
  int i = 0;
  for (auto& funct : funcList) {
    for (auto& block : funct.second) {
      if (meanVectorTime[i] == 0 || meanVectorEnergy[i] == 0) {
        i++;
        continue;
      }
      if (stdVectorTime[i] == 0) {
        modelConf << "timing$" << funct.first << "$" << block.first << " <- "
                  << meanVectorTime[i]
                  << BlockCallTiming[funct.first + "$" + block.first]
                  << " # us\n";
      } else {
        modelConf << "timing$" << funct.first << "$" << block.first
                  << " <- distr::Norm(mean = " << meanVectorTime[i]
                  << ", sd = " << stdVectorTime[i] << ")"
                  << BlockCallTiming[funct.first + "$" + block.first]
                  << " # us\n";
      }
      if (stdVectorEnergy[i] == 0) {
        modelConf << "energy$" << funct.first << "$" << block.first << " <- "
                  << meanVectorEnergy[i]
                  << BlockCallEnergy[funct.first + "$" + block.first]
                  << " # nj\n";
      } else {
        modelConf << "energy$" << funct.first << "$" << block.first
                  << " <- distr::Norm(mean = " << meanVectorEnergy[i]
                  << ", sd = " << stdVectorEnergy[i] << ")"
                  << BlockCallEnergy[funct.first + "$" + block.first]
                  << " # nj\n";
      }
      i++;
    }
  }
  std::string memcpy{
      "timing$memcpy <- function(x) distr::Norm(mean = 13.06, sd = 0.01) + x * "
      "distr::Norm(mean = 9.06, sd = 0.01)\n"
      "energy$memcpy <- function(x) distr::Norm(mean = 35.04, sd = 1.38) + x * "
      "distr::Norm(mean = 24.21, sd = 1.24)"};

  modelConf << memcpy << "\n";
  modelConf.close();
}

// helper function to find quartiles
double findMedian(std::vector<double> v) {
  if (v.size() % 2 == 1) return v.at(v.size() / 2);
  return (v.at(v.size() / 2 - 1) + v.at(v.size() / 2)) / 2;
}

[[maybe_unused]] double Msp430::findOutlierValue(std::vector<double> v) {
  double q1;   // first quartile
  double q3;   // third quartile
  double iqr;  // interquartile range
  if (v.size() < 3) return v[2];
  std::sort(v.begin(), v.end());
  std::vector<double> lowHalf(&v[0], &v[v.size() / 2]);
  q1 = findMedian(lowHalf);
  std::vector<double> highHalf(&v[v.size() / 2 + 1], &v[v.size() - 1]);
  q3 = findMedian(highHalf);
  iqr = q3 - q1;

  // detecting outlier_high formula : iqr*1.5 + q3
  return iqr * 1.5 + q3;
}
