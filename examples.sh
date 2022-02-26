# Demo 1
./start.sh -i ./input/spectre.cpp -m input/discrete-model.R -xmin 100 -xmax 400 -inc 0.01 -from 230 -to 300 -t
./start.sh -i ./input/spectre.cpp -m input/deterministic-model.R -xmin 100 -xmax 400 -inc 0.01 -from 230 -to 300 -t
./start.sh -i ./input/get_sign.c -m input/continuous-generating-function-model.R -xmin 200 -xmax 600 -f get_sign -inc 0.2 -from 425 -to 500 -e
./start.sh -i ./input/get_sign.c -m input/continuous-no-mix-model.R -xmin 50 -xmax 200 -inc 0.1 -from 110 -to 150 -t
./start.sh -i ./input/foo.c -m input/deterministic-model.R -f foo -xmin 100 -xmax 400 -inc 0.01 -from 230 -to 300 -t

# Test set 1
./start.sh -i ./input/spectre.cpp -m input/deterministic-model.R -xmin 100 -xmax 400 -inc 0.01 -from 230 -to 300 -t
./start.sh -i ./input/spectre.cpp -m input/discrete-model.R -xmin 100 -xmax 400 -inc 0.01 -from 230 -to 300 -t
./start.sh -i ./input/spectre.cpp -m input/continuous-model.R -xmin 100 -xmax 400 -inc 0.01 -from 230 -to 300 -t
./start.sh -i ./input/spectre.cpp -m input/continuous-generating-function-model.R -xmin 200 -xmax 600 -f -inc 0.2 -from 100 -to 130 -e
# Test set 2
./start.sh -i ./input/get_sign.c -m input/continuous-generating-function-model.R -xmin 200 -xmax 600 -f get_sign -inc 0.2 -from 425 -to 500 -e
./start.sh -i ./input/get_sign.c -m input/continuous-model.R -xmin 50 -xmax 200 -f get_sign -inc 0.1 -from 100 -to 130 -t
./start.sh -i ./input/get_sign.c -m input/continuous-no-mix-model.R -xmin 50 -xmax 200 -f get_sign -inc 0.1 -from 80 -to 100 -t
./start.sh -i ./input/get_sign.c -m input/continuous-no-mix-model.R -xmin 50 -xmax 200 -inc 0.1 -from 80 -to 100 -t
./start.sh -i ./input/get_sign.c -m input/discrete-model.R -xmin 50 -xmax 200 -inc 0.1 -f get_sign -from 80 -to 100 -t
# Test set 3
./start.sh -i ./input/foo.c -m input/deterministic-model.R -f foo -xmin 100 -xmax 400 -inc 0.01 -from 230 -to 300 -t
