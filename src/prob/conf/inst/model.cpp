//  ----------------------------------------------------------------------------
//  Implementation file for the Model class.                           model.cpp
//  Created by Ferhat Erata <ferhat.erata@yale.edu> on November 14, 2020.
//  Copyright (c) 2020 Yale University. All rights reserved.
// -----------------------------------------------------------------------------

#include "model.hpp"

// -----------------------------------------------------------------------------
// Constructor
prob::conf::inst::Model::Model(std::string opcode, std::string timing,
                               std::string energy)
    : OpcodeName(std::move(opcode)),
      TimingModel(std::move(timing)),
      EnergyModel(std::move(energy)) {}