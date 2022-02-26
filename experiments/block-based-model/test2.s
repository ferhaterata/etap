checkpoint: ; @checkpoint
  push r4
  mov r1, r4
  pop r4
  ret
largest: ; @largest
  push r4
  mov r1, r4
  sub #16, r1
  mov r13, -8(r4) ; 2-byte Folded Spill
  mov r12, -6(r4) ; 2-byte Folded Spill
  call #checkpoint
  mov -6(r4), r12 ; 2-byte Folded Reload
  mov 0(r12), r13
  mov #1, r12
  mov r13, -4(r4) ; 2-byte Folded Spill
  mov r12, -2(r4) ; 2-byte Folded Spill
  jmp .LBB1_1
.LBB1_1: ; %for.cond
  mov -8(r4), r13 ; 2-byte Folded Reload
  mov -4(r4), r14 ; 2-byte Folded Reload
  mov -2(r4), r12 ; 2-byte Folded Reload
  mov r12, -12(r4) ; 2-byte Folded Spill
  mov r14, -10(r4) ; 2-byte Folded Spill
  cmp r13, r12
  jge .LBB1_6
  jmp .LBB1_2
.LBB1_2: ; %for.body
  mov -10(r4), r12 ; 2-byte Folded Reload
  mov -6(r4), r13 ; 2-byte Folded Reload
  mov -12(r4), r14 ; 2-byte Folded Reload
  add r14, r14
  add r14, r13
  mov 0(r13), r13
  cmp r13, r12
  mov r12, -14(r4) ; 2-byte Folded Spill
  jge .LBB1_4
  jmp .LBB1_3
.LBB1_3: ; %if.then
  mov -6(r4), r12 ; 2-byte Folded Reload
  mov -12(r4), r13 ; 2-byte Folded Reload
  add r13, r13
  add r13, r12
  mov 0(r12), r12
  mov r12, -14(r4) ; 2-byte Folded Spill
  jmp .LBB1_4
.LBB1_4: ; %if.end
  mov -14(r4), r12 ; 2-byte Folded Reload
  mov r12, -16(r4) ; 2-byte Folded Spill
  jmp .LBB1_5
.LBB1_5: ; %for.inc
  mov -16(r4), r13 ; 2-byte Folded Reload
  mov -12(r4), r12 ; 2-byte Folded Reload
  inc r12
  mov r13, -4(r4) ; 2-byte Folded Spill
  mov r12, -2(r4) ; 2-byte Folded Spill
  jmp .LBB1_1
.LBB1_6: ; %for.end
  call #checkpoint
  mov -10(r4), r12 ; 2-byte Folded Reload
  add #16, r1
  pop r4
  ret
main: ; @main
  push r4
  mov r1, r4
  sub #60, r1
  clr -20(r4)
  mov #.L__const.main.arr, r13
  mov r4, r12
  sub #44, r12
  mov r12, -54(r4) ; 2-byte Folded Spill
  mov #20, r14
  call #memcpy
  mov -54(r4), r13 ; 2-byte Folded Reload
  mov #5, -48(r4)
  mov -48(r4), r12
  mov r13, -4(r4)
  mov r12, -8(r4)
  call #checkpoint
  mov -4(r4), r12
  mov 0(r12), r12
  mov r12, -12(r4)
  mov #1, -16(r4)
  jmp .LBB2_1
.LBB2_1: ; %for.cond.i
  mov -16(r4), r12
  mov -8(r4), r13
  cmp r13, r12
  jge .LBB2_5
  jmp .LBB2_2
.LBB2_2: ; %for.body.i
  mov -4(r4), r12
  mov -16(r4), r13
  add r13, r13
  add r13, r12
  mov 0(r12), r13
  mov -12(r4), r12
  cmp r13, r12
  jge .LBB2_4
  jmp .LBB2_3
.LBB2_3: ; %if.then.i
  mov -4(r4), r12
  mov -16(r4), r13
  add r13, r13
  add r13, r12
  mov 0(r12), r12
  mov r12, -12(r4)
  jmp .LBB2_4
.LBB2_4: ; %if.end.i
  mov -16(r4), r12
  inc r12
  mov r12, -16(r4)
  jmp .LBB2_1
.LBB2_5: ; %largest.exit
  call #checkpoint
  mov -12(r4), r12
  mov r12, -52(r4)
  mov -52(r4), r13
  mov r1, r12
  mov r13, 2(r12)
  mov #.L.str, 0(r12)
  call #printf
  mov -52(r4), r12
  add #60, r1
  pop r4
  ret
.L__const.main.arr:
  .short 10 ; 0xa
  .short 324 ; 0x144
  .short 45 ; 0x2d
  .short 90 ; 0x5a
  .short 8000 ; 0x1f40

.L.str:
  .asciz "Largest in given array is %d"
