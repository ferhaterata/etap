	.text
	.file	"lattice.c"
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
	.globl	main_lattice_synthesis          ; -- Begin function main_lattice_synthesis
	.p2align	1
	.type	main_lattice_synthesis,@function
main_lattice_synthesis:                 ; @main_lattice_synthesis
; %bb.0:                                ; %entry
	push	r10
	push	r9
	push	r8
	sub	#822, r1
	clr	4(r1)
	jmp	.LBB2_1
.LBB2_1:                                ; %for.cond
                                        ; =>This Inner Loop Header: Depth=1
	mov	4(r1), r12
	cmp	#200, r12
	jge	.LBB2_4
	jmp	.LBB2_2
.LBB2_2:                                ; %for.body
                                        ;   in Loop: Header=BB2_1 Depth=1
	mov	4(r1), r12
	add	r12, r12
	mov	r1, r13
	add	#406, r13
	mov	r13, r14
	add	r12, r14
	clr	0(r14)
	mov	4(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#2047, 2(r12)
	mov	4(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#3072, 4(r12)
	mov	4(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#2048, 6(r12)
	mov	4(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#512, 8(r12)
	mov	4(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#-2048, 10(r12)
	mov	4(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#-3328, 12(r12)
	mov	4(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#1024, 14(r12)
	mov	4(r1), r12
	add	r12, r12
	mov	r1, r13
	add	#6, r13
	mov	r13, r14
	add	r12, r14
	mov	#3168, 0(r14)
	mov	4(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#3136, 2(r12)
	mov	4(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#3104, 4(r12)
	mov	4(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#3072, 6(r12)
	mov	4(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#-2560, 8(r12)
	mov	4(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#-3072, 10(r12)
	mov	4(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#-3584, 12(r12)
	mov	4(r1), r12
	add	r12, r12
	add	r13, r12
	mov	#-4096, 14(r12)
	jmp	.LBB2_3
.LBB2_3:                                ; %for.inc
                                        ;   in Loop: Header=BB2_1 Depth=1
	mov	4(r1), r12
	add	#8, r12
	mov	r12, 4(r1)
	jmp	.LBB2_1
.LBB2_4:                                ; %for.end
	clr	2(r1)
	mov	#-21846, 0(r1)
	mov	0(r1), r12
	mov	2(r1), r13
	mov	r1, r14
	add	#406, r14
	mov	r14, 820(r1)
	mov	r1, r14
	add	#6, r14
	mov	r14, 818(r1)
	clr	816(r1)
	mov	#100, 814(r1)
	mov	r13, 812(r1)
	mov	r12, 810(r1)
	mov	820(r1), r12
	mov	814(r1), r13
	add	r13, r13
	add	#-2, r13
	add	r13, r12
	mov	0(r12), r12
	mov	818(r1), r14
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
	mov	812(r1), r14
	mov	810(r1), r15
	cmp	r12, r15
	mov	r2, r11
	mov	#1, r10
	mov	r10, r9
	bic	r11, r9
	sub	r13, r14
	sub	r9, r14
	sub	r12, r15
	mov	r15, 810(r1)
	mov	r14, 812(r1)
	mov	816(r1), r12
	mov	814(r1), r13
	mov	r13, r14
	add	#-2, r14
	cmp	r13, r14
	mov	r2, r13
	bic	r13, r10
	add	r10, r12
	add	#-1, r12
	mov	r14, 806(r1)
	mov	r12, 808(r1)
	jmp	.LBB2_5
.LBB2_5:                                ; %for.cond.i
                                        ; =>This Inner Loop Header: Depth=1
	mov	808(r1), r12
	tst	r12
	jl	.LBB2_7
	jmp	.LBB2_6
.LBB2_6:                                ; %for.body.i
                                        ;   in Loop: Header=BB2_5 Depth=1
	call	#checkpoint
	mov	820(r1), r12
	mov	806(r1), r13
	add	r13, r13
	add	r13, r12
	mov	0(r12), r12
	mov	818(r1), r14
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
	mov	812(r1), r14
	mov	810(r1), r15
	cmp	r12, r15
	mov	r2, r11
	mov	#1, r10
	mov	r10, r9
	bic	r11, r9
	sub	r13, r14
	sub	r9, r14
	sub	r12, r15
	mov	r15, 810(r1)
	mov	r14, 812(r1)
	mov	820(r1), r12
	mov	806(r1), r13
	add	r13, r13
	add	r13, r12
	mov	0(r12), r14
	mov	818(r1), r15
	add	r13, r15
	mov	0(r15), r13
	mov	r13, r15
	swpb	r15
	sxt	r15
	rra	r15
	rra	r15
	rra	r15
	rra	r15
	rra	r15
	rra	r15
	rra	r15
	mov	812(r1), r11
	mov	r11, r9
	swpb	r9
	sxt	r9
	rra	r9
	rra	r9
	rra	r9
	rra	r9
	rra	r9
	rra	r9
	rra	r9
	mov	r13, r8
	add	r11, r8
	cmp	r13, r8
	mov	r2, r13
	mov	r10, r11
	bic	r13, r11
	add	r9, r15
	add	r11, r15
	add	r15, r14
	mov	r14, 2(r12)
	mov	808(r1), r12
	mov	806(r1), r13
	mov	r13, r14
	add	#-1, r14
	cmp	r13, r14
	mov	r2, r13
	bic	r13, r10
	add	r10, r12
	add	#-1, r12
	mov	r14, 806(r1)
	mov	r12, 808(r1)
	jmp	.LBB2_5
.LBB2_7:                                ; %latsynth.exit
	mov	812(r1), r12
	mov	820(r1), r13
	mov	r12, 0(r13)
	mov	810(r1), r12
	mov	812(r1), r13
	mov	r13, 2(r1)
	mov	r12, 0(r1)
	mov	0(r1), r12
	add	#822, r1
	pop	r8
	pop	r9
	pop	r10
	ret
.Lfunc_end2:
	.size	main_lattice_synthesis, .Lfunc_end2-main_lattice_synthesis
                                        ; -- End function
	.ident	"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"
	.section	".note.GNU-stack","",@progbits
