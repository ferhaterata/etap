	.text
	.file	"jpeg.c"
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
	.globl	main_jpeg_cosine_transform      ; -- Begin function main_jpeg_cosine_transform
	.p2align	1
	.type	main_jpeg_cosine_transform,@function
main_jpeg_cosine_transform:             ; @main_jpeg_cosine_transform
; %bb.0:                                ; %entry
	push	r10
	sub	#880, r1
	clr	38(r1)
	jmp	.LBB2_1
.LBB2_1:                                ; %for.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov	38(r1), r12
	cmp	#200, r12
	jge	.LBB2_4
	jmp	.LBB2_2
.LBB2_2:                                ; %for.body
                                        ;   in Loop: Header=BB2_1 Depth=1
	call	#checkpoint
	mov	38(r1), r12
	add	r12, r12
	mov	r1, r13
	add	#440, r13
	mov	r13, r14
	add	r12, r14
	clr	0(r14)
	mov	38(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#2047, 2(r12)
	mov	38(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#3072, 4(r12)
	mov	38(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#2048, 6(r12)
	mov	38(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#512, 8(r12)
	mov	38(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#-2048, 10(r12)
	mov	38(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#-3328, 12(r12)
	mov	38(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#1024, 14(r12)
	mov	38(r1), r12
	add	r12, r12
	mov	r1, r13
	add	#40, r13
	mov	r13, r14
	add	r12, r14
	mov	#3168, 0(r14)
	mov	38(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#3136, 2(r12)
	mov	38(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#3104, 4(r12)
	mov	38(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#3072, 6(r12)
	mov	38(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#-2560, 8(r12)
	mov	38(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#-3072, 10(r12)
	mov	38(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#-3584, 12(r12)
	mov	38(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#-4096, 14(r12)
	jmp	.LBB2_3
.LBB2_3:                                ; %for.inc
                                        ;   in Loop: Header=BB2_1 Depth=1
	mov	38(r1), r12
	add	#8, r12
	mov	r12, 38(r1)
	jmp	.LBB2_1
.LBB2_4:                                ; %for.end
	mov	r1, r12
	add	#440, r12
	mov	r12, 878(r1)
	mov	r1, r12
	add	#40, r12
	mov	r12, 876(r1)
	mov	r1, r12
	add	#852, r12
	clr	r13
	mov	#24, r14
	call	#memset
	mov	#1, 846(r1)
	clr	844(r1)
	mov	#13, 842(r1)
	mov	#8, 840(r1)
	jmp	.LBB2_5
.LBB2_5:                                ; %for.cond.i
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB2_8 Depth 2
                                        ;       Child Loop BB2_11 Depth 3
                                        ;       Child Loop BB2_14 Depth 3
                                        ;       Child Loop BB2_16 Depth 3
                                        ;       Child Loop BB2_18 Depth 3
                                        ;       Child Loop BB2_20 Depth 3
                                        ;       Child Loop BB2_22 Depth 3
                                        ;       Child Loop BB2_24 Depth 3
                                        ;       Child Loop BB2_26 Depth 3
                                        ;       Child Loop BB2_28 Depth 3
	mov	846(r1), r12
	cmp	#9, r12
	jl	.LBB2_6
	br	#.LBB2_31
.LBB2_6:                                ; %for.cond.i
                                        ;   in Loop: Header=BB2_5 Depth=1
	jmp	.LBB2_7
.LBB2_7:                                ; %for.body.i
                                        ;   in Loop: Header=BB2_5 Depth=1
	call	#checkpoint
	clr	850(r1)
	jmp	.LBB2_8
.LBB2_8:                                ; %for.cond1.i
                                        ;   Parent Loop BB2_5 Depth=1
                                        ; =>  This Loop Header: Depth=2
                                        ;       Child Loop BB2_11 Depth 3
                                        ;       Child Loop BB2_14 Depth 3
                                        ;       Child Loop BB2_16 Depth 3
                                        ;       Child Loop BB2_18 Depth 3
                                        ;       Child Loop BB2_20 Depth 3
                                        ;       Child Loop BB2_22 Depth 3
                                        ;       Child Loop BB2_24 Depth 3
                                        ;       Child Loop BB2_26 Depth 3
                                        ;       Child Loop BB2_28 Depth 3
	mov	850(r1), r12
	cmp	#8, r12
	jl	.LBB2_9
	br	#.LBB2_30
.LBB2_9:                                ; %for.cond1.i
                                        ;   in Loop: Header=BB2_8 Depth=2
	jmp	.LBB2_10
.LBB2_10:                               ; %for.body3.i
                                        ;   in Loop: Header=BB2_8 Depth=2
	clr	848(r1)
	jmp	.LBB2_11
.LBB2_11:                               ; %for.cond4.i
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_8 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	mov	848(r1), r12
	cmp	#4, r12
	jge	.LBB2_13
	jmp	.LBB2_12
.LBB2_12:                               ; %for.body6.i
                                        ;   in Loop: Header=BB2_11 Depth=3
	mov	878(r1), r12
	mov	846(r1), r13
	mov	848(r1), r14
	mov	r13, r15
	add	r14, r15
	add	r15, r15
	mov	r12, r11
	add	r15, r11
	mov	0(r11), r15
	sub	r14, r13
	add	r13, r13
	add	r12, r13
	mov	14(r13), r12
	add	r12, r15
	add	r14, r14
	mov	r1, r12
	add	#852, r12
	mov	r12, r13
	add	r14, r13
	mov	r15, 0(r13)
	mov	878(r1), r13
	mov	846(r1), r14
	mov	848(r1), r15
	mov	r14, r11
	add	r15, r11
	add	r11, r11
	mov	r13, r10
	add	r11, r10
	mov	0(r10), r11
	mov	#7, r10
	sub	r15, r10
	add	r10, r14
	add	r14, r14
	add	r14, r13
	mov	0(r13), r13
	sub	r13, r11
	add	r10, r10
	add	r10, r12
	mov	r11, 0(r12)
	mov	848(r1), r12
	inc	r12
	mov	r12, 848(r1)
	jmp	.LBB2_11
.LBB2_13:                               ; %for.end.i
                                        ;   in Loop: Header=BB2_8 Depth=2
	mov	852(r1), r12
	mov	858(r1), r13
	add	r13, r12
	mov	r12, 868(r1)
	mov	852(r1), r12
	mov	858(r1), r13
	sub	r13, r12
	mov	r12, 870(r1)
	mov	854(r1), r12
	mov	856(r1), r13
	add	r13, r12
	mov	r12, 872(r1)
	mov	854(r1), r12
	mov	856(r1), r13
	sub	r13, r12
	mov	r12, 874(r1)
	mov	868(r1), r12
	mov	872(r1), r13
	add	r13, r12
	mov.b	844(r1), r14
	cmp.b	#0, r14
	mov	r12, 34(r1)                     ; 2-byte Folded Spill
	mov.b	r14, 33(r1)                     ; 1-byte Folded Spill
	jeq	.LBB2_15
.LBB2_14:                               ; %for.end.i
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_8 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	mov.b	33(r1), r12                     ; 1-byte Folded Reload
	mov	34(r1), r13                     ; 2-byte Folded Reload
	rra	r13
	sub.b	#1, r12
	mov.b	r12, 33(r1)                     ; 1-byte Folded Spill
	mov	r13, 34(r1)                     ; 2-byte Folded Spill
	jne	.LBB2_14
.LBB2_15:                               ; %for.end.i
                                        ;   in Loop: Header=BB2_8 Depth=2
	mov	34(r1), r12                     ; 2-byte Folded Reload
	mov	878(r1), r13
	mov	r12, 0(r13)
	mov	868(r1), r12
	mov	872(r1), r13
	sub	r13, r12
	mov.b	844(r1), r14
	cmp.b	#0, r14
	mov	r12, 30(r1)                     ; 2-byte Folded Spill
	mov.b	r14, 29(r1)                     ; 1-byte Folded Spill
	jeq	.LBB2_17
.LBB2_16:                               ; %for.end.i
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_8 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	mov.b	29(r1), r12                     ; 1-byte Folded Reload
	mov	30(r1), r13                     ; 2-byte Folded Reload
	rra	r13
	sub.b	#1, r12
	mov.b	r12, 29(r1)                     ; 1-byte Folded Spill
	mov	r13, 30(r1)                     ; 2-byte Folded Spill
	jne	.LBB2_16
.LBB2_17:                               ; %for.end.i
                                        ;   in Loop: Header=BB2_8 Depth=2
	mov	30(r1), r12                     ; 2-byte Folded Reload
	mov	878(r1), r13
	mov	846(r1), r14
	add	r14, r14
	add	r13, r14
	mov	r12, 8(r14)
	mov	874(r1), r12
	mov	870(r1), r13
	add	r13, r12
	mov	876(r1), r13
	mov	20(r13), r13
	add	r13, r12
	mov	r12, 868(r1)
	mov	868(r1), r12
	mov	870(r1), r13
	mov	876(r1), r14
	mov	18(r14), r14
	add	r14, r13
	mov.b	842(r1), r15
	cmp.b	#0, r15
	mov	r12, 26(r1)                     ; 2-byte Folded Spill
	mov	r13, 24(r1)                     ; 2-byte Folded Spill
	mov.b	r15, 23(r1)                     ; 1-byte Folded Spill
	jeq	.LBB2_19
.LBB2_18:                               ; %for.end.i
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_8 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	mov.b	23(r1), r12                     ; 1-byte Folded Reload
	mov	24(r1), r13                     ; 2-byte Folded Reload
	rra	r13
	sub.b	#1, r12
	mov.b	r12, 23(r1)                     ; 1-byte Folded Spill
	mov	r13, 24(r1)                     ; 2-byte Folded Spill
	jne	.LBB2_18
.LBB2_19:                               ; %for.end.i
                                        ;   in Loop: Header=BB2_8 Depth=2
	mov	24(r1), r12                     ; 2-byte Folded Reload
	mov	26(r1), r13                     ; 2-byte Folded Reload
	add	r12, r13
	mov	878(r1), r12
	mov	846(r1), r14
	add	r14, r14
	add	r12, r14
	mov	r13, 4(r14)
	mov	868(r1), r12
	mov	874(r1), r13
	mov	876(r1), r14
	mov	22(r14), r14
	add	r14, r13
	mov.b	842(r1), r15
	cmp.b	#0, r15
	mov	r12, 20(r1)                     ; 2-byte Folded Spill
	mov	r13, 18(r1)                     ; 2-byte Folded Spill
	mov.b	r15, 17(r1)                     ; 1-byte Folded Spill
	jeq	.LBB2_21
.LBB2_20:                               ; %for.end.i
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_8 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	mov.b	17(r1), r12                     ; 1-byte Folded Reload
	mov	18(r1), r13                     ; 2-byte Folded Reload
	rra	r13
	sub.b	#1, r12
	mov.b	r12, 17(r1)                     ; 1-byte Folded Spill
	mov	r13, 18(r1)                     ; 2-byte Folded Spill
	jne	.LBB2_20
.LBB2_21:                               ; %for.end.i
                                        ;   in Loop: Header=BB2_8 Depth=2
	mov	18(r1), r12                     ; 2-byte Folded Reload
	mov	20(r1), r13                     ; 2-byte Folded Reload
	add	r12, r13
	mov	878(r1), r12
	mov	846(r1), r14
	add	r14, r14
	add	r12, r14
	mov	r13, 12(r14)
	mov	860(r1), r12
	mov	866(r1), r13
	add	r13, r12
	mov	876(r1), r13
	mov	4(r13), r13
	add	r13, r12
	mov	r12, 852(r1)
	mov	862(r1), r12
	mov	864(r1), r13
	add	r13, r12
	mov	876(r1), r13
	mov	0(r13), r13
	add	r13, r12
	mov	r12, 854(r1)
	mov	860(r1), r12
	mov	864(r1), r13
	add	r13, r12
	mov	r12, 856(r1)
	mov	862(r1), r12
	mov	866(r1), r13
	add	r13, r12
	mov	r12, 858(r1)
	mov	856(r1), r12
	mov	858(r1), r13
	add	r13, r12
	mov	876(r1), r13
	mov	16(r13), r13
	add	r13, r12
	mov	r12, 868(r1)
	mov	856(r1), r12
	mov	876(r1), r13
	mov	2(r13), r13
	add	r13, r12
	mov	868(r1), r13
	add	r13, r12
	mov	r12, 856(r1)
	mov	858(r1), r12
	mov	876(r1), r13
	mov	6(r13), r13
	add	r13, r12
	mov	868(r1), r13
	add	r13, r12
	mov	r12, 858(r1)
	mov	860(r1), r12
	mov	876(r1), r13
	mov	8(r13), r13
	add	r13, r12
	mov	852(r1), r13
	add	r13, r12
	mov	856(r1), r13
	add	r13, r12
	mov.b	842(r1), r15
	cmp.b	#0, r15
	mov	r12, 14(r1)                     ; 2-byte Folded Spill
	mov.b	r15, 13(r1)                     ; 1-byte Folded Spill
	jeq	.LBB2_23
.LBB2_22:                               ; %for.end.i
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_8 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	mov.b	13(r1), r12                     ; 1-byte Folded Reload
	mov	14(r1), r13                     ; 2-byte Folded Reload
	rra	r13
	sub.b	#1, r12
	mov.b	r12, 13(r1)                     ; 1-byte Folded Spill
	mov	r13, 14(r1)                     ; 2-byte Folded Spill
	jne	.LBB2_22
.LBB2_23:                               ; %for.end.i
                                        ;   in Loop: Header=BB2_8 Depth=2
	mov	14(r1), r12                     ; 2-byte Folded Reload
	mov	878(r1), r13
	mov	846(r1), r14
	add	r14, r14
	add	r13, r14
	mov	r12, 14(r14)
	mov	862(r1), r12
	mov	876(r1), r13
	mov	12(r13), r13
	add	r13, r12
	mov	854(r1), r13
	add	r13, r12
	mov	858(r1), r13
	add	r13, r12
	mov.b	842(r1), r15
	cmp.b	#0, r15
	mov	r12, 10(r1)                     ; 2-byte Folded Spill
	mov.b	r15, 9(r1)                      ; 1-byte Folded Spill
	jeq	.LBB2_25
.LBB2_24:                               ; %for.end.i
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_8 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	mov.b	9(r1), r12                      ; 1-byte Folded Reload
	mov	10(r1), r13                     ; 2-byte Folded Reload
	rra	r13
	sub.b	#1, r12
	mov.b	r12, 9(r1)                      ; 1-byte Folded Spill
	mov	r13, 10(r1)                     ; 2-byte Folded Spill
	jne	.LBB2_24
.LBB2_25:                               ; %for.end.i
                                        ;   in Loop: Header=BB2_8 Depth=2
	mov	10(r1), r12                     ; 2-byte Folded Reload
	mov	878(r1), r13
	mov	846(r1), r14
	add	r14, r14
	add	r13, r14
	mov	r12, 10(r14)
	mov	864(r1), r12
	mov	876(r1), r13
	mov	10(r13), r13
	add	r13, r12
	mov	854(r1), r13
	add	r13, r12
	mov	856(r1), r13
	add	r13, r12
	mov.b	842(r1), r15
	cmp.b	#0, r15
	mov	r12, 6(r1)                      ; 2-byte Folded Spill
	mov.b	r15, 5(r1)                      ; 1-byte Folded Spill
	jeq	.LBB2_27
.LBB2_26:                               ; %for.end.i
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_8 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	mov.b	5(r1), r12                      ; 1-byte Folded Reload
	mov	6(r1), r13                      ; 2-byte Folded Reload
	rra	r13
	sub.b	#1, r12
	mov.b	r12, 5(r1)                      ; 1-byte Folded Spill
	mov	r13, 6(r1)                      ; 2-byte Folded Spill
	jne	.LBB2_26
.LBB2_27:                               ; %for.end.i
                                        ;   in Loop: Header=BB2_8 Depth=2
	mov	6(r1), r12                      ; 2-byte Folded Reload
	mov	878(r1), r13
	mov	846(r1), r14
	add	r14, r14
	add	r13, r14
	mov	r12, 6(r14)
	mov	866(r1), r12
	mov	876(r1), r13
	mov	14(r13), r13
	add	r13, r12
	mov	852(r1), r13
	add	r13, r12
	mov	858(r1), r13
	add	r13, r12
	mov.b	842(r1), r15
	cmp.b	#0, r15
	mov	r12, 2(r1)                      ; 2-byte Folded Spill
	mov.b	r15, 1(r1)                      ; 1-byte Folded Spill
	jeq	.LBB2_29
.LBB2_28:                               ; %for.end.i
                                        ;   Parent Loop BB2_5 Depth=1
                                        ;     Parent Loop BB2_8 Depth=2
                                        ; =>    This Inner Loop Header: Depth=3
	mov.b	1(r1), r12                      ; 1-byte Folded Reload
	mov	2(r1), r13                      ; 2-byte Folded Reload
	rra	r13
	sub.b	#1, r12
	mov.b	r12, 1(r1)                      ; 1-byte Folded Spill
	mov	r13, 2(r1)                      ; 2-byte Folded Spill
	jne	.LBB2_28
.LBB2_29:                               ; %for.end.i
                                        ;   in Loop: Header=BB2_8 Depth=2
	mov	2(r1), r12                      ; 2-byte Folded Reload
	mov	878(r1), r13
	mov	846(r1), r14
	add	r14, r14
	add	r13, r14
	mov	r12, 2(r14)
	mov	850(r1), r12
	inc	r12
	mov	r12, 850(r1)
	mov	840(r1), r12
	mov	878(r1), r13
	add	r12, r12
	add	r12, r13
	mov	r13, 878(r1)
	br	#.LBB2_8
.LBB2_30:                               ; %for.end147.i
                                        ;   in Loop: Header=BB2_5 Depth=1
	mov	846(r1), r12
	add	#7, r12
	mov	r12, 846(r1)
	mov	844(r1), r12
	add	#3, r12
	mov	r12, 844(r1)
	mov	842(r1), r12
	add	#3, r12
	mov	r12, 842(r1)
	mov	840(r1), r12
	add	#-7, r12
	mov	r12, 840(r1)
	mov	878(r1), r12
	add	#-128, r12
	mov	r12, 878(r1)
	br	#.LBB2_5
.LBB2_31:                               ; %jpegdct.exit
	mov	846(r1), r12
	mov	848(r1), r13
	add	r13, r12
	mov	850(r1), r13
	add	r13, r12
	mov	r12, 36(r1)
	mov	36(r1), r12
	add	#880, r1
	pop	r10
	ret
.Lfunc_end2:
	.size	main_jpeg_cosine_transform, .Lfunc_end2-main_jpeg_cosine_transform
                                        ; -- End function
	.ident	"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"
	.section	".note.GNU-stack","",@progbits
