cmake_minimum_required(VERSION 3.17)
project(bitcount C)

set(CMAKE_C_STANDARD 99)

add_executable(bitcount input_large.h qsort_large.c)
target_link_libraries(qsort m)