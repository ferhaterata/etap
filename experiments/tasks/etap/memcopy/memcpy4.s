	.text
	.file	"memcpy4.c"
	.globl	func4                           ; -- Begin function func4
	.p2align	1
	.type	func4,@function
func4:                                  ; @func4
; %bb.0:                                ; %entry
	sub	#82, r1
	mov	#.L__const.func4.arr4, r13
	mov	r1, r12
	add	#2, r12
	mov	#80, r14
	call	#memcpy
	clr	r13
	mov	r12, 0(r1)                      ; 2-byte Folded Spill
	mov	r13, r12
	add	#82, r1
	ret
.Lfunc_end0:
	.size	func4, .Lfunc_end0-func4
                                        ; -- End function
	.type	.L__const.func4.arr4,@object    ; @__const.func4.arr4
	.section	.rodata,"a",@progbits
	.p2align	1
.L__const.func4.arr4:
	.short	0                               ; 0x0
	.short	2047                            ; 0x7ff
	.short	3072                            ; 0xc00
	.short	2048                            ; 0x800
	.short	512                             ; 0x200
	.short	63488                           ; 0xf800
	.short	62208                           ; 0xf300
	.short	1024                            ; 0x400
	.short	0                               ; 0x0
	.short	2047                            ; 0x7ff
	.short	3072                            ; 0xc00
	.short	2048                            ; 0x800
	.short	512                             ; 0x200
	.short	63488                           ; 0xf800
	.short	62208                           ; 0xf300
	.short	1024                            ; 0x400
	.short	0                               ; 0x0
	.short	2047                            ; 0x7ff
	.short	3072                            ; 0xc00
	.short	2048                            ; 0x800
	.short	0                               ; 0x0
	.short	2047                            ; 0x7ff
	.short	3072                            ; 0xc00
	.short	2048                            ; 0x800
	.short	0                               ; 0x0
	.short	2047                            ; 0x7ff
	.short	3072                            ; 0xc00
	.short	2048                            ; 0x800
	.short	512                             ; 0x200
	.short	63488                           ; 0xf800
	.short	62208                           ; 0xf300
	.short	1024                            ; 0x400
	.short	0                               ; 0x0
	.short	2047                            ; 0x7ff
	.short	3072                            ; 0xc00
	.short	2048                            ; 0x800
	.short	512                             ; 0x200
	.short	63488                           ; 0xf800
	.short	62208                           ; 0xf300
	.short	1024                            ; 0x400
	.size	.L__const.func4.arr4, 80

	.ident	"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"
	.section	".note.GNU-stack","",@progbits
