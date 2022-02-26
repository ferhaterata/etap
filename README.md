# ETAP: Energy-aware Timing Analysis of Intermittent Programs

Energy harvesting battery-free embedded devices rely only on ambient energy harvesting that enables stand-alone and sustainable IoT applications. These devices execute programs when the harvested ambient energy in their energy reservoir is sufficient to operate and stop execution abruptly (and start charging) otherwise. These intermittent programs have varying timing behavior under different energy conditions, hardware configurations, and program structures. This project introduces **Energy-aware Timing Analysis of intermittent Programs** (ETAP), a probabilistic symbolic execution approach that analyzes the timing and energy behavior of intermittent programs at compile time. ETAP symbolically executes the given program while taking time and energy cost models for ambient energy and dynamic energy consumption into account. We evaluated ETAP on several intermittent programs and compared the compile-time analysis results with executions on real hardware. The results show that ETAP's normalized prediction accuracy is 99.5%, and it speeds up the timing analysis by at least two orders of magnitude compared to manual testing.

## Technical Report
Ferhat Erata, Arda Goknil, Eren Yıldız, Kasım Yıldırım, Ruzica Piskac, Jakub Szefer, and Gökçin Sezgin, "ETAP: Energy-aware Timing Analysis of Intermittent Programs", February 2022. [arXiv](https://arxiv.org/abs/2201.11433)

## Tooling Contributors
1. [Ferhat Erata](https://www.linkedin.com/in/ferhaterata/)
2. [Gökçin Sezgin](https://www.linkedin.com/in/g%C3%B6k%C3%A7in-sezgin/)
3. [Enes Varcan](https://www.linkedin.com/in/enesvarcan/)
4. [Numan Kılıç](https://www.linkedin.com/in/numankilic/)
5. [Eren Yıldız](https://www.linkedin.com/in/erenyildiz33/)

## Notes
* [Download clang-extended and MSP430-elf for ETAP compiler directives and MSP430 intrinsics to work](https://www.dropbox.com/s/xerzw0vvylrps1m/clang-extended.tar.xz)
