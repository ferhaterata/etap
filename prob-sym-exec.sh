#!/usr/bin/env sh

# Examples:
# ./prob-sym-exec.sh -i ./input/max.c -m input/continuous-model.R -max-loop 10000 -global-idiom true -plot-return true -block-based false
# ./prob-sym-exec.sh -i ./input/max.c -m -max-loop 10000 -global-idiom true -plot-return true -execution Intermittent -target msp430
MFILE=./Makefile
INPUT_FILE=            # The C/C++ codes under analysis.
MAX_LOOP_COUNT=10      # A certain bound can be set for the loops.
MODEL_FILE=            # R File having timing/Energy Consumption Models (Instruction or Block-based Models)
BLOCK_BASED=true       # The default expected model is block-based; if it is false then the model is instruction-based.
EXECUTION=Normal       # Intermittent, Speculative, Normal
TARGET=                # msp430, x86_64 # If we know the hardware we can predict the cost models.
HARVESTING_MODEL_FILE= # Intermittent execution requires harvesting model.
PLOT_RETURN=false      # Do you want to get the probability distribution of what function return?
GLOBAL_IDIOM=true      # How to represent path probabilities if there exists loops in the control-flow-graph
VERBOSE=false          # Prints R results to terminal
SPLIT_CHECKPOINT=false # Split blocks having checkpoint calls not positioned as the first instruction
FUNCTION=

# Due to heat-colors and path probabilities supported after llvm-11 in generating .dot files
LLVM_DIR=/usr/lib/llvm-12

while [ "$1" != "" ]; do
  case $1 in
  -i | --input)
    shift
    INPUT_FILE="$1"
    ;;
  -max-loop)
    shift
    MAX_LOOP_COUNT="$1"
    ;;
  --llvm-dir)
    shift
    LLVM_DIR="$1"
    ;;
  -m | --model-file)
    shift
    MODEL_FILE="$1"
    ;;
  -global-idiom)
    shift
    GLOBAL_IDIOM="$1"
    ;;
  -plot-return)
    PLOT_RETURN=true
    ;;
  -execution)
    shift
    EXECUTION="$1"
    ;;
  -target)
    shift
    TARGET="$1"
    ;;
  -block-based)
    shift
    BLOCK_BASED="$1"
    ;;
  -harvesting-model-file)
    shift
    HARVESTING_MODEL_FILE="$1"
    ;;
  -v | --verbose)
    VERBOSE=true
    ;;
  -force-split-checkpoint)
    shift
    SPLIT_CHECKPOINT="$1"
    ;;
  -function-name)
    shift
    FUNCTION="$1"
    ;;
  esac
  shift
done

# shellcheck disable=SC2039
ulimit -s unlimited # 102400 enlarge stack limit to 100 MB = 102400 KB (in binary)
###
echo "Checkin input C/C++ file and emitting LLVM code..."
if ! test -f "$INPUT_FILE"; then
  echo "  Input file not found: $INPUT_FILE"
  exit
else
  if ! [ -d .llvm ]; then
    mkdir .llvm
  else
    rm -r ./.llvm/ >/dev/null 2>&1
    mkdir .llvm
  fi
  #  ./clang/bin/clang -v -O0 -g -emit-llvm -S -fno-discard-value-names "$INPUT_FILE" -o ./.llvm/input.ll #>/dev/null 2>&1
  # If a target is given, set it properly in clang
  if [ -n "$TARGET" ]; then
    ./clang/bin/clang -v -O0 --target="$TARGET" -emit-llvm -S -fno-discard-value-names "$INPUT_FILE" -o ./.llvm/input.ll #>/dev/null 2>&1
  else
    ./clang/bin/clang -v -O0 -emit-llvm -S -fno-discard-value-names "$INPUT_FILE" -o ./.llvm/input.ll #>/dev/null 2>&1
  fi
fi

###
echo "Running CMake..."
cmake -DLT_LLVM_INSTALL_DIR="$LLVM_DIR" -DCMAKE_BUILD_TYPE=Release . #> /dev/null 2>&1
if test -f "$MFILE"; then
  echo "Building passes..."
  make
else
  echo "  Makefile not found. Exiting..."
  exit
fi

###
echo "Creating .output directory..."
if ! [ -d .output ]; then
  mkdir .output
else
  rm -r ./.output/ >/dev/null 2>&1
  mkdir .output
fi

## Binary Analysis here for deriving cost models.
if [ "$BLOCK_BASED" = true ]; then
  if [ "$TARGET" = msp430 ]; then
    echo "Target is known; inferring the cost models based on empirical addressing mode model..."
    echo "Creating the cost oracle"
    # generate here: .output/model.conf.R
    "$LLVM_DIR"/bin/llc -O0 ./.llvm/input.ll -o ./.llvm/input.s
    #    Rscript R/msp430.R ./.llvm/input.s .output/model.conf.R # 2>&1 & #launch shell independent process
    "$LLVM_DIR"/bin/opt -S -load ./passes/libMsp430.so -msp430-pass -input .llvm/input.s -output .output/model.conf.R .llvm/input.ll -o .llvm/input.ll
  else # Block-based but there is no target, instead block-based model is given as model file
    if test -f "$MODEL_FILE"; then
      echo "  Copying Block-based model file as model.conf" # may not exist if msp430 is being used.
      cp "$MODEL_FILE" .output/model.conf.R
    fi
  fi
else # INSTRUCTION_BASED
  if test -f "$MODEL_FILE"; then
    echo "  Copying Instruction-based model file as model.conf"
    cp "$MODEL_FILE" .output/model.conf.R
  else # model file is missing and exit
    echo "  Model file not found. Exiting..."
    exit # ERROR
  fi
fi

if test -f "$HARVESTING_MODEL_FILE"; then
  echo "  Copying harvesting model.conf" # may not exist if msp430 is being used.
  cp "$HARVESTING_MODEL_FILE" .output/harvesting.conf.R
fi

###
echo "Running passes..."
echo "  Running optimization pass (mem2reg, ?simplifycfg, ?constprop)..."
"$LLVM_DIR"/bin/opt -S -mem2reg ./.llvm/input.ll -o ./.llvm/input.ll # -time-passes
#echo "  Running config pass..."
#"$LLVM_DIR"/bin/opt -S -load ./passes/libConfigPass.so -config-pass -model-file "$MODEL_FILE" ./.llvm/input.ll -o ./.llvm/inst-conf.ll
#echo "  Running cost model pass..."
#"$LLVM_DIR"/bin/opt -S -load ./passes/libCostModelPass.so -bb-cost-model ./.llvm/inst-conf.ll -o ./.llvm/prob-block-cost.ll

# If the switch is intermittent
if [ "$EXECUTION" = Intermittent ] || [ "$EXECUTION" = ETAP ] || [ "$SPLIT_CHECKPOINT" = true ]; then
  if [ "$EXECUTION" = Intermittent ] || [ "$EXECUTION" = ETAP ]; then
    echo "  Intermittent/ETAP execution: splitting blocks..."
  else
    echo "  Checkpoint Split is forced..."
  fi
  # Run Block/Checkpoint Splitting Pass here
  "$LLVM_DIR"/bin/opt -S -load ./passes/libBlockSplitterPass.so -block-splitter ./.llvm/input.ll -o ./.llvm/block-split.ll
  # if the target is known, infer the cost model again.
  if [ "$TARGET" = msp430 ]; then
    echo "Target is known; inferring cost model after block split."
    echo "Creating the cost oracle"
    # generate here: .output/model.conf.R
    "$LLVM_DIR"/bin/llc -O0 ./.llvm/block-split.ll -o ./.llvm/input-split.s
    #    Rscript R/msp430.R ./.llvm/input-split.s .output/model.conf.R # 2>&1 & #launch shell independent process
    "$LLVM_DIR"/bin/opt -S -load ./passes/libMsp430.so -msp430-pass -input .llvm/input-split.s -output .output/model.conf.R .llvm/input.ll -o .llvm/input.ll
  fi
  # Run Probabilistic Symbolic Execution Pass
  echo "  Running probabilistic symbolic execution pass..."
  "$LLVM_DIR"/bin/opt -S -load ./passes/libProbabilisticSymbolicExecution.so -prob-sym-exec ./.llvm/block-split.ll -o ./.llvm/input.store.ll
else
  echo "  Normal execution..."
  echo "  Running probabilistic symbolic execution pass..."
  "$LLVM_DIR"/bin/opt -S -load ./passes/libProbabilisticSymbolicExecution.so -prob-sym-exec ./.llvm/input.ll -o ./.llvm/input.store.ll
fi

###
echo "Generating control-flow-graph files..."
if ! [ -d .dots ]; then
  mkdir .dots
else
  rm -r ./.dots/ >/dev/null 2>&1
  mkdir .dots
fi

cd .dots || exit
"$LLVM_DIR"/bin/opt -dot-cfg -cfg-dot-filename-prefix=.cfg -cfg-heat-colors -cfg-weights ../.llvm/input.store.ll -o /dev/null
cd ..

echo "  Generating probabilistic symbolic machine..."
"$LLVM_DIR"/bin/opt -S -load ./passes/libProbabilisticSymbolicExecution.so -prob-sym-exec-writer \
  -max-loop-count="$MAX_LOOP_COUNT" -execute-machines=true -generate-cfg=true -print-cfg=true -verbose="$VERBOSE" \
  -global-idiom="$GLOBAL_IDIOM" -plot-return="$PLOT_RETURN" -execution="$EXECUTION" -block-based="$BLOCK_BASED" \
  -function-name="$FUNCTION" ./.llvm/input.store.ll -o ./.llvm/input.store.writer.ll
