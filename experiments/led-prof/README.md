# LED Energy Consumption

There are 2 LEDs on the MSP430FR5994 MCU board. Each one has different power and energy consumptions. Red LED consumes two times more
energy than the green LED. Sampling frequency of onboard eZ-FET emulator is 1 kHz. Measurement timer is set to one second.

### Measurement

The code in the main.c file is used to measure energy consumption of these two LEDs.
Select a LED to measure by changing LED definition declared above main function:
```c
#define LED 0x01    // default red LED
```

According to the measurements saved in .energytrace file;

-   for the red LED, total energy consumption is `~11.2mJ`,  
-   for the green LED, total energy consumption is `~5.4mJ`.

-   Idle energy consumption is around `1.7 mJ`.

To find absolute LED power consumption, idle running consumption must be subtracted
from total consumption.

E<sub>absolute</sub> = E<sub>LEDon</sub> - E<sub>LEDoff</sub>

### Absolute Consumptions
For 1 second:  
*   Red LED: `11.2mJ - 1.7mJ = 9.5mJ`  
*   Green LED: `5.4mJ - 1.7mJ = 3.7mJ`

Per cycle for 1MHz:
*   Red LED: `9.5 mJ / 10^6 = 9.5 pJ`
*   Green LED: `5.4 mJ / 10^6 = 5.4 pJ`

### Notes

-   Power and Energy consumptions are unstable, they can change in every debug session.
-   Test environment also affects the measurements.