If it is possible it would be great to have 50 samples for each measurement. 

# The list of functions to be sampled for timing using logic analyzer

`Checkpoint()` and `Restore()` functions.


# The list of instructions to be sampled for timing using logic analyzer

Initialization for the adressing mode, 01 0.


`# Immediate Data`
`& Absolute address`
`@ Register indirect addressing`

```c
__asm__ __volatile__(" MOV.A #0, R8");  // for addressing mode: 01 0
__asm__ __volatile__(" MOV.A #1, R7");  // for addressing mode: 01 0
```

8 Addressing Modes:

```c
__asm__ __volatile__("MOV R7, R8");       // 00 0 -> 1 cycle
__asm__ __volatile__("MOV R7, 1(R8)");    // 00 1 -> 4 cycle
__asm__ __volatile__("MOV 1(R7), R8");    // 01 0 -> 3 cycle
__asm__ __volatile__("MOV 1(R7), 1(R8)"); // 01 1 -> 6 cycle
__asm__ __volatile__("MOV @R8, R7");      // 10 0 -> 2 cycle
__asm__ __volatile__("MOV @R8, 1(R7)");   // 10 1 -> 5 cycle
__asm__ __volatile__("MOV #20, R7");      // 11 0 -> 2 cycle
__asm__ __volatile__("MOV @R8, 1(R7)");   // 11 1 -> 5 cycle
```

Special Instructions (we weren't able to measure jumps using our method.

```c
__asm__ __volatile__("BR R8");            // 00 0 -> 2 cycle (since (PC + X) points to the operand)
__asm__ __volatile__("BR @R9+");          // 11 0 -> 3 cycle (exception)
```

PUSH/CALL

```c
__asm__ __volatile__("PUSH R8");       // 00 -> 3 cycle
__asm__ __volatile__("PUSH 1(R8)");    // 01 -> 5 cycle
__asm__ __volatile__("PUSH @R8");      // 10 -> 4 cycle
__asm__ __volatile__("PUSH #20");      // 11 -> 4 cycle
```

Jxx - instructions need all 2 cycles independent of a successfull Jump or not.
```
JC/JHS  Label
JEQ/JZ  Label
JGE     Label
JL      Label
JMP     Label
JN      Label
```





