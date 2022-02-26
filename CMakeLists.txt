cmake_minimum_required(VERSION 3.4)
set(CMAKE_CXX_STANDARD 17)
project(standalone-application)

find_package(LLVM 12 REQUIRED CONFIG)

message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")
message(STATUS " Definitions ${LLVM_DEFINITIONS}")
message(STATUS " Includes    ${LLVM_INCLUDE_DIRS}")
message(STATUS " Libraries   ${LLVM_LIBRARY_DIRS}")
message(STATUS " Targets     ${LLVM_TARGETS_TO_BUILD}")

# Set your project compile flags.
# E.g. if using the C++ header files
# you will need to enable C++11 support
# for your compiler.

# Build type
if (NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Debug CACHE
            STRING "Build type (default Debug) : " FORCE)
endif ()

include_directories(${LLVM_INCLUDE_DIRS})
add_definitions(${LLVM_DEFINITIONS})

# Find the libraries that correspond to the LLVM components
# that we wish to use
llvm_map_components_to_libnames(llvm_libs support core irreader)

set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/passes)

add_library(CostModelPass SHARED src/CostModelPass.cpp)
add_library(NEAnalysisPass SHARED src/NEAnalysisPass.cpp)
add_library(BlockSplitterPass SHARED src/BlockSplitterPass.cpp)

add_library(JitPass SHARED src/prob/calc/jitpass.cpp)

add_library(ConfigPass SHARED
        src/prob/conf/inst/model.cpp
        src/prob/conf/inst/model.hpp
        src/prob/conf/inst/pass.cpp
        src/prob/conf/inst/pass.hpp)

add_library(ProbabilisticSymbolicExecution SHARED
        src/prob/utility.cpp
        src/prob/utility.hpp
        src/prob/sym/exec.cpp
        src/prob/sym/exec.hpp
        src/prob/sym/writer.cpp
        src/prob/sym/writer.hpp
        src/prob/sym/visitor/visitor.cpp
        src/prob/sym/visitor/visitor.hpp
        src/prob/sym/visitor/count-alloca.cpp
        src/prob/sym/visitor/count-alloca.hpp
        )

add_library(Msp430 SHARED
        src/prob/cost/block/msp430/msp430.h
        src/prob/cost/block/msp430/msp430.cpp
        src/prob/cost/block/msp430/msp430pass.cpp
        )

add_executable(Reporter
        reporter/Reporter.cpp
        reporter/util/Graph.cpp
        reporter/util/Parser.cpp)

add_executable(Utility
        src/prob/test.cpp)

add_executable(msp430
        src/prob/cost/block/msp430/msp430_test.cpp
        src/prob/cost/block/msp430/msp430.cpp)

add_subdirectory(input)
#add_subdirectory(experiments/tasks/bitcount-1)
#add_subdirectory(experiments/tasks/sha)
#add_subdirectory(experiments/tasks/crc)
#add_subdirectory(experiments/tasks/aes)
#add_subdirectory(experiments/tasks/rsa)
#add_subdirectory(experiments/tasks/fft-1)
#add_subdirectory(experiments/tasks/qsort)
#
#add_subdirectory(playground/openmp)

#add_library(Testing
#        test/c/01-oneblock.c
#        test/c/02-simpleloop.c
#        test/c/03-multipleprofiled.c
#        test/c/04-fullybiased.c
#        test/c/05-multibranch.c
#        test/c/06-nestedbranches.c
#        test/c/07-withgotos.c
#        test/c/08-frompaper.c
#        test/c/09-data_access_bug.c
#        test/c/10-cascadingcalls.c
#        test/c/11-input_for_duplicate_bb.c
#        test/c/12-foo_bar_fez.c
#        test/c/13-basicarithmetic.c
#        test/c/14-smallintarithmetic.c
#        test/c/15-arithmetic.c
#        )