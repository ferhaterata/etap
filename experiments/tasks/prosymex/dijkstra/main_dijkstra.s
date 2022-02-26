	.text
	.file	"dijkstra.c"
	.globl	checkpoint                      ; -- Begin function checkpoint
	.p2align	1
	.type	checkpoint,@function
checkpoint:                             ; @checkpoint
; %bb.0:                                ; %entry
	ret
.Lfunc_end0:
	.size	checkpoint, .Lfunc_end0-checkpoint
                                        ; -- End function
	.globl	restore                         ; -- Begin function restore
	.p2align	1
	.type	restore,@function
restore:                                ; @restore
; %bb.0:                                ; %entry
	ret
.Lfunc_end1:
	.size	restore, .Lfunc_end1-restore
                                        ; -- End function
	.globl	main_dijkstra                   ; -- Begin function main_dijkstra
	.p2align	1
	.type	main_dijkstra,@function
main_dijkstra:                          ; @main_dijkstra
; %bb.0:                                ; %entry
	sub	#292, r1
	mov	#5, 14(r1)
	mov	#3, 12(r1)
	clr	10(r1)
	clr	8(r1)
	jmp	.LBB2_1
.LBB2_1:                                ; %for.cond
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB2_3 Depth 2
                                        ;       Child Loop BB2_5 Depth 3
                                        ;     Child Loop BB2_12 Depth 2
                                        ;     Child Loop BB2_16 Depth 2
                                        ;       Child Loop BB2_18 Depth 3
                                        ;       Child Loop BB2_24 Depth 3
	mov	8(r1), r12
	cmp	#100, r12
	jge	.LBB2_33
	jmp	.LBB2_2
.LBB2_2:                                ; %for.body
                                        ;   in Loop: Header=BB2_1 Depth=1
	call	#checkpoint
	mov	14(r1), r12
	mov	12(r1), r13
	mov	#AdjMatrix, 290(r1)
	mov	r12, 288(r1)
	mov	r13, 286(r1)
	clr	18(r1)
	jmp	.LBB2_3
.LBB2_3:                                ; %for.cond.i
                                        ;   Parent Loop BB2_1 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_5 Depth 3
	mov	18(r1), r12
	mov	288(r1), r13
	cmp	r13, r12
	jge	.LBB2_11
	jmp	.LBB2_4
.LBB2_4:                                ; %for.body.i
                                        ;   in Loop: Header=BB2_3 Depth=2
	clr	16(r1)
	jmp	.LBB2_5
.LBB2_5:                                ; %for.cond1.i
                                        ;   Parent Loop BB2_1 Depth=1
                                        ;     Parent Loop BB2_3 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	mov	16(r1), r12
	mov	288(r1), r13
	cmp	r13, r12
	jge	.LBB2_10
	jmp	.LBB2_6
.LBB2_6:                                ; %for.body3.i
                                        ;   in Loop: Header=BB2_5 Depth=3
	mov	290(r1), r12
	mov	18(r1), r13
	mov	#20, r14
	mov	r12, 6(r1)                      ; 2-byte Folded Spill
	mov	r13, r12
	mov	r14, r13
	call	#__mspabi_mpyi
	mov	6(r1), r13                      ; 2-byte Folded Reload
	add	r12, r13
	mov	16(r1), r12
	add	r12, r12
	add	r12, r13
	mov	0(r13), r12
	tst	r12
	jne	.LBB2_8
	jmp	.LBB2_7
.LBB2_7:                                ; %if.then.i
                                        ;   in Loop: Header=BB2_5 Depth=3
	mov	18(r1), r12
	mov	#20, r13
	call	#__mspabi_mpyi
	mov	r1, r13
	add	#86, r13
	add	r12, r13
	mov	16(r1), r12
	add	r12, r12
	add	r12, r13
	mov	#9999, 0(r13)
	jmp	.LBB2_9
.LBB2_8:                                ; %if.else.i
                                        ;   in Loop: Header=BB2_5 Depth=3
	mov	290(r1), r12
	mov	18(r1), r13
	mov	#20, r14
	mov	r12, 4(r1)                      ; 2-byte Folded Spill
	mov	r13, r12
	mov	r14, r13
	call	#__mspabi_mpyi
	mov	4(r1), r13                      ; 2-byte Folded Reload
	add	r12, r13
	mov	16(r1), r14
	add	r14, r14
	add	r14, r13
	mov	0(r13), r13
	mov	r1, r15
	add	#86, r15
	add	r12, r15
	add	r14, r15
	mov	r13, 0(r15)
	jmp	.LBB2_9
.LBB2_9:                                ; %if.end.i
                                        ;   in Loop: Header=BB2_5 Depth=3
	mov	16(r1), r12
	inc	r12
	mov	r12, 16(r1)
	jmp	.LBB2_5
.LBB2_10:                               ; %for.end.i
                                        ;   in Loop: Header=BB2_3 Depth=2
	mov	18(r1), r12
	inc	r12
	mov	r12, 18(r1)
	jmp	.LBB2_3
.LBB2_11:                               ; %for.end14.i
                                        ;   in Loop: Header=BB2_1 Depth=1
	call	#checkpoint
	clr	18(r1)
	jmp	.LBB2_12
.LBB2_12:                               ; %for.cond15.i
                                        ;   Parent Loop BB2_1 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	mov	18(r1), r12
	mov	288(r1), r13
	cmp	r13, r12
	jge	.LBB2_14
	jmp	.LBB2_13
.LBB2_13:                               ; %for.body17.i
                                        ;   in Loop: Header=BB2_12 Depth=2
	mov	286(r1), r12
	mov	#20, r13
	call	#__mspabi_mpyi
	mov	r1, r13
	add	#86, r13
	add	r12, r13
	mov	18(r1), r12
	add	r12, r12
	add	r12, r13
	mov	0(r13), r13
	mov	r1, r14
	add	#66, r14
	add	r12, r14
	mov	r13, 0(r14)
	mov	286(r1), r12
	mov	18(r1), r13
	add	r13, r13
	mov	r1, r14
	add	#46, r14
	add	r13, r14
	mov	r12, 0(r14)
	mov	18(r1), r12
	add	r12, r12
	mov	r1, r13
	add	#26, r13
	add	r12, r13
	clr	0(r13)
	mov	18(r1), r12
	inc	r12
	mov	r12, 18(r1)
	jmp	.LBB2_12
.LBB2_14:                               ; %for.end25.i
                                        ;   in Loop: Header=BB2_1 Depth=1
	mov	286(r1), r12
	add	r12, r12
	mov	r1, r13
	add	#66, r13
	add	r12, r13
	clr	0(r13)
	mov	286(r1), r12
	add	r12, r12
	mov	r1, r13
	add	#26, r13
	add	r12, r13
	mov	#1, 0(r13)
	mov	#1, 24(r1)
	jmp	.LBB2_15
.LBB2_15:                               ; %checkpoint.1
                                        ;   in Loop: Header=BB2_1 Depth=1
	call	#checkpoint
	jmp	.LBB2_16
.LBB2_16:                               ; %while.cond.i
                                        ;   Parent Loop BB2_1 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_18 Depth 3
                                        ;       Child Loop BB2_24 Depth 3
	mov	24(r1), r12
	mov	288(r1), r13
	add	#-1, r13
	cmp	r13, r12
	jge	.LBB2_31
	jmp	.LBB2_17
.LBB2_17:                               ; %while.body.i
                                        ;   in Loop: Header=BB2_16 Depth=2
	mov	#9999, 22(r1)
	clr	18(r1)
	jmp	.LBB2_18
.LBB2_18:                               ; %for.cond29.i
                                        ;   Parent Loop BB2_1 Depth=1
                                        ;     Parent Loop BB2_16 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	mov	18(r1), r12
	mov	288(r1), r13
	cmp	r13, r12
	jge	.LBB2_23
	jmp	.LBB2_19
.LBB2_19:                               ; %for.body31.i
                                        ;   in Loop: Header=BB2_18 Depth=3
	mov	18(r1), r12
	add	r12, r12
	mov	r1, r13
	add	#66, r13
	add	r12, r13
	mov	0(r13), r12
	mov	22(r1), r13
	cmp	r13, r12
	jge	.LBB2_22
	jmp	.LBB2_20
.LBB2_20:                               ; %land.lhs.true.i
                                        ;   in Loop: Header=BB2_18 Depth=3
	mov	18(r1), r12
	add	r12, r12
	mov	r1, r13
	add	#26, r13
	add	r12, r13
	mov	0(r13), r12
	tst	r12
	jne	.LBB2_22
	jmp	.LBB2_21
.LBB2_21:                               ; %if.then35.i
                                        ;   in Loop: Header=BB2_18 Depth=3
	mov	18(r1), r12
	add	r12, r12
	mov	r1, r13
	add	#66, r13
	add	r12, r13
	mov	0(r13), r12
	mov	r12, 22(r1)
	mov	18(r1), r12
	mov	r12, 20(r1)
	jmp	.LBB2_22
.LBB2_22:                               ; %if.end37.i
                                        ;   in Loop: Header=BB2_18 Depth=3
	mov	18(r1), r12
	inc	r12
	mov	r12, 18(r1)
	jmp	.LBB2_18
.LBB2_23:                               ; %for.end40.i
                                        ;   in Loop: Header=BB2_16 Depth=2
	mov	20(r1), r12
	add	r12, r12
	mov	r1, r13
	add	#26, r13
	add	r12, r13
	mov	#1, 0(r13)
	clr	18(r1)
	jmp	.LBB2_24
.LBB2_24:                               ; %for.cond42.i
                                        ;   Parent Loop BB2_1 Depth=1
                                        ;     Parent Loop BB2_16 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	mov	18(r1), r12
	mov	288(r1), r13
	cmp	r13, r12
	jge	.LBB2_30
	jmp	.LBB2_25
.LBB2_25:                               ; %for.body44.i
                                        ;   in Loop: Header=BB2_24 Depth=3
	mov	18(r1), r12
	add	r12, r12
	mov	r1, r13
	add	#26, r13
	add	r12, r13
	mov	0(r13), r12
	tst	r12
	jne	.LBB2_29
	jmp	.LBB2_26
.LBB2_26:                               ; %if.then47.i
                                        ;   in Loop: Header=BB2_24 Depth=3
	mov	22(r1), r12
	mov	20(r1), r13
	mov	#20, r14
	mov	r12, 2(r1)                      ; 2-byte Folded Spill
	mov	r13, r12
	mov	r14, r13
	call	#__mspabi_mpyi
	mov	r1, r13
	add	#86, r13
	add	r12, r13
	mov	18(r1), r12
	add	r12, r12
	add	r12, r13
	mov	0(r13), r13
	mov	2(r1), r14                      ; 2-byte Folded Reload
	add	r13, r14
	mov	r1, r13
	add	#66, r13
	add	r12, r13
	mov	0(r13), r12
	cmp	r12, r14
	jge	.LBB2_28
	jmp	.LBB2_27
.LBB2_27:                               ; %if.then52.i
                                        ;   in Loop: Header=BB2_24 Depth=3
	mov	22(r1), r12
	mov	20(r1), r13
	mov	#20, r14
	mov	r12, 0(r1)                      ; 2-byte Folded Spill
	mov	r13, r12
	mov	r14, r13
	call	#__mspabi_mpyi
	mov	r1, r13
	add	#86, r13
	add	r12, r13
	mov	18(r1), r12
	add	r12, r12
	add	r12, r13
	mov	0(r13), r13
	mov	0(r1), r14                      ; 2-byte Folded Reload
	add	r13, r14
	mov	r1, r13
	add	#66, r13
	add	r12, r13
	mov	r14, 0(r13)
	mov	20(r1), r12
	mov	18(r1), r13
	add	r13, r13
	mov	r1, r14
	add	#46, r14
	add	r13, r14
	mov	r12, 0(r14)
	jmp	.LBB2_28
.LBB2_28:                               ; %if.end58.i
                                        ;   in Loop: Header=BB2_24 Depth=3
	jmp	.LBB2_29
.LBB2_29:                               ; %if.end59.i
                                        ;   in Loop: Header=BB2_24 Depth=3
	mov	18(r1), r12
	inc	r12
	mov	r12, 18(r1)
	jmp	.LBB2_24
.LBB2_30:                               ; %for.end62.i
                                        ;   in Loop: Header=BB2_16 Depth=2
	mov	24(r1), r12
	inc	r12
	mov	r12, 24(r1)
	jmp	.LBB2_16
.LBB2_31:                               ; %dijkstra.exit
                                        ;   in Loop: Header=BB2_1 Depth=1
	mov	24(r1), r12
	mov	10(r1), r13
	add	r12, r13
	mov	r13, 10(r1)
	jmp	.LBB2_32
.LBB2_32:                               ; %for.inc
                                        ;   in Loop: Header=BB2_1 Depth=1
	mov	8(r1), r12
	inc	r12
	mov	r12, 8(r1)
	jmp	.LBB2_1
.LBB2_33:                               ; %for.end
	mov	10(r1), r12
	add	#292, r1
	ret
.Lfunc_end2:
	.size	main_dijkstra, .Lfunc_end2-main_dijkstra
                                        ; -- End function
	.type	AdjMatrix,@object               ; @AdjMatrix
	.data
	.globl	AdjMatrix
	.p2align	1
AdjMatrix:
	.short	32                              ; 0x20
	.short	32                              ; 0x20
	.short	54                              ; 0x36
	.short	12                              ; 0xc
	.short	52                              ; 0x34
	.short	56                              ; 0x38
	.short	8                               ; 0x8
	.short	30                              ; 0x1e
	.short	44                              ; 0x2c
	.short	94                              ; 0x5e
	.short	76                              ; 0x4c
	.short	54                              ; 0x36
	.short	65                              ; 0x41
	.short	14                              ; 0xe
	.short	89                              ; 0x59
	.short	69                              ; 0x45
	.short	4                               ; 0x4
	.short	16                              ; 0x10
	.short	24                              ; 0x18
	.short	47                              ; 0x2f
	.short	38                              ; 0x26
	.short	31                              ; 0x1f
	.short	75                              ; 0x4b
	.short	40                              ; 0x28
	.short	61                              ; 0x3d
	.short	21                              ; 0x15
	.short	84                              ; 0x54
	.short	51                              ; 0x33
	.short	86                              ; 0x56
	.short	41                              ; 0x29
	.short	80                              ; 0x50
	.short	16                              ; 0x10
	.short	53                              ; 0x35
	.short	14                              ; 0xe
	.short	94                              ; 0x5e
	.short	29                              ; 0x1d
	.short	77                              ; 0x4d
	.short	99                              ; 0x63
	.short	16                              ; 0x10
	.short	29                              ; 0x1d
	.short	59                              ; 0x3b
	.short	7                               ; 0x7
	.short	14                              ; 0xe
	.short	78                              ; 0x4e
	.short	79                              ; 0x4f
	.short	45                              ; 0x2d
	.short	54                              ; 0x36
	.short	83                              ; 0x53
	.short	8                               ; 0x8
	.short	94                              ; 0x5e
	.short	94                              ; 0x5e
	.short	41                              ; 0x29
	.short	3                               ; 0x3
	.short	61                              ; 0x3d
	.short	27                              ; 0x1b
	.short	19                              ; 0x13
	.short	33                              ; 0x21
	.short	35                              ; 0x23
	.short	78                              ; 0x4e
	.short	38                              ; 0x26
	.short	3                               ; 0x3
	.short	55                              ; 0x37
	.short	41                              ; 0x29
	.short	76                              ; 0x4c
	.short	49                              ; 0x31
	.short	68                              ; 0x44
	.short	83                              ; 0x53
	.short	23                              ; 0x17
	.short	67                              ; 0x43
	.short	15                              ; 0xf
	.short	68                              ; 0x44
	.short	28                              ; 0x1c
	.short	47                              ; 0x2f
	.short	12                              ; 0xc
	.short	82                              ; 0x52
	.short	6                               ; 0x6
	.short	26                              ; 0x1a
	.short	96                              ; 0x60
	.short	98                              ; 0x62
	.short	75                              ; 0x4b
	.short	7                               ; 0x7
	.short	1                               ; 0x1
	.short	46                              ; 0x2e
	.short	39                              ; 0x27
	.short	12                              ; 0xc
	.short	68                              ; 0x44
	.short	41                              ; 0x29
	.short	28                              ; 0x1c
	.short	31                              ; 0x1f
	.short	0                               ; 0x0
	.short	82                              ; 0x52
	.short	97                              ; 0x61
	.short	72                              ; 0x48
	.short	61                              ; 0x3d
	.short	39                              ; 0x27
	.short	48                              ; 0x30
	.short	11                              ; 0xb
	.short	99                              ; 0x63
	.short	38                              ; 0x26
	.short	49                              ; 0x31
	.size	AdjMatrix, 200

	.ident	"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"
	.section	".note.GNU-stack","",@progbits
