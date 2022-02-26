// file fft.h
#ifndef EXAMPLE_FFT
#define EXAMPLE_FFT

// The arrays for the fft will be computed in place
// and thus your array will have the fft result
// written over your original data.
// Must provide an array of real and imaginary floats
// where they are both of size N
void fft(float data_re[], float data_im[], const int N);

// helper functions called by the fft
// data will first be rearranged then computed
void rearrange(float data_re[], float data_im[], const int N);
void compute(float data_re[], float data_im[], const int N);
#endif