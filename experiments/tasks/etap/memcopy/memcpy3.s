	.text
	.file	"memcpy3.c"
	.globl	func3                           ; -- Begin function func3
	.p2align	1
	.type	func3,@function
func3:                                  ; @func3
; %bb.0:                                ; %entry
	sub	#62, r1
	mov	#.L__const.func3.arr3, r13
	mov	r1, r12
	add	#2, r12
	mov	#60, r14
	call	#memcpy
	clr	r13
	mov	r12, 0(r1)                      ; 2-byte Folded Spill
	mov	r13, r12
	add	#62, r1
	ret
.Lfunc_end0:
	.size	func3, .Lfunc_end0-func3
                                        ; -- End function
	.type	.L__const.func3.arr3,@object    ; @__const.func3.arr3
	.section	.rodata,"a",@progbits
	.p2align	1
.L__const.func3.arr3:
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
	.short	512                             ; 0x200
	.short	63488                           ; 0xf800
	.short	62208                           ; 0xf300
	.short	1024                            ; 0x400
	.short	0                               ; 0x0
	.short	2047                            ; 0x7ff
	.size	.L__const.func3.arr3, 60

	.ident	"clang version 12.0.0 (https://github.com/llvm/llvm-project.git 985deba9319be464673c1002767f8a3ec597480d)"
	.section	".note.GNU-stack","",@progbits
