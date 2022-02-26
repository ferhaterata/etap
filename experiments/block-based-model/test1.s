AES128_ECB_encrypt: ; @AES128_ECB_encrypt
  sub #6, r1
  mov r12, 4(r1)
  mov r13, 2(r1)
  mov r14, 0(r1)
  mov 0(r1), r12
  mov 4(r1), r13
  call #BlockCopy
  mov 0(r1), r12
  mov r12, &state
  mov 2(r1), r12
  mov r12, &Key
  call #KeyExpansion
  call #Cipher
  add #6, r1
  ret
BlockCopy: ; @BlockCopy
  sub #6, r1
  mov r12, 4(r1)
  mov r13, 2(r1)
  clr.b 1(r1)
  jmp .LBB1_1
.LBB1_1: ; %for.cond
  mov.b 1(r1), r12
  cmp #16, r12
  jge .LBB1_4
  jmp .LBB1_2
.LBB1_2: ; %for.body
  mov 2(r1), r12
  mov.b 1(r1), r13
  add r13, r12
  mov.b 0(r12), r14
  mov 4(r1), r12
  add r13, r12
  mov.b r14, 0(r12)
  jmp .LBB1_3
.LBB1_3: ; %for.inc
  mov.b 1(r1), r12
  inc.b r12
  mov.b r12, 1(r1)
  jmp .LBB1_1
.LBB1_4: ; %for.end
  add #6, r1
  ret
KeyExpansion: ; @KeyExpansion
  push r10
  sub #28, r1
  clr 26(r1)
  clr 24(r1)
  jmp .LBB2_1
.LBB2_1: ; %for.cond
  mov 24(r1), r12
  mov 26(r1), r13
  tst r13
  mov r2, r14
  rra r14
  mov #1, r15
  bic r14, r15
  cmp #4, r12
  mov r2, r12
  and #1, r12
  tst r13
  mov r15, 10(r1) ; 2-byte Folded Spill
  mov r12, 8(r1) ; 2-byte Folded Spill
  jeq .LBB2_3
  mov 10(r1), r12 ; 2-byte Folded Reload
  mov r12, 8(r1) ; 2-byte Folded Spill
.LBB2_3: ; %for.cond
  mov 8(r1), r12 ; 2-byte Folded Reload
  bit #1, r12
  jne .LBB2_6
  jmp .LBB2_4
.LBB2_4: ; %for.body
  mov &Key, r12
  mov 24(r1), r13
  add r13, r13
  add r13, r13
  add r13, r12
  mov.b 0(r12), r14
  mov.b r14, RoundKey(r13)
  mov &Key, r12
  mov 24(r1), r13
  add r13, r13
  add r13, r13
  mov r13, r15
  add r12, r15
  mov.b 1(r15), r14
  mov.b r14, RoundKey+1(r13)
  mov &Key, r12
  mov 24(r1), r13
  add r13, r13
  add r13, r13
  mov r13, r15
  add r12, r15
  mov.b 2(r15), r14
  mov.b r14, RoundKey+2(r13)
  mov &Key, r12
  mov 24(r1), r13
  add r13, r13
  add r13, r13
  mov r13, r15
  add r12, r15
  mov.b 3(r15), r14
  mov.b r14, RoundKey+3(r13)
  jmp .LBB2_5
.LBB2_5: ; %for.inc
  mov 26(r1), r12
  mov 24(r1), r13
  mov r13, r14
  inc r14
  cmp r13, r14
  mov r2, r13
  mov #1, r15
  bic r13, r15
  add r15, r12
  mov r14, 24(r1)
  mov r12, 26(r1)
  jmp .LBB2_1
.LBB2_6: ; %for.end
  jmp .LBB2_7
.LBB2_7: ; %for.cond29
  mov 24(r1), r12
  mov 26(r1), r13
  tst r13
  mov r2, r14
  rra r14
  mov #1, r15
  bic r14, r15
  cmp #44, r12
  mov r2, r12
  and #1, r12
  tst r13
  mov r15, 6(r1) ; 2-byte Folded Spill
  mov r12, 4(r1) ; 2-byte Folded Spill
  jeq .LBB2_9
  mov 6(r1), r12 ; 2-byte Folded Reload
  mov r12, 4(r1) ; 2-byte Folded Spill
.LBB2_9: ; %for.cond29
  mov 4(r1), r12 ; 2-byte Folded Reload
  bit #1, r12
  jne .LBB2_21
  jmp .LBB2_10
.LBB2_10: ; %for.body31
  clr 22(r1)
  clr 20(r1)
  jmp .LBB2_11
.LBB2_11: ; %for.cond32
  mov 20(r1), r12
  mov 22(r1), r13
  tst r13
  mov r2, r14
  rra r14
  mov #1, r15
  bic r14, r15
  cmp #4, r12
  mov r2, r12
  and #1, r12
  tst r13
  mov r15, 2(r1) ; 2-byte Folded Spill
  mov r12, 0(r1) ; 2-byte Folded Spill
  jeq .LBB2_13
  mov 2(r1), r12 ; 2-byte Folded Reload
  mov r12, 0(r1) ; 2-byte Folded Spill
.LBB2_13: ; %for.cond32
  mov 0(r1), r12 ; 2-byte Folded Reload
  bit #1, r12
  jne .LBB2_16
  jmp .LBB2_14
.LBB2_14: ; %for.body34
  mov 24(r1), r12
  add r12, r12
  add r12, r12
  mov 20(r1), r13
  add r13, r12
  mov.b RoundKey-4(r12), r14
  mov r1, r12
  add #12, r12
  add r13, r12
  mov.b r14, 0(r12)
  jmp .LBB2_15
.LBB2_15: ; %for.inc41
  mov 22(r1), r12
  mov 20(r1), r13
  mov r13, r14
  inc r14
  cmp r13, r14
  mov r2, r13
  mov #1, r15
  bic r13, r15
  add r15, r12
  mov r14, 20(r1)
  mov r12, 22(r1)
  jmp .LBB2_11
.LBB2_16: ; %for.end43
  mov.b 24(r1), r12
  bit.b #3, r12
  jne .LBB2_18
  jmp .LBB2_17
.LBB2_17: ; %if.then
  mov.b 12(r1), r12
  mov r12, 16(r1)
  clr 18(r1)
  mov.b 13(r1), r13
  mov.b r13, 12(r1)
  mov.b 14(r1), r13
  mov.b r13, 13(r1)
  mov.b 15(r1), r13
  mov.b r13, 14(r1)
  mov.b 16(r1), r13
  mov.b r13, 15(r1)
  mov.b 12(r1), r12
  call #getSBoxValue
  mov.b r12, 12(r1)
  mov.b 13(r1), r12
  call #getSBoxValue
  mov.b r12, 13(r1)
  mov.b 14(r1), r12
  call #getSBoxValue
  mov.b r12, 14(r1)
  mov.b 15(r1), r12
  call #getSBoxValue
  mov.b r12, 15(r1)
  mov.b 12(r1), r13
  mov.b 26(r1), r14
  mov 24(r1), r15
  clrc
  rrc r15
  rra r15
  swpb r14
  add r14, r14
  add r14, r14
  add r14, r14
  add r14, r14
  add r14, r14
  add r14, r14
  bis r14, r15
  mov.b Rcon(r15), r14
  xor r14, r13
  mov.b r13, 12(r1)
  jmp .LBB2_19
.LBB2_18: ; %if.else
  jmp .LBB2_19
.LBB2_19: ; %if.end
  mov 24(r1), r12
  add r12, r12
  add r12, r12
  mov.b RoundKey-16(r12), r13
  mov.b 12(r1), r14
  xor r14, r13
  mov.b r13, RoundKey(r12)
  mov 24(r1), r12
  add r12, r12
  add r12, r12
  mov.b RoundKey-15(r12), r14
  mov.b 13(r1), r15
  xor r15, r14
  mov.b r14, RoundKey+1(r12)
  mov 24(r1), r12
  add r12, r12
  add r12, r12
  mov.b RoundKey-14(r12), r15
  mov.b 14(r1), r11
  xor r11, r15
  mov.b r15, RoundKey+2(r12)
  mov 24(r1), r12
  add r12, r12
  add r12, r12
  mov.b RoundKey-13(r12), r11
  mov.b 15(r1), r10
  xor r10, r11
  mov.b r11, RoundKey+3(r12)
  jmp .LBB2_20
.LBB2_20: ; %for.inc128
  mov 26(r1), r12
  mov 24(r1), r13
  mov r13, r14
  inc r14
  cmp r13, r14
  mov r2, r13
  mov #1, r15
  bic r13, r15
  add r15, r12
  mov r14, 24(r1)
  mov r12, 26(r1)
  jmp .LBB2_7
.LBB2_21: ; %for.end130
  add #28, r1
  pop r10
  ret
Cipher: ; @Cipher
  sub #2, r1
  clr.b 1(r1)
  clr r12
  call #AddRoundKey
  mov.b #1, 1(r1)
  jmp .LBB3_1
.LBB3_1: ; %for.cond
  mov.b 1(r1), r12
  cmp #10, r12
  jge .LBB3_4
  jmp .LBB3_2
.LBB3_2: ; %for.body
  call #SubBytes
  call #ShiftRows
  call #MixColumns
  mov.b 1(r1), r12
  call #AddRoundKey
  jmp .LBB3_3
.LBB3_3: ; %for.inc
  mov.b 1(r1), r12
  inc.b r12
  mov.b r12, 1(r1)
  jmp .LBB3_1
.LBB3_4: ; %for.end
  call #SubBytes
  call #ShiftRows
  mov #10, r12
  call #AddRoundKey
  add #2, r1
  ret
AES128_ECB_decrypt: ; @AES128_ECB_decrypt
  sub #6, r1
  mov r12, 4(r1)
  mov r13, 2(r1)
  mov r14, 0(r1)
  mov 0(r1), r12
  mov 4(r1), r13
  call #BlockCopy
  mov 0(r1), r12
  mov r12, &state
  mov 2(r1), r12
  mov r12, &Key
  call #KeyExpansion
  call #InvCipher
  add #6, r1
  ret
InvCipher: ; @InvCipher
  sub #2, r1
  clr.b 1(r1)
  mov #10, r12
  call #AddRoundKey
  mov.b #9, 1(r1)
  jmp .LBB5_1
.LBB5_1: ; %for.cond
  mov.b 1(r1), r12
  cmp #1, r12
  jl .LBB5_4
  jmp .LBB5_2
.LBB5_2: ; %for.body
  call #InvShiftRows
  call #InvSubBytes
  mov.b 1(r1), r12
  call #AddRoundKey
  call #InvMixColumns
  jmp .LBB5_3
.LBB5_3: ; %for.inc
  mov.b 1(r1), r12
  add.b #-1, r12
  mov.b r12, 1(r1)
  jmp .LBB5_1
.LBB5_4: ; %for.end
  call #InvShiftRows
  call #InvSubBytes
  clr r12
  call #AddRoundKey
  add #2, r1
  ret
AES128_CBC_encrypt_buffer: ; @AES128_CBC_encrypt_buffer
  push r10
  push r9
  push r8
  push r7
  sub #26, r1
  mov r15, r11
  mov r14, r10
  mov 38(r1), r9
  mov 36(r1), r8
  mov r12, 24(r1)
  mov r13, 22(r1)
  mov r15, 20(r1)
  mov r14, 18(r1)
  mov.b 18(r1), r7
  and.b #15, r7
  mov.b r7, 15(r1)
  mov 24(r1), r12
  mov 22(r1), r13
  mov r11, 12(r1) ; 2-byte Folded Spill
  mov r10, 10(r1) ; 2-byte Folded Spill
  mov r9, 8(r1) ; 2-byte Folded Spill
  mov r8, 6(r1) ; 2-byte Folded Spill
  call #BlockCopy
  mov 24(r1), r12
  mov r12, &state
  mov 36(r1), r12
  tst r12
  jeq .LBB6_2
  jmp .LBB6_1
.LBB6_1: ; %if.then
  mov 36(r1), r12
  mov r12, &Key
  call #KeyExpansion
  jmp .LBB6_2
.LBB6_2: ; %if.end
  mov 38(r1), r12
  tst r12
  jeq .LBB6_4
  jmp .LBB6_3
.LBB6_3: ; %if.then4
  mov 38(r1), r12
  mov r12, &Iv
  jmp .LBB6_4
.LBB6_4: ; %if.end5
  clr 16(r1)
  jmp .LBB6_5
.LBB6_5: ; %for.cond
  mov 16(r1), r12
  mov r12, r13
  swpb r13
  sxt r13
  rra r13
  rra r13
  rra r13
  rra r13
  rra r13
  rra r13
  rra r13
  mov 20(r1), r14
  mov 18(r1), r15
  cmp r15, r12
  mov r2, r12
  and #1, r12
  cmp r14, r13
  mov r2, r15
  and #1, r15
  cmp r14, r13
  mov r15, 4(r1) ; 2-byte Folded Spill
  mov r12, 2(r1) ; 2-byte Folded Spill
  jeq .LBB6_7
  mov 4(r1), r12 ; 2-byte Folded Reload
  mov r12, 2(r1) ; 2-byte Folded Spill
.LBB6_7: ; %for.cond
  mov 2(r1), r12 ; 2-byte Folded Reload
  bit #1, r12
  jne .LBB6_10
  jmp .LBB6_8
.LBB6_8: ; %for.body
  mov 22(r1), r12
  call #XorWithIv
  mov 24(r1), r12
  mov 22(r1), r13
  call #BlockCopy
  mov 24(r1), r12
  mov r12, &state
  call #Cipher
  mov 24(r1), r12
  mov r12, &Iv
  mov 22(r1), r12
  add #16, r12
  mov r12, 22(r1)
  mov 24(r1), r12
  add #16, r12
  mov r12, 24(r1)
  jmp .LBB6_9
.LBB6_9: ; %for.inc
  mov 16(r1), r12
  add #16, r12
  mov r12, 16(r1)
  jmp .LBB6_5
.LBB6_10: ; %for.end
  mov.b 15(r1), r12
  tst.b r12
  jeq .LBB6_12
  jmp .LBB6_11
.LBB6_11: ; %if.then10
  mov 24(r1), r12
  mov 22(r1), r13
  call #BlockCopy
  mov 24(r1), r12
  mov.b 15(r1), r13
  add r13, r12
  mov #16, r14
  sub r13, r14
  clr r13
  call #memset
  mov 24(r1), r13
  mov r13, &state
  mov r12, 0(r1) ; 2-byte Folded Spill
  call #Cipher
  jmp .LBB6_12
.LBB6_12: ; %if.end14
  add #26, r1
  pop r7
  pop r8
  pop r9
  pop r10
  ret
XorWithIv: ; @XorWithIv
  sub #4, r1
  mov r12, 2(r1)
  clr.b 1(r1)
  jmp .LBB7_1
.LBB7_1: ; %for.cond
  mov.b 1(r1), r12
  cmp #16, r12
  jge .LBB7_4
  jmp .LBB7_2
.LBB7_2: ; %for.body
  mov &Iv, r12
  mov.b 1(r1), r13
  add r13, r12
  mov.b 0(r12), r12
  mov 2(r1), r14
  add r13, r14
  mov.b 0(r14), r13
  xor r12, r13
  mov.b r13, 0(r14)
  jmp .LBB7_3
.LBB7_3: ; %for.inc
  mov.b 1(r1), r12
  inc.b r12
  mov.b r12, 1(r1)
  jmp .LBB7_1
.LBB7_4: ; %for.end
  add #4, r1
  ret
AES128_CBC_decrypt_buffer: ; @AES128_CBC_decrypt_buffer
  push r10
  push r9
  push r8
  push r7
  sub #26, r1
  mov r15, r11
  mov r14, r10
  mov 38(r1), r9
  mov 36(r1), r8
  mov r12, 24(r1)
  mov r13, 22(r1)
  mov r15, 20(r1)
  mov r14, 18(r1)
  mov.b 18(r1), r7
  and.b #15, r7
  mov.b r7, 15(r1)
  mov 24(r1), r12
  mov 22(r1), r13
  mov r11, 12(r1) ; 2-byte Folded Spill
  mov r10, 10(r1) ; 2-byte Folded Spill
  mov r9, 8(r1) ; 2-byte Folded Spill
  mov r8, 6(r1) ; 2-byte Folded Spill
  call #BlockCopy
  mov 24(r1), r12
  mov r12, &state
  mov 36(r1), r12
  tst r12
  jeq .LBB8_2
  jmp .LBB8_1
.LBB8_1: ; %if.then
  mov 36(r1), r12
  mov r12, &Key
  call #KeyExpansion
  jmp .LBB8_2
.LBB8_2: ; %if.end
  mov 38(r1), r12
  tst r12
  jeq .LBB8_4
  jmp .LBB8_3
.LBB8_3: ; %if.then4
  mov 38(r1), r12
  mov r12, &Iv
  jmp .LBB8_4
.LBB8_4: ; %if.end5
  clr 16(r1)
  jmp .LBB8_5
.LBB8_5: ; %for.cond
  mov 16(r1), r12
  mov r12, r13
  swpb r13
  sxt r13
  rra r13
  rra r13
  rra r13
  rra r13
  rra r13
  rra r13
  rra r13
  mov 20(r1), r14
  mov 18(r1), r15
  cmp r15, r12
  mov r2, r12
  and #1, r12
  cmp r14, r13
  mov r2, r15
  and #1, r15
  cmp r14, r13
  mov r15, 4(r1) ; 2-byte Folded Spill
  mov r12, 2(r1) ; 2-byte Folded Spill
  jeq .LBB8_7
  mov 4(r1), r12 ; 2-byte Folded Reload
  mov r12, 2(r1) ; 2-byte Folded Spill
.LBB8_7: ; %for.cond
  mov 2(r1), r12 ; 2-byte Folded Reload
  bit #1, r12
  jne .LBB8_10
  jmp .LBB8_8
.LBB8_8: ; %for.body
  mov 24(r1), r12
  mov 22(r1), r13
  call #BlockCopy
  mov 24(r1), r12
  mov r12, &state
  call #InvCipher
  mov 24(r1), r12
  call #XorWithIv
  mov 22(r1), r12
  mov r12, &Iv
  mov 22(r1), r12
  add #16, r12
  mov r12, 22(r1)
  mov 24(r1), r12
  add #16, r12
  mov r12, 24(r1)
  jmp .LBB8_9
.LBB8_9: ; %for.inc
  mov 16(r1), r12
  add #16, r12
  mov r12, 16(r1)
  jmp .LBB8_5
.LBB8_10: ; %for.end
  mov.b 15(r1), r12
  tst.b r12
  jeq .LBB8_12
  jmp .LBB8_11
.LBB8_11: ; %if.then10
  mov 24(r1), r12
  mov 22(r1), r13
  call #BlockCopy
  mov 24(r1), r12
  mov.b 15(r1), r13
  add r13, r12
  mov #16, r14
  sub r13, r14
  clr r13
  call #memset
  mov 24(r1), r13
  mov r13, &state
  mov r12, 0(r1) ; 2-byte Folded Spill
  call #InvCipher
  jmp .LBB8_12
.LBB8_12: ; %if.end14
  add #26, r1
  pop r7
  pop r8
  pop r9
  pop r10
  ret
getSBoxValue: ; @getSBoxValue
  sub #2, r1
  mov.b r12, 1(r1)
  mov.b 1(r1), r13
  mov.b sbox(r13), r12
  add #2, r1
  ret
AddRoundKey: ; @AddRoundKey
  sub #4, r1
  mov.b r12, 3(r1)
  clr.b 2(r1)
  jmp .LBB10_1
.LBB10_1: ; %for.cond
  mov.b 2(r1), r12
  cmp #4, r12
  jge .LBB10_8
  jmp .LBB10_2
.LBB10_2: ; %for.body
  clr.b 1(r1)
  jmp .LBB10_3
.LBB10_3: ; %for.cond2
  mov.b 1(r1), r12
  cmp #4, r12
  jge .LBB10_6
  jmp .LBB10_4
.LBB10_4: ; %for.body6
  mov.b 3(r1), r12
  add r12, r12
  add r12, r12
  add r12, r12
  add r12, r12
  mov.b 2(r1), r13
  add r13, r13
  add r13, r13
  add r13, r12
  mov.b 1(r1), r14
  add r14, r12
  mov.b RoundKey(r12), r12
  mov &state, r15
  add r13, r15
  add r14, r15
  mov.b 0(r15), r13
  xor r12, r13
  mov.b r13, 0(r15)
  jmp .LBB10_5
.LBB10_5: ; %for.inc
  mov.b 1(r1), r12
  inc.b r12
  mov.b r12, 1(r1)
  jmp .LBB10_3
.LBB10_6: ; %for.end
  jmp .LBB10_7
.LBB10_7: ; %for.inc19
  mov.b 2(r1), r12
  inc.b r12
  mov.b r12, 2(r1)
  jmp .LBB10_1
.LBB10_8: ; %for.end21
  add #4, r1
  ret
SubBytes: ; @SubBytes
  sub #2, r1
  clr.b 1(r1)
  jmp .LBB11_1
.LBB11_1: ; %for.cond
  mov.b 1(r1), r12
  cmp #4, r12
  jge .LBB11_8
  jmp .LBB11_2
.LBB11_2: ; %for.body
  clr.b 0(r1)
  jmp .LBB11_3
.LBB11_3: ; %for.cond2
  mov.b 0(r1), r12
  cmp #4, r12
  jge .LBB11_6
  jmp .LBB11_4
.LBB11_4: ; %for.body6
  mov &state, r12
  mov.b 0(r1), r13
  add r13, r13
  add r13, r13
  add r13, r12
  mov.b 1(r1), r13
  add r13, r12
  mov.b 0(r12), r12
  call #getSBoxValue
  mov &state, r13
  mov.b 0(r1), r14
  add r14, r14
  add r14, r14
  add r14, r13
  mov.b 1(r1), r14
  add r14, r13
  mov.b r12, 0(r13)
  jmp .LBB11_5
.LBB11_5: ; %for.inc
  mov.b 0(r1), r12
  inc.b r12
  mov.b r12, 0(r1)
  jmp .LBB11_3
.LBB11_6: ; %for.end
  jmp .LBB11_7
.LBB11_7: ; %for.inc13
  mov.b 1(r1), r12
  inc.b r12
  mov.b r12, 1(r1)
  jmp .LBB11_1
.LBB11_8: ; %for.end15
  add #2, r1
  ret
ShiftRows: ; @ShiftRows
  sub #2, r1
  mov &state, r12
  mov.b 1(r12), r13
  mov.b r13, 1(r1)
  mov &state, r12
  mov.b 5(r12), r13
  mov.b r13, 1(r12)
  mov &state, r12
  mov.b 9(r12), r13
  mov.b r13, 5(r12)
  mov &state, r12
  mov.b 13(r12), r13
  mov.b r13, 9(r12)
  mov.b 1(r1), r13
  mov &state, r12
  mov.b r13, 13(r12)
  mov &state, r12
  mov.b 2(r12), r13
  mov.b r13, 1(r1)
  mov &state, r12
  mov.b 10(r12), r13
  mov.b r13, 2(r12)
  mov.b 1(r1), r13
  mov &state, r12
  mov.b r13, 10(r12)
  mov &state, r12
  mov.b 6(r12), r13
  mov.b r13, 1(r1)
  mov &state, r12
  mov.b 14(r12), r13
  mov.b r13, 6(r12)
  mov.b 1(r1), r13
  mov &state, r12
  mov.b r13, 14(r12)
  mov &state, r12
  mov.b 3(r12), r13
  mov.b r13, 1(r1)
  mov &state, r12
  mov.b 15(r12), r13
  mov.b r13, 3(r12)
  mov &state, r12
  mov.b 11(r12), r13
  mov.b r13, 15(r12)
  mov &state, r12
  mov.b 7(r12), r13
  mov.b r13, 11(r12)
  mov.b 1(r1), r13
  mov &state, r12
  mov.b r13, 7(r12)
  add #2, r1
  ret
MixColumns: ; @MixColumns
  sub #4, r1
  clr.b 3(r1)
  jmp .LBB13_1
.LBB13_1: ; %for.cond
  mov.b 3(r1), r12
  cmp #4, r12
  jge .LBB13_4
  jmp .LBB13_2
.LBB13_2: ; %for.body
  mov &state, r12
  mov.b 3(r1), r13
  add r13, r13
  add r13, r13
  add r13, r12
  mov.b 0(r12), r14
  mov.b r14, 0(r1)
  mov &state, r12
  mov.b 3(r1), r13
  add r13, r13
  add r13, r13
  add r13, r12
  mov.b 0(r12), r13
  mov.b 1(r12), r15
  xor r15, r13
  mov.b 2(r12), r15
  xor r15, r13
  mov.b 3(r12), r12
  xor r12, r13
  mov.b r13, 2(r1)
  mov &state, r12
  mov.b 3(r1), r15
  add r15, r15
  add r15, r15
  add r15, r12
  mov.b 0(r12), r15
  mov.b 1(r12), r12
  xor r12, r15
  mov.b r15, 1(r1)
  mov.b 1(r1), r12
  call #xtime
  mov.b r12, 1(r1)
  mov.b 1(r1), r13
  mov.b 2(r1), r14
  xor r14, r13
  mov &state, r14
  mov.b 3(r1), r15
  add r15, r15
  add r15, r15
  add r15, r14
  mov.b 0(r14), r15
  xor r13, r15
  mov.b r15, 0(r14)
  mov &state, r13
  mov.b 3(r1), r14
  add r14, r14
  add r14, r14
  add r14, r13
  mov.b 1(r13), r14
  mov.b 2(r13), r13
  xor r13, r14
  mov.b r14, 1(r1)
  mov.b 1(r1), r12
  call #xtime
  mov.b r12, 1(r1)
  mov.b 1(r1), r13
  mov.b 2(r1), r14
  xor r14, r13
  mov &state, r14
  mov.b 3(r1), r15
  add r15, r15
  add r15, r15
  add r15, r14
  mov.b 1(r14), r15
  xor r13, r15
  mov.b r15, 1(r14)
  mov &state, r13
  mov.b 3(r1), r14
  add r14, r14
  add r14, r14
  add r14, r13
  mov.b 2(r13), r14
  mov.b 3(r13), r13
  xor r13, r14
  mov.b r14, 1(r1)
  mov.b 1(r1), r12
  call #xtime
  mov.b r12, 1(r1)
  mov.b 1(r1), r13
  mov.b 2(r1), r14
  xor r14, r13
  mov &state, r14
  mov.b 3(r1), r15
  add r15, r15
  add r15, r15
  add r15, r14
  mov.b 2(r14), r15
  xor r13, r15
  mov.b r15, 2(r14)
  mov &state, r13
  mov.b 3(r1), r14
  add r14, r14
  add r14, r14
  add r14, r13
  mov.b 3(r13), r13
  mov.b 0(r1), r14
  xor r14, r13
  mov.b r13, 1(r1)
  mov.b 1(r1), r12
  call #xtime
  mov.b r12, 1(r1)
  mov.b 1(r1), r13
  mov.b 2(r1), r14
  xor r14, r13
  mov &state, r14
  mov.b 3(r1), r15
  add r15, r15
  add r15, r15
  add r15, r14
  mov.b 3(r14), r15
  xor r13, r15
  mov.b r15, 3(r14)
  jmp .LBB13_3
.LBB13_3: ; %for.inc
  mov.b 3(r1), r12
  inc.b r12
  mov.b r12, 3(r1)
  jmp .LBB13_1
.LBB13_4: ; %for.end
  add #4, r1
  ret
xtime: ; @xtime
  sub #4, r1
  mov.b r12, 3(r1)
  mov.b 3(r1), r13
  mov r13, r14
  add r14, r14
  clrc
  rrc r13
  rra r13
  rra r13
  rra r13
  rra r13
  rra r13
  rra r13
  mov #27, r15
  mov r13, r12
  mov r15, r13
  mov r14, 0(r1) ; 2-byte Folded Spill
  call #__mspabi_mpyi
  mov 0(r1), r13 ; 2-byte Folded Reload
  xor r12, r13
  mov.b r13, r13
  mov r13, r12
  add #4, r1
  ret
InvShiftRows: ; @InvShiftRows
  sub #2, r1
  mov &state, r12
  mov.b 13(r12), r13
  mov.b r13, 1(r1)
  mov &state, r12
  mov.b 9(r12), r13
  mov.b r13, 13(r12)
  mov &state, r12
  mov.b 5(r12), r13
  mov.b r13, 9(r12)
  mov &state, r12
  mov.b 1(r12), r13
  mov.b r13, 5(r12)
  mov.b 1(r1), r13
  mov &state, r12
  mov.b r13, 1(r12)
  mov &state, r12
  mov.b 2(r12), r13
  mov.b r13, 1(r1)
  mov &state, r12
  mov.b 10(r12), r13
  mov.b r13, 2(r12)
  mov.b 1(r1), r13
  mov &state, r12
  mov.b r13, 10(r12)
  mov &state, r12
  mov.b 6(r12), r13
  mov.b r13, 1(r1)
  mov &state, r12
  mov.b 14(r12), r13
  mov.b r13, 6(r12)
  mov.b 1(r1), r13
  mov &state, r12
  mov.b r13, 14(r12)
  mov &state, r12
  mov.b 3(r12), r13
  mov.b r13, 1(r1)
  mov &state, r12
  mov.b 7(r12), r13
  mov.b r13, 3(r12)
  mov &state, r12
  mov.b 11(r12), r13
  mov.b r13, 7(r12)
  mov &state, r12
  mov.b 15(r12), r13
  mov.b r13, 11(r12)
  mov.b 1(r1), r13
  mov &state, r12
  mov.b r13, 15(r12)
  add #2, r1
  ret
InvSubBytes: ; @InvSubBytes
  sub #2, r1
  clr.b 1(r1)
  jmp .LBB16_1
.LBB16_1: ; %for.cond
  mov.b 1(r1), r12
  cmp #4, r12
  jge .LBB16_8
  jmp .LBB16_2
.LBB16_2: ; %for.body
  clr.b 0(r1)
  jmp .LBB16_3
.LBB16_3: ; %for.cond2
  mov.b 0(r1), r12
  cmp #4, r12
  jge .LBB16_6
  jmp .LBB16_4
.LBB16_4: ; %for.body6
  mov &state, r12
  mov.b 0(r1), r13
  add r13, r13
  add r13, r13
  add r13, r12
  mov.b 1(r1), r13
  add r13, r12
  mov.b 0(r12), r12
  call #getSBoxInvert
  mov &state, r13
  mov.b 0(r1), r14
  add r14, r14
  add r14, r14
  add r14, r13
  mov.b 1(r1), r14
  add r14, r13
  mov.b r12, 0(r13)
  jmp .LBB16_5
.LBB16_5: ; %for.inc
  mov.b 0(r1), r12
  inc.b r12
  mov.b r12, 0(r1)
  jmp .LBB16_3
.LBB16_6: ; %for.end
  jmp .LBB16_7
.LBB16_7: ; %for.inc13
  mov.b 1(r1), r12
  inc.b r12
  mov.b r12, 1(r1)
  jmp .LBB16_1
.LBB16_8: ; %for.end15
  add #2, r1
  ret
InvMixColumns: ; @InvMixColumns
  push r10
  push r9
  sub #110, r1
  clr 108(r1)
  jmp .LBB17_1
.LBB17_1: ; %for.cond
  mov 108(r1), r12
  cmp #4, r12
  jl .LBB17_2
  br #.LBB17_5
.LBB17_2: ; %for.cond
  jmp .LBB17_3
.LBB17_3: ; %for.body
  mov &state, r12
  mov 108(r1), r13
  add r13, r13
  add r13, r13
  add r13, r12
  mov.b 0(r12), r14
  mov.b r14, 107(r1)
  mov &state, r12
  mov 108(r1), r13
  add r13, r13
  add r13, r13
  add r13, r12
  mov.b 1(r12), r14
  mov.b r14, 106(r1)
  mov &state, r12
  mov 108(r1), r13
  add r13, r13
  add r13, r13
  add r13, r12
  mov.b 2(r12), r14
  mov.b r14, 105(r1)
  mov &state, r12
  mov 108(r1), r13
  add r13, r13
  add r13, r13
  add r13, r12
  mov.b 3(r12), r14
  mov.b r14, 104(r1)
  mov.b 107(r1), r12
  call #xtime
  mov.b 107(r1), r13
  mov.b r12, 103(r1) ; 1-byte Folded Spill
  mov r13, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 103(r1), r10 ; 1-byte Folded Reload
  xor.b r12, r10
  mov.b 107(r1), r12
  mov.b r10, 102(r1) ; 1-byte Folded Spill
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 102(r1), r10 ; 1-byte Folded Reload
  xor.b r12, r10
  mov.b 107(r1), r12
  mov.b r10, 101(r1) ; 1-byte Folded Spill
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 106(r1), r13
  mov.b r13, r10
  mov.b r12, 100(r1) ; 1-byte Folded Spill
  mov r13, r12
  mov.b r10, 99(r1) ; 1-byte Folded Spill
  call #xtime
  mov.b 99(r1), r10 ; 1-byte Folded Reload
  xor.b r12, r10
  mov.b 106(r1), r12
  mov.b r10, 98(r1) ; 1-byte Folded Spill
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 106(r1), r13
  mov.b r12, 97(r1) ; 1-byte Folded Spill
  mov r13, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 98(r1), r10 ; 1-byte Folded Reload
  xor.b r12, r10
  mov.b 106(r1), r12
  mov.b r10, 96(r1) ; 1-byte Folded Spill
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 101(r1), r10 ; 1-byte Folded Reload
  mov.b 96(r1), r9 ; 1-byte Folded Reload
  xor.b r9, r10
  mov.b 105(r1), r13
  mov.b r13, r9
  mov.b r12, 95(r1) ; 1-byte Folded Spill
  mov r13, r12
  mov.b r10, 94(r1) ; 1-byte Folded Spill
  mov.b r9, 93(r1) ; 1-byte Folded Spill
  call #xtime
  mov.b 105(r1), r13
  mov.b r12, 92(r1) ; 1-byte Folded Spill
  mov r13, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 93(r1), r10 ; 1-byte Folded Reload
  xor.b r12, r10
  mov.b 105(r1), r12
  mov.b r10, 91(r1) ; 1-byte Folded Spill
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 91(r1), r10 ; 1-byte Folded Reload
  xor.b r12, r10
  mov.b 105(r1), r12
  mov.b r10, 90(r1) ; 1-byte Folded Spill
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 94(r1), r10 ; 1-byte Folded Reload
  mov.b 90(r1), r9 ; 1-byte Folded Reload
  xor.b r9, r10
  mov.b r10, r13
  mov.b 104(r1), r14
  mov.b r12, 89(r1) ; 1-byte Folded Spill
  mov r14, r12
  mov r13, 86(r1) ; 2-byte Folded Spill
  mov r14, 84(r1) ; 2-byte Folded Spill
  call #xtime
  mov.b 104(r1), r13
  mov.b r12, 83(r1) ; 1-byte Folded Spill
  mov r13, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 104(r1), r13
  mov.b r12, 82(r1) ; 1-byte Folded Spill
  mov r13, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r13
  mov 84(r1), r14 ; 2-byte Folded Reload
  xor r13, r14
  mov.b 104(r1), r12
  mov r14, 80(r1) ; 2-byte Folded Spill
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov 86(r1), r13 ; 2-byte Folded Reload
  mov 80(r1), r14 ; 2-byte Folded Reload
  xor r14, r13
  mov &state, r14
  mov 108(r1), r15
  add r15, r15
  add r15, r15
  add r15, r14
  mov.b r13, 0(r14)
  mov.b 107(r1), r14
  mov.b r14, r13
  mov.b r12, 79(r1) ; 1-byte Folded Spill
  mov r14, r12
  mov.b r13, 78(r1) ; 1-byte Folded Spill
  call #xtime
  mov.b 107(r1), r13
  mov.b r12, 77(r1) ; 1-byte Folded Spill
  mov r13, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 107(r1), r13
  mov.b r12, 76(r1) ; 1-byte Folded Spill
  mov r13, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 78(r1), r10 ; 1-byte Folded Reload
  xor.b r12, r10
  mov.b 107(r1), r12
  mov.b r10, 75(r1) ; 1-byte Folded Spill
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 106(r1), r13
  mov.b r12, 74(r1) ; 1-byte Folded Spill
  mov r13, r12
  call #xtime
  mov.b 106(r1), r13
  mov.b r12, 73(r1) ; 1-byte Folded Spill
  mov r13, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 73(r1), r10 ; 1-byte Folded Reload
  xor.b r12, r10
  mov.b 106(r1), r12
  mov.b r10, 72(r1) ; 1-byte Folded Spill
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 72(r1), r10 ; 1-byte Folded Reload
  xor.b r12, r10
  mov.b 106(r1), r12
  mov.b r10, 71(r1) ; 1-byte Folded Spill
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 75(r1), r10 ; 1-byte Folded Reload
  mov.b 71(r1), r9 ; 1-byte Folded Reload
  xor.b r9, r10
  mov.b 105(r1), r13
  mov.b r13, r9
  mov.b r12, 70(r1) ; 1-byte Folded Spill
  mov r13, r12
  mov.b r10, 69(r1) ; 1-byte Folded Spill
  mov.b r9, 68(r1) ; 1-byte Folded Spill
  call #xtime
  mov.b 68(r1), r10 ; 1-byte Folded Reload
  xor.b r12, r10
  mov.b 105(r1), r12
  mov.b r10, 67(r1) ; 1-byte Folded Spill
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 105(r1), r13
  mov.b r12, 66(r1) ; 1-byte Folded Spill
  mov r13, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 67(r1), r10 ; 1-byte Folded Reload
  xor.b r12, r10
  mov.b 105(r1), r12
  mov.b r10, 65(r1) ; 1-byte Folded Spill
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 69(r1), r10 ; 1-byte Folded Reload
  mov.b 65(r1), r9 ; 1-byte Folded Reload
  xor.b r9, r10
  mov.b r10, r13
  mov.b 104(r1), r14
  mov.b r12, 64(r1) ; 1-byte Folded Spill
  mov r14, r12
  mov r13, 62(r1) ; 2-byte Folded Spill
  mov r14, 60(r1) ; 2-byte Folded Spill
  call #xtime
  mov.b 104(r1), r13
  mov.b r12, 59(r1) ; 1-byte Folded Spill
  mov r13, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r13
  mov 60(r1), r14 ; 2-byte Folded Reload
  xor r13, r14
  mov.b 104(r1), r12
  mov r14, 56(r1) ; 2-byte Folded Spill
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r13
  mov 56(r1), r14 ; 2-byte Folded Reload
  xor r13, r14
  mov.b 104(r1), r12
  mov r14, 54(r1) ; 2-byte Folded Spill
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov 62(r1), r13 ; 2-byte Folded Reload
  mov 54(r1), r14 ; 2-byte Folded Reload
  xor r14, r13
  mov &state, r14
  mov 108(r1), r15
  add r15, r15
  add r15, r15
  add r15, r14
  mov.b r13, 1(r14)
  mov.b 107(r1), r14
  mov.b r14, r13
  mov.b r12, 53(r1) ; 1-byte Folded Spill
  mov r14, r12
  mov.b r13, 52(r1) ; 1-byte Folded Spill
  call #xtime
  mov.b 107(r1), r13
  mov.b r12, 51(r1) ; 1-byte Folded Spill
  mov r13, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 52(r1), r10 ; 1-byte Folded Reload
  xor.b r12, r10
  mov.b 107(r1), r12
  mov.b r10, 50(r1) ; 1-byte Folded Spill
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 50(r1), r10 ; 1-byte Folded Reload
  xor.b r12, r10
  mov.b 107(r1), r12
  mov.b r10, 49(r1) ; 1-byte Folded Spill
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 106(r1), r13
  mov.b r13, r10
  mov.b r12, 48(r1) ; 1-byte Folded Spill
  mov r13, r12
  mov.b r10, 47(r1) ; 1-byte Folded Spill
  call #xtime
  mov.b 106(r1), r13
  mov.b r12, 46(r1) ; 1-byte Folded Spill
  mov r13, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 106(r1), r13
  mov.b r12, 45(r1) ; 1-byte Folded Spill
  mov r13, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 47(r1), r10 ; 1-byte Folded Reload
  xor.b r12, r10
  mov.b 106(r1), r12
  mov.b r10, 44(r1) ; 1-byte Folded Spill
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 49(r1), r10 ; 1-byte Folded Reload
  mov.b 44(r1), r9 ; 1-byte Folded Reload
  xor.b r9, r10
  mov.b 105(r1), r13
  mov.b r12, 43(r1) ; 1-byte Folded Spill
  mov r13, r12
  mov.b r10, 42(r1) ; 1-byte Folded Spill
  call #xtime
  mov.b 105(r1), r13
  mov.b r12, 41(r1) ; 1-byte Folded Spill
  mov r13, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 41(r1), r10 ; 1-byte Folded Reload
  xor.b r12, r10
  mov.b 105(r1), r12
  mov.b r10, 40(r1) ; 1-byte Folded Spill
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 40(r1), r10 ; 1-byte Folded Reload
  xor.b r12, r10
  mov.b 105(r1), r12
  mov.b r10, 39(r1) ; 1-byte Folded Spill
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 42(r1), r10 ; 1-byte Folded Reload
  mov.b 39(r1), r9 ; 1-byte Folded Reload
  xor.b r9, r10
  mov.b r10, r13
  mov.b 104(r1), r14
  mov.b r12, 38(r1) ; 1-byte Folded Spill
  mov r14, r12
  mov r13, 36(r1) ; 2-byte Folded Spill
  mov r14, 34(r1) ; 2-byte Folded Spill
  call #xtime
  mov.b r12, r13
  mov 34(r1), r14 ; 2-byte Folded Reload
  xor r13, r14
  mov.b 104(r1), r12
  mov r14, 32(r1) ; 2-byte Folded Spill
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 104(r1), r13
  mov.b r12, 31(r1) ; 1-byte Folded Spill
  mov r13, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r13
  mov 32(r1), r14 ; 2-byte Folded Reload
  xor r13, r14
  mov.b 104(r1), r12
  mov r14, 28(r1) ; 2-byte Folded Spill
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov 36(r1), r13 ; 2-byte Folded Reload
  mov 28(r1), r14 ; 2-byte Folded Reload
  xor r14, r13
  mov &state, r14
  mov 108(r1), r15
  add r15, r15
  add r15, r15
  add r15, r14
  mov.b r13, 2(r14)
  mov.b 107(r1), r14
  mov.b r14, r13
  mov.b r12, 27(r1) ; 1-byte Folded Spill
  mov r14, r12
  mov.b r13, 26(r1) ; 1-byte Folded Spill
  call #xtime
  mov.b 26(r1), r10 ; 1-byte Folded Reload
  xor.b r12, r10
  mov.b 107(r1), r12
  mov.b r10, 25(r1) ; 1-byte Folded Spill
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 107(r1), r13
  mov.b r12, 24(r1) ; 1-byte Folded Spill
  mov r13, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 25(r1), r10 ; 1-byte Folded Reload
  xor.b r12, r10
  mov.b 107(r1), r12
  mov.b r10, 23(r1) ; 1-byte Folded Spill
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 106(r1), r13
  mov.b r13, r10
  mov.b r12, 22(r1) ; 1-byte Folded Spill
  mov r13, r12
  mov.b r10, 21(r1) ; 1-byte Folded Spill
  call #xtime
  mov.b 106(r1), r13
  mov.b r12, 20(r1) ; 1-byte Folded Spill
  mov r13, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 21(r1), r10 ; 1-byte Folded Reload
  xor.b r12, r10
  mov.b 106(r1), r12
  mov.b r10, 19(r1) ; 1-byte Folded Spill
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 19(r1), r10 ; 1-byte Folded Reload
  xor.b r12, r10
  mov.b 106(r1), r12
  mov.b r10, 18(r1) ; 1-byte Folded Spill
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 23(r1), r10 ; 1-byte Folded Reload
  mov.b 18(r1), r9 ; 1-byte Folded Reload
  xor.b r9, r10
  mov.b r10, r13
  mov.b 105(r1), r14
  mov.b r12, 17(r1) ; 1-byte Folded Spill
  mov r14, r12
  mov r13, 14(r1) ; 2-byte Folded Spill
  mov r14, 12(r1) ; 2-byte Folded Spill
  call #xtime
  mov.b 105(r1), r13
  mov.b r12, 11(r1) ; 1-byte Folded Spill
  mov r13, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 105(r1), r13
  mov.b r12, 10(r1) ; 1-byte Folded Spill
  mov r13, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r13
  mov 12(r1), r14 ; 2-byte Folded Reload
  xor r13, r14
  mov.b 105(r1), r12
  mov r14, 8(r1) ; 2-byte Folded Spill
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov 14(r1), r13 ; 2-byte Folded Reload
  mov 8(r1), r14 ; 2-byte Folded Reload
  xor r14, r13
  mov.b 104(r1), r14
  mov.b r12, 7(r1) ; 1-byte Folded Spill
  mov r14, r12
  mov r13, 4(r1) ; 2-byte Folded Spill
  call #xtime
  mov.b 104(r1), r13
  mov.b r12, 3(r1) ; 1-byte Folded Spill
  mov r13, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 3(r1), r10 ; 1-byte Folded Reload
  xor.b r12, r10
  mov.b 104(r1), r12
  mov.b r10, 2(r1) ; 1-byte Folded Spill
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b 2(r1), r10 ; 1-byte Folded Reload
  xor.b r12, r10
  mov.b r10, r13
  mov.b 104(r1), r12
  mov r13, 0(r1) ; 2-byte Folded Spill
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov.b r12, r12
  call #xtime
  mov 4(r1), r13 ; 2-byte Folded Reload
  mov 0(r1), r14 ; 2-byte Folded Reload
  xor r14, r13
  mov &state, r14
  mov 108(r1), r15
  add r15, r15
  add r15, r15
  add r15, r14
  mov.b r13, 3(r14)
  jmp .LBB17_4
.LBB17_4: ; %for.inc
  mov 108(r1), r12
  inc r12
  mov r12, 108(r1)
  br #.LBB17_1
.LBB17_5: ; %for.end
  add #110, r1
  pop r9
  pop r10
  ret
getSBoxInvert: ; @getSBoxInvert
  sub #2, r1
  mov.b r12, 1(r1)
  mov.b 1(r1), r13
  mov.b rsbox(r13), r12
  add #2, r1
  ret
