	.text
	.file	"firfilter.c"
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
	.globl	main_fir_filter                 ; -- Begin function main_fir_filter
	.p2align	1
	.type	main_fir_filter,@function
main_fir_filter:                        ; @main_fir_filter
; %bb.0:                                ; %entry
	push	r10
	sub	#1648, r1
	clr	28(r1)
	jmp	.LBB2_1
.LBB2_1:                                ; %for.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov	28(r1), r12
	cmp	#200, r12
	jge	.LBB2_4
	jmp	.LBB2_2
.LBB2_2:                                ; %for.body
                                        ;   in Loop: Header=BB2_1 Depth=1
	mov	28(r1), r12
	add	r12, r12
	mov	r1, r13
	add	#1230, r13
	mov	r13, r14
	add	r12, r14
	clr	0(r14)
	mov	28(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#2047, 2(r12)
	mov	28(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#3072, 4(r12)
	mov	28(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#2048, 6(r12)
	mov	28(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#512, 8(r12)
	mov	28(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#-2048, 10(r12)
	mov	28(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#-3328, 12(r12)
	mov	28(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#1024, 14(r12)
	mov	28(r1), r12
	add	r12, r12
	mov	r1, r13
	add	#830, r13
	mov	r13, r14
	add	r12, r14
	mov	#3168, 0(r14)
	mov	28(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#3136, 2(r12)
	mov	28(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#3104, 4(r12)
	mov	28(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#3072, 6(r12)
	mov	28(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#-2560, 8(r12)
	mov	28(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#-3072, 10(r12)
	mov	28(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#-3584, 12(r12)
	mov	28(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#-4096, 14(r12)
	jmp	.LBB2_3
.LBB2_3:                                ; %for.inc
                                        ;   in Loop: Header=BB2_1 Depth=1
	mov	28(r1), r12
	add	#8, r12
	mov	r12, 28(r1)
	jmp	.LBB2_1
.LBB2_4:                                ; %for.end
	mov	r1, r12
	add	#1230, r12
	mov	r12, 1646(r1)
	mov	r1, r12
	add	#830, r12
	mov	r12, 1644(r1)
	mov	r1, r12
	add	#30, r12
	mov	r12, 1642(r1)
	clr	1640(r1)
	clr	1638(r1)
	jmp	.LBB2_5
.LBB2_5:                                ; %for.cond.i
                                        ; =>This Loop Header: Depth=1
                                        ;     Child Loop BB2_11 Depth 2
	mov	1638(r1), r12
	mov	1640(r1), r13
	clr	r14
	mov	#1, r15
	cmp	#1, r13
	mov	r12, 22(r1)                     ; 2-byte Folded Spill
	mov	r13, 20(r1)                     ; 2-byte Folded Spill
	mov	r14, 18(r1)                     ; 2-byte Folded Spill
	mov	r15, 16(r1)                     ; 2-byte Folded Spill
	jge	.LBB2_7
; %bb.6:                                ; %for.cond.i
                                        ;   in Loop: Header=BB2_5 Depth=1
	mov	18(r1), r12                     ; 2-byte Folded Reload
	mov	r12, 16(r1)                     ; 2-byte Folded Spill
.LBB2_7:                                ; %for.cond.i
                                        ;   in Loop: Header=BB2_5 Depth=1
	mov	16(r1), r12                     ; 2-byte Folded Reload
	mov	22(r1), r13                     ; 2-byte Folded Reload
	cmp	#50, r13
	mov	r2, r13
	and	#1, r13
	mov	20(r1), r14                     ; 2-byte Folded Reload
	tst	r14
	mov	r12, 14(r1)                     ; 2-byte Folded Spill
	mov	r13, 12(r1)                     ; 2-byte Folded Spill
	jeq	.LBB2_9
; %bb.8:                                ; %for.cond.i
                                        ;   in Loop: Header=BB2_5 Depth=1
	mov	14(r1), r12                     ; 2-byte Folded Reload
	mov	r12, 12(r1)                     ; 2-byte Folded Spill
.LBB2_9:                                ; %for.cond.i
                                        ;   in Loop: Header=BB2_5 Depth=1
	mov	12(r1), r12                     ; 2-byte Folded Reload
	bit	#1, r12
	jne	.LBB2_18
	jmp	.LBB2_10
.LBB2_10:                               ; %for.body.i
                                        ;   in Loop: Header=BB2_5 Depth=1
	call	#checkpoint
	clr	1632(r1)
	clr	1630(r1)
	clr	1636(r1)
	clr	1634(r1)
	jmp	.LBB2_11
.LBB2_11:                               ; %for.cond1.i
                                        ;   Parent Loop BB2_5 Depth=1
                                        ; =>  This Inner Loop Header: Depth=2
	mov	1634(r1), r12
	mov	1636(r1), r13
	clr	r14
	mov	#1, r15
	cmp	#1, r13
	mov	r12, 10(r1)                     ; 2-byte Folded Spill
	mov	r13, 8(r1)                      ; 2-byte Folded Spill
	mov	r14, 6(r1)                      ; 2-byte Folded Spill
	mov	r15, 4(r1)                      ; 2-byte Folded Spill
	jge	.LBB2_13
; %bb.12:                               ; %for.cond1.i
                                        ;   in Loop: Header=BB2_11 Depth=2
	mov	6(r1), r12                      ; 2-byte Folded Reload
	mov	r12, 4(r1)                      ; 2-byte Folded Spill
.LBB2_13:                               ; %for.cond1.i
                                        ;   in Loop: Header=BB2_11 Depth=2
	mov	4(r1), r12                      ; 2-byte Folded Reload
	mov	10(r1), r13                     ; 2-byte Folded Reload
	cmp	#50, r13
	mov	r2, r13
	and	#1, r13
	mov	8(r1), r14                      ; 2-byte Folded Reload
	tst	r14
	mov	r12, 2(r1)                      ; 2-byte Folded Spill
	mov	r13, 0(r1)                      ; 2-byte Folded Spill
	jeq	.LBB2_15
; %bb.14:                               ; %for.cond1.i
                                        ;   in Loop: Header=BB2_11 Depth=2
	mov	2(r1), r12                      ; 2-byte Folded Reload
	mov	r12, 0(r1)                      ; 2-byte Folded Spill
.LBB2_15:                               ; %for.cond1.i
                                        ;   in Loop: Header=BB2_11 Depth=2
	mov	0(r1), r12                      ; 2-byte Folded Reload
	bit	#1, r12
	jne	.LBB2_17
	jmp	.LBB2_16
.LBB2_16:                               ; %for.body3.i
                                        ;   in Loop: Header=BB2_11 Depth=2
	mov	1646(r1), r12
	mov	1638(r1), r13
	mov	1634(r1), r14
	add	r14, r13
	add	r13, r13
	add	r13, r12
	mov	0(r12), r12
	mov	1644(r1), r13
	add	r14, r14
	add	r14, r13
	mov	0(r13), r13
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
	mov	1632(r1), r14
	mov	1630(r1), r15
	mov	r15, r11
	add	r12, r11
	cmp	r15, r11
	mov	r2, r12
	mov	#1, r15
	mov	r15, r10
	bic	r12, r10
	add	r13, r14
	add	r10, r14
	mov	r11, 1630(r1)
	mov	r14, 1632(r1)
	mov	1636(r1), r12
	mov	1634(r1), r13
	mov	r13, r14
	inc	r14
	cmp	r13, r14
	mov	r2, r13
	bic	r13, r15
	add	r15, r12
	mov	r14, 1634(r1)
	mov	r12, 1636(r1)
	jmp	.LBB2_11
.LBB2_17:                               ; %for.end.i
                                        ;   in Loop: Header=BB2_5 Depth=1
	mov	1630(r1), r12
	mov	1632(r1), r13
	mov	r13, r14
	add	r14, r14
	swpb	r12
	mov.b	r12, r12
	clrc
	rrc	r12
	rra	r12
	rra	r12
	rra	r12
	rra	r12
	rra	r12
	rra	r12
	bis	r14, r12
	swpb	r13
	sxt	r13
	rra	r13
	rra	r13
	rra	r13
	rra	r13
	rra	r13
	rra	r13
	rra	r13
	mov	1642(r1), r14
	mov	1638(r1), r15
	add	r15, r15
	add	r15, r15
	add	r15, r14
	mov	r13, 2(r14)
	mov	r12, 0(r14)
	mov	1640(r1), r12
	mov	1638(r1), r13
	mov	r13, r14
	inc	r14
	cmp	r13, r14
	mov	r2, r13
	mov	#1, r15
	bic	r13, r15
	add	r15, r12
	mov	r14, 1638(r1)
	mov	r12, 1640(r1)
	jmp	.LBB2_5
.LBB2_18:                               ; %fir.exit
	mov	1630(r1), r12
	mov	1632(r1), r13
	mov	r13, 26(r1)
	mov	r12, 24(r1)
	mov	24(r1), r12
	add	#1648, r1
	pop	r10
	ret
.Lfunc_end2:
	.size	main_fir_filter, .Lfunc_end2-main_fir_filter
                                        ; -- End function
	.ident	"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"
	.section	".note.GNU-stack","",@progbits
