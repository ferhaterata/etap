	.text
	.file	"dotproduct.c"
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
	.globl	main_dot_product                ; -- Begin function main_dot_product
	.p2align	1
	.type	main_dot_product,@function
main_dot_product:                       ; @main_dot_product
; %bb.0:                                ; %entry
	push	r10
	sub	#1638, r1
	clr	18(r1)
	jmp	.LBB2_1
.LBB2_1:                                ; %for.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov	18(r1), r12
	cmp	#200, r12
	jge	.LBB2_4
	jmp	.LBB2_2
.LBB2_2:                                ; %for.body
                                        ;   in Loop: Header=BB2_1 Depth=1
	call	#checkpoint
	mov	18(r1), r12
	add	r12, r12
	mov	r1, r13
	add	#1220, r13
	mov	r13, r14
	add	r12, r14
	clr	0(r14)
	mov	18(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#2047, 2(r12)
	mov	18(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#3072, 4(r12)
	mov	18(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#2048, 6(r12)
	mov	18(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#512, 8(r12)
	mov	18(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#-2048, 10(r12)
	mov	18(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#-3328, 12(r12)
	mov	18(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#1024, 14(r12)
	mov	18(r1), r12
	add	r12, r12
	mov	r1, r13
	add	#820, r13
	mov	r13, r14
	add	r12, r14
	mov	#3168, 0(r14)
	mov	18(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#3136, 2(r12)
	mov	18(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#3104, 4(r12)
	mov	18(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#3072, 6(r12)
	mov	18(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#-2560, 8(r12)
	mov	18(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#-3072, 10(r12)
	mov	18(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#-3584, 12(r12)
	mov	18(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#-4096, 14(r12)
	jmp	.LBB2_3
.LBB2_3:                                ; %for.inc
                                        ;   in Loop: Header=BB2_1 Depth=1
	mov	18(r1), r12
	add	#8, r12
	mov	r12, 18(r1)
	jmp	.LBB2_1
.LBB2_4:                                ; %for.end
	mov	#3, 14(r1)
	clr	12(r1)
	jmp	.LBB2_5
.LBB2_5:                                ; %for.cond31
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB2_7 Depth 2
	mov	12(r1), r12
	cmp	#5, r12
	jge	.LBB2_15
	jmp	.LBB2_6
.LBB2_6:                                ; %for.body33
                                        ;   in Loop: Header=BB2_5 Depth=1
	call	#checkpoint
	mov	r1, r12
	add	#1220, r12
	mov	r12, 1636(r1)
	mov	r1, r12
	add	#820, r12
	mov	r12, 1634(r1)
	clr	1632(r1)
	mov	#3, 1630(r1)
	mov	r1, r12
	add	#20, r12
	mov	r12, 1628(r1)
	mov	1628(r1), r12
	mov	0(r12), r13
	mov	2(r12), r12
	mov	r12, 1622(r1)
	mov	r13, 1620(r1)
	clr	1626(r1)
	clr	1624(r1)
	jmp	.LBB2_7
.LBB2_7:                                ; %for.cond.i
                                        ;   Parent Loop BB2_5 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	mov	1624(r1), r12
	mov	1626(r1), r13
	clr	r14
	mov	#1, r15
	cmp	#1, r13
	mov	r12, 10(r1)                     ; 2-byte Folded Spill
	mov	r13, 8(r1)                      ; 2-byte Folded Spill
	mov	r14, 6(r1)                      ; 2-byte Folded Spill
	mov	r15, 4(r1)                      ; 2-byte Folded Spill
	jge	.LBB2_9
; %bb.8:                                ; %for.cond.i
                                        ;   in Loop: Header=BB2_7 Depth=2
	mov	6(r1), r12                      ; 2-byte Folded Reload
	mov	r12, 4(r1)                      ; 2-byte Folded Spill
.LBB2_9:                                ; %for.cond.i
                                        ;   in Loop: Header=BB2_7 Depth=2
	mov	4(r1), r12                      ; 2-byte Folded Reload
	mov	10(r1), r13                     ; 2-byte Folded Reload
	cmp	#150, r13
	mov	r2, r13
	and	#1, r13
	mov	8(r1), r14                      ; 2-byte Folded Reload
	tst	r14
	mov	r12, 2(r1)                      ; 2-byte Folded Spill
	mov	r13, 0(r1)                      ; 2-byte Folded Spill
	jeq	.LBB2_11
; %bb.10:                               ; %for.cond.i
                                        ;   in Loop: Header=BB2_7 Depth=2
	mov	2(r1), r12                      ; 2-byte Folded Reload
	mov	r12, 0(r1)                      ; 2-byte Folded Spill
.LBB2_11:                               ; %for.cond.i
                                        ;   in Loop: Header=BB2_7 Depth=2
	mov	0(r1), r12                      ; 2-byte Folded Reload
	bit	#1, r12
	jne	.LBB2_13
	jmp	.LBB2_12
.LBB2_12:                               ; %for.body.i
                                        ;   in Loop: Header=BB2_7 Depth=2
	mov	1634(r1), r12
	mov	1624(r1), r13
	add	r13, r13
	add	r13, r12
	mov	0(r12), r12
	mov	1636(r1), r14
	add	r13, r14
	mov	0(r14), r13
	add	r13, r12
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
	mov	1622(r1), r14
	mov	1620(r1), r15
	mov	r15, r11
	add	r12, r11
	cmp	r15, r11
	mov	r2, r12
	mov	#1, r15
	mov	r15, r10
	bic	r12, r10
	add	r13, r14
	add	r10, r14
	mov	r11, 1620(r1)
	mov	r14, 1622(r1)
	mov	1634(r1), r12
	mov	1624(r1), r13
	add	r13, r13
	add	r13, r12
	mov	0(r12), r12
	add	r12, r12
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
	mov	1632(r1), r14
	mov	1630(r1), r11
	mov	r11, r10
	add	r12, r10
	cmp	r11, r10
	mov	r2, r12
	mov	r15, r11
	bic	r12, r11
	add	r13, r14
	add	r11, r14
	mov	r10, 1630(r1)
	mov	r14, 1632(r1)
	mov	1626(r1), r12
	mov	1624(r1), r13
	mov	r13, r14
	inc	r14
	cmp	r13, r14
	mov	r2, r13
	bic	r13, r15
	add	r15, r12
	mov	r14, 1624(r1)
	mov	r12, 1626(r1)
	jmp	.LBB2_7
.LBB2_13:                               ; %mac.exit
                                        ;   in Loop: Header=BB2_5 Depth=1
	mov	1620(r1), r12
	mov	1622(r1), r13
	mov	1628(r1), r14
	mov	r13, 2(r14)
	mov	r12, 0(r14)
	mov	1630(r1), r12
	mov	r12, 16(r1)
	jmp	.LBB2_14
.LBB2_14:                               ; %for.inc36
                                        ;   in Loop: Header=BB2_5 Depth=1
	mov	12(r1), r12
	inc	r12
	mov	r12, 12(r1)
	jmp	.LBB2_5
.LBB2_15:                               ; %for.end37
	mov	16(r1), r12
	add	#1638, r1
	pop	r10
	ret
.Lfunc_end2:
	.size	main_dot_product, .Lfunc_end2-main_dot_product
                                        ; -- End function
	.ident	"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"
	.section	".note.GNU-stack","",@progbits
