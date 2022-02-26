#!/usr/bin/env sh

MFILE=./Makefile
INPUT_FILE=
FNAME=
XMIN=0
XMAX=50
YMAX=1
INC=0.01
FROM=0
TO=0
# Due to heat-colors and path probabilities supported after llvm-11 in generating .dot files
LLVM_DIR=/usr/lib/llvm-11
COST_FILE=
MODEL_FILE=

while [ "$1" != "" ]; do
  case $1 in
  -i | --input)
    shift
    INPUT_FILE="$1"
    ;;
  -f | --fname)
    shift
    FNAME="$1"
    ;;
  -xmax)
    shift
    XMAX="$1"
    ;;
  -xmin)
    shift
    XMIN="$1"
    ;;
  -inc)
    shift
    INC="$1"
    ;;
  -ymax)
    shift
    YMAX="$1"
    ;;
  --llvm-dir)
    shift
    LLVM_DIR="$1"
    ;;
  -from)
    shift
    FROM="$1"
    ;;
  -to)
    shift
    TO="$1"
    ;;
  -e)
    COST_FILE=.output/energy.costs
    ;;
  -t)
    COST_FILE=.output/timing.costs
    ;;
  -m | --model-file)
    shift
    MODEL_FILE="$1"
    ;;
  esac
  shift
done

# shellcheck disable=SC2039
ulimit -s 102400 # enlarge stack limit to 100 MB = 102400 KB (in binary)

echo "Checking instruction's model file..."
if ! test -f "$MODEL_FILE"; then
  echo "  Model file not found"
  exit
else
  echo "  Plotting Models"
  if ! [ -d .model ]; then
    mkdir .model
  else
    rm -r ./.model/ >/dev/null 2>&1
    mkdir .model
  fi
  Rscript R/model.R "$MODEL_FILE" svg 2>&1 &#launch shell independent process
fi

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
  ./clang/bin/clang -v -O0 -g -emit-llvm -S -fno-discard-value-names "$INPUT_FILE" -o ./.llvm/input.ll #>/dev/null 2>&1
fi

###
echo "Running CMake..."
cmake -DLT_LLVM_INSTALL_DIR="$LLVM_DIR" -DCMAKE_BUILD_TYPE=Release . #> /dev/null 2>&1
if test -f "$MFILE"; then
  echo "Building passes..."
  make
else
  echo "  Makefile not found"
  exit
fi

###
echo "Running passes..."
if ! [ -d .output ]; then
  mkdir .output
else
  rm -r ./.output/ >/dev/null 2>&1
  mkdir .output
fi

echo "  Running optimization pass (mem2reg, ?simplifycfg, ?constprop)..."
"$LLVM_DIR"/bin/opt -S -mem2reg -time-passes ./.llvm/input.ll -o ./.llvm/input.ll
#"$LLVM_DIR"/bin/opt -S -constprop -simplifycfg -time-passes ./.llvm/input.ll -o ./.llvm/input.ll
#"$LLVM_DIR"/bin/opt -S -time-passes -loop-unroll -unroll-count=3 ./.llvm/input.ll -o ./.llvm/input.ll
echo "  Running config pass..."
"$LLVM_DIR"/bin/opt -S -load ./passes/libConfigPass.so -config-pass -model-file "$MODEL_FILE" ./.llvm/input.ll -o ./.llvm/inst-conf.ll
echo "  Running cost model pass..."
"$LLVM_DIR"/bin/opt -S -load ./passes/libCostModelPass.so -bb-cost-model ./.llvm/inst-conf.ll -o ./.llvm/prob-block-cost.ll

###
echo "Generating control-flow-graph files..."
if ! [ -d .dots ]; then
  mkdir .dots
else
  rm -r ./.dots/ >/dev/null 2>&1
  mkdir .dots
fi
cd .dots || exit
# -cfg-dot-filename-prefix=cfg
# -cfg-func-name=get_sign
# -cfg-heat-colors
# -cfg-weights
# -cfg-raw-weights (optional)
"$LLVM_DIR"/bin/opt -dot-cfg-only -cfg-heat-colors -cfg-weights ../.llvm/prob-block-cost.ll -o /dev/null
"$LLVM_DIR"/bin/opt -dot-cfg -cfg-dot-filename-prefix=.cfg -cfg-heat-colors -cfg-weights ../.llvm/prob-block-cost.ll -o /dev/null
cd ..

###
echo "Embedding Energy/Timing Models to graphs..."
Rscript R/cfg.R # 2>&1 &#launch shell independent process

###
echo "  Running probabilistic symbolic execution pass..."
"$LLVM_DIR"/bin/opt -S -load ./passes/libProbabilisticSymbolicExecution.so -prob-sym-exec ./.llvm/prob-block-cost.ll -o ./.llvm/prob-sym-exec.ll
#echo "  Generating probabilistic symbolic machine..."
#"$LLVM_DIR"/bin/opt -S -load ./passes/libProbabilisticSymbolicExecution.so -prob-sym-exec-writer -execute-machines=true -generate-cfg=false ./.llvm/prob-sym-exec.ll -o ./.llvm/prob-sym-exec.ll
echo "  Running normal execution pass..."
"$LLVM_DIR"/bin/opt -S -load ./passes/libNEAnalysisPass.so -normal-execution ./.llvm/prob-sym-exec.ll -o ./.llvm/output.ll

###
echo "Creating output(s)..."
if ! [ -d .temp ]; then
  mkdir .temp
else
  rm ./.temp/* >/dev/null 2>&1
fi

###
echo "Drawing the graph(s)..."
if [ -z "$FNAME" ]; then
  ./Reporter "$COST_FILE"
else
  ./Reporter "$COST_FILE" -fname "$FNAME"
fi

if [ -n "$FNAME" ]; then
  if ! test -f ./.temp/"$FNAME"; then
    echo "  Function not found"
    exit
  fi
fi

Rscript R/graph.R "$XMIN" "$XMAX" "$YMAX" "$INC" "$FROM" "$TO" #>/dev/null 2>&1
