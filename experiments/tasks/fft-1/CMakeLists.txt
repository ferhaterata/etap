cmake_minimum_required(VERSION 3.17)
project(fft-1 C)

set(CMAKE_C_STANDARD 99)

add_executable(fft-1 ddcmath.h ddc.h fftmisc.c fourierf.c fourier.h main.c)

target_link_libraries(fft-1 m)