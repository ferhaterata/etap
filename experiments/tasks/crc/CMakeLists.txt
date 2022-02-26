cmake_minimum_required(VERSION 3.17)
project(crc C)

set(CMAKE_C_STANDARD 99)

add_executable(crc.out crc.c crc.h main.c)
add_executable(crc-embedded.out crc-embedded.c)
