cmake_minimum_required(VERSION 3.17)
project(aes C)

set(CMAKE_C_STANDARD 99)

add_executable(aes.out aes.c aes.h main.c)
add_executable(embedded-aes.out aes.c aes.h embedded.c)
