cmake_minimum_required(VERSION 3.17)
project(qsort C)

set(CMAKE_C_STANDARD 99)

add_executable(qsort.out input_large.h qsort_large.c)
target_link_libraries(qsort.out m)