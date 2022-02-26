cmake_minimum_required(VERSION 3.17)
project(sha C)

set(CMAKE_C_STANDARD 99)

add_executable(
        sha.out
        main.c
        input.h
        sha.c
        sha.h)

add_executable(sha-embedded.out sha-embedded.c)
