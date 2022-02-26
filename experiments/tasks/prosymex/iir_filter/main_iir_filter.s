	.text
	.file	"iirfilter.c"
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
	.globl	main_iir_filter                 ; -- Begin function main_iir_filter
	.p2align	1
	.type	main_iir_filter,@function
main_iir_filter:                        ; @main_iir_filter
; %bb.0:                                ; %entry
	push	r10
	push	r9
	push	r8
	push	r7
	push	r6
	sub	#1638, r1
	clr	16(r1)
	jmp	.LBB2_1
.LBB2_1:                                ; %for.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov	16(r1), r12
	cmp	#200, r12
	jge	.LBB2_4
	jmp	.LBB2_2
.LBB2_2:                                ; %for.body
                                        ;   in Loop: Header=BB2_1 Depth=1
	mov	16(r1), r12
	add	r12, r12
	mov	r1, r13
	add	#1218, r13
	mov	r13, r14
	add	r12, r14
	clr	0(r14)
	mov	16(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#2047, 2(r12)
	mov	16(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#3072, 4(r12)
	mov	16(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#2048, 6(r12)
	mov	16(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#512, 8(r12)
	mov	16(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#-2048, 10(r12)
	mov	16(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#-3328, 12(r12)
	mov	16(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#1024, 14(r12)
	mov	16(r1), r12
	add	r12, r12
	mov	r1, r13
	add	#818, r13
	mov	r13, r14
	add	r12, r14
	mov	#3168, 0(r14)
	mov	16(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#3136, 2(r12)
	mov	16(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#3104, 4(r12)
	mov	16(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#3072, 6(r12)
	mov	16(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#-2560, 8(r12)
	mov	16(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#-3072, 10(r12)
	mov	16(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#-3584, 12(r12)
	mov	16(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#-4096, 14(r12)
	mov	16(r1), r12
	add	r12, r12
	add	r12, r12
	mov	r1, r13
	add	#18, r13
	mov	r13, r14
	add	r12, r14
	clr	2(r14)
	clr	0(r14)
	mov	16(r1), r12
	add	r12, r12
	add	r12, r12
	add	r13, r12
	clr	6(r12)
	clr	4(r12)
	mov	16(r1), r12
	add	r12, r12
	add	r12, r12
	add	r13, r12
	clr	10(r12)
	clr	8(r12)
	mov	16(r1), r12
	add	r12, r12
	add	r12, r12
	add	r13, r12
	clr	14(r12)
	clr	12(r12)
	mov	16(r1), r12
	add	r12, r12
	add	r12, r12
	add	r13, r12
	clr	18(r12)
	clr	16(r12)
	mov	16(r1), r12
	add	r12, r12
	add	r12, r12
	add	r13, r12
	clr	22(r12)
	clr	20(r12)
	mov	16(r1), r12
	add	r12, r12
	add	r12, r12
	add	r13, r12
	clr	26(r12)
	clr	24(r12)
	mov	16(r1), r12
	add	r12, r12
	add	r12, r12
	add	r13, r12
	clr	30(r12)
	clr	28(r12)
	jmp	.LBB2_3
.LBB2_3:                                ; %for.inc
                                        ;   in Loop: Header=BB2_1 Depth=1
	mov	16(r1), r12
	add	#8, r12
	mov	r12, 16(r1)
	jmp	.LBB2_1
.LBB2_4:                                ; %for.end
	mov	r1, r12
	add	#18, r12
	mov	r12, r13
	add	#400, r13
	mov	r1, r14
	add	#1218, r14
	mov	r14, 1636(r1)
	mov	r1, r14
	add	#818, r14
	mov	r14, 1634(r1)
	mov	r13, 1632(r1)
	mov	r12, 1630(r1)
	mov	1634(r1), r12
	mov	0(r12), r12
	mov	r12, r13
	swpb	r13
	sxt	r13
	rra	r13
	rra	r13
	rra	r13
	rra	r13
	rra	r13
	rra	r13
	rra	r13
	mov	r12, 1626(r1)
	mov	r13, 1628(r1)
	clr	1620(r1)
	clr	1618(r1)
	jmp	.LBB2_5
.LBB2_5:                                ; %for.cond.i
                                        ; =>This Inner Loop Header: Depth=1
	mov	1618(r1), r12
	mov	1620(r1), r13
	clr	r14
	mov	#1, r15
	cmp	#1, r13
	mov	r12, 10(r1)                     ; 2-byte Folded Spill
	mov	r13, 8(r1)                      ; 2-byte Folded Spill
	mov	r14, 6(r1)                      ; 2-byte Folded Spill
	mov	r15, 4(r1)                      ; 2-byte Folded Spill
	jge	.LBB2_7
; %bb.6:                                ; %for.cond.i
                                        ;   in Loop: Header=BB2_5 Depth=1
	mov	6(r1), r12                      ; 2-byte Folded Reload
	mov	r12, 4(r1)                      ; 2-byte Folded Spill
.LBB2_7:                                ; %for.cond.i
                                        ;   in Loop: Header=BB2_5 Depth=1
	mov	4(r1), r12                      ; 2-byte Folded Reload
	mov	10(r1), r13                     ; 2-byte Folded Reload
	cmp	#50, r13
	mov	r2, r13
	and	#1, r13
	mov	8(r1), r14                      ; 2-byte Folded Reload
	tst	r14
	mov	r12, 2(r1)                      ; 2-byte Folded Spill
	mov	r13, 0(r1)                      ; 2-byte Folded Spill
	jeq	.LBB2_9
; %bb.8:                                ; %for.cond.i
                                        ;   in Loop: Header=BB2_5 Depth=1
	mov	2(r1), r12                      ; 2-byte Folded Reload
	mov	r12, 0(r1)                      ; 2-byte Folded Spill
.LBB2_9:                                ; %for.cond.i
                                        ;   in Loop: Header=BB2_5 Depth=1
	mov	0(r1), r12                      ; 2-byte Folded Reload
	bit	#1, r12
	jne	.LBB2_11
	jmp	.LBB2_10
.LBB2_10:                               ; %for.body.i
                                        ;   in Loop: Header=BB2_5 Depth=1
	call	#checkpoint
	mov	1628(r1), r12
	mov	1626(r1), r13
	mov	1636(r1), r14
	mov	4(r14), r15
	mov	r15, r11
	swpb	r11
	sxt	r11
	rra	r11
	rra	r11
	rra	r11
	rra	r11
	rra	r11
	rra	r11
	rra	r11
	mov	1630(r1), r10
	mov	2(r10), r9
	mov	0(r10), r8
	mov	r15, r7
	add	r8, r7
	cmp	r15, r7
	mov	r2, r15
	mov	#1, r8
	mov	r8, r6
	bic	r15, r6
	add	r9, r11
	add	r6, r11
	mov	6(r14), r14
	mov	r14, r15
	swpb	r15
	sxt	r15
	rra	r15
	rra	r15
	rra	r15
	rra	r15
	rra	r15
	rra	r15
	rra	r15
	mov	r7, r9
	add	r14, r9
	cmp	r7, r9
	mov	r2, r14
	mov	r8, r7
	bic	r14, r7
	add	r15, r11
	add	r7, r11
	mov	4(r10), r14
	mov	6(r10), r15
	add	r15, r11
	mov	r9, r15
	add	r14, r15
	cmp	r9, r15
	mov	r2, r14
	mov	r8, r10
	bic	r14, r10
	add	r10, r11
	mov	r11, r14
	swpb	r14
	sxt	r14
	rra	r14
	rra	r14
	rra	r14
	rra	r14
	rra	r14
	rra	r14
	rra	r14
	add	r11, r11
	swpb	r15
	mov.b	r15, r15
	clrc
	rrc	r15
	rra	r15
	rra	r15
	rra	r15
	rra	r15
	rra	r15
	rra	r15
	bis	r11, r15
	mov	r13, r11
	add	r15, r11
	cmp	r13, r11
	mov	r2, r13
	mov	r8, r15
	bic	r13, r15
	add	r14, r12
	add	r15, r12
	mov	r11, 1622(r1)
	mov	r12, 1624(r1)
	mov	1624(r1), r12
	mov	1622(r1), r13
	mov	1636(r1), r14
	mov	0(r14), r15
	mov	r15, r11
	swpb	r11
	sxt	r11
	rra	r11
	rra	r11
	rra	r11
	rra	r11
	rra	r11
	rra	r11
	rra	r11
	mov	1630(r1), r10
	mov	2(r10), r9
	mov	0(r10), r7
	mov	r15, r6
	add	r7, r6
	cmp	r15, r6
	mov	r2, r15
	mov	r8, r7
	bic	r15, r7
	add	r9, r11
	add	r7, r11
	mov	2(r14), r14
	mov	r14, r15
	swpb	r15
	sxt	r15
	rra	r15
	rra	r15
	rra	r15
	rra	r15
	rra	r15
	rra	r15
	rra	r15
	mov	r6, r9
	add	r14, r9
	cmp	r6, r9
	mov	r2, r14
	mov	r8, r7
	bic	r14, r7
	add	r15, r11
	add	r7, r11
	mov	4(r10), r14
	mov	6(r10), r15
	add	r15, r11
	mov	r9, r15
	add	r14, r15
	cmp	r9, r15
	mov	r2, r14
	mov	r8, r10
	bic	r14, r10
	add	r10, r11
	mov	r11, r14
	swpb	r14
	sxt	r14
	rra	r14
	rra	r14
	rra	r14
	rra	r14
	rra	r14
	rra	r14
	rra	r14
	add	r11, r11
	swpb	r15
	mov.b	r15, r15
	clrc
	rrc	r15
	rra	r15
	rra	r15
	rra	r15
	rra	r15
	rra	r15
	rra	r15
	bis	r11, r15
	mov	r13, r11
	add	r15, r11
	cmp	r13, r11
	mov	r2, r13
	mov	r8, r15
	bic	r13, r15
	add	r14, r12
	add	r15, r12
	mov	r11, 1626(r1)
	mov	r12, 1628(r1)
	mov	1630(r1), r12
	mov	0(r12), r13
	mov	2(r12), r14
	mov	r14, 6(r12)
	mov	r13, 4(r12)
	mov	1622(r1), r12
	mov	1624(r1), r13
	mov	1630(r1), r14
	mov	r13, 2(r14)
	mov	r12, 0(r14)
	mov	1636(r1), r12
	add	#8, r12
	mov	r12, 1636(r1)
	mov	1630(r1), r12
	add	#8, r12
	mov	r12, 1630(r1)
	mov	1620(r1), r12
	mov	1618(r1), r13
	mov	r13, r14
	inc	r14
	cmp	r13, r14
	mov	r2, r13
	bic	r13, r8
	add	r8, r12
	mov	r14, 1618(r1)
	mov	r12, 1620(r1)
	jmp	.LBB2_5
.LBB2_11:                               ; %iir1.exit
	mov	1626(r1), r12
	mov	1628(r1), r13
	mov	1632(r1), r14
	mov	r14, r15
	add	#4, r15
	mov	r15, 1632(r1)
	mov	r13, 2(r14)
	mov	r12, 0(r14)
	mov	1622(r1), r12
	mov	1624(r1), r13
	mov	r13, 14(r1)
	mov	r12, 12(r1)
	mov	12(r1), r12
	add	#1638, r1
	pop	r6
	pop	r7
	pop	r8
	pop	r9
	pop	r10
	ret
.Lfunc_end2:
	.size	main_iir_filter, .Lfunc_end2-main_iir_filter
                                        ; -- End function
	.ident	"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"
	.section	".note.GNU-stack","",@progbits
