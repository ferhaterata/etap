# Checkpoint Measurement

The checkpoint function runs 10 times in a for loop since the measurement
capabilities are not enough to capture for only one checkpoint function (onboard
ez-FET samples in 1 kHz). After for loop is done, the power mode is set to LPM4
so the decrease on the power and energy consumption can be seen on the graphs.
Also, run-time for the for loop can be found out. Measurement timer is set to 1
second.

For loop aprox. runs for 60 ms. Consumption for checkpoint functions
is `~120 mJ`. So, for one checkpoint function:
energy consumption is `~12 mJ`, run-time is `~6 ms`.

Absolute energy consumption is needed because every single checkpoint
consumption measurement also contains energy consumed by the MCU (without any
load, idle). This idle energy consumption must be subtracted from energy
consumption of one checkpoint function.

Idle energy consumption is around `1.7 mJ` in Active Mode(AM).

E<sub>absolute_checkpoint</sub> = E<sub>checkpoint</sub> - E<sub>idle</sub>

### Absolute Consumption

Absolute consumption for one checkpoint function is about:  
`12 mJ - 1.7 mJ = 10.3 mJ`.