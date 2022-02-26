//  ----------------------------------------------------------------------------
//  Header file for the Model class.                                   model.hpp
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 14, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

#ifndef STANDALONE_APPLICATION_MODEL_HPP
#define STANDALONE_APPLICATION_MODEL_HPP

#include <string>

namespace prob::conf::inst {

class Model {
 public:
  std::string OpcodeName;
  std::string TimingModel;
  std::string EnergyModel;

  Model(std::string opcode, std::string timing, std::string energy);

  Model() = default;
};

}  // namespace prob::conf::inst
#endif  // STANDALONE_APPLICATION_MODEL_HPP
