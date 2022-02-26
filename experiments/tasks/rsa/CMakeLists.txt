cmake_minimum_required(VERSION 3.17)
project(rsa C)

set(CMAKE_C_STANDARD 99)

add_executable(rsa.out rsa.h rsa.c test.c)