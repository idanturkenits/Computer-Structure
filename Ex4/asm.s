	.file	"code.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"the result is %d"
	.text
	.p2align 4
	.globl	arith
	.type	arith, @function
arith:
.LFB34:
	.cfi_startproc
	endbr64
	movl	%edx, %r8d
	leal	(%rdi,%rsi), %edx
	xorl	%eax, %eax
	movl	$1, %edi
	imull	%r8d, %edx
	leaq	.LC0(%rip), %rsi
	leal	(%rdx,%rdx,2), %edx
	sall	$4, %edx
	jmp	__printf_chk@PLT
	.cfi_endproc
.LFE34:
	.size	arith, .-arith
	.section	.rodata.str1.1
.LC1:
	.string	"The new string is %s"
	.text
	.p2align 4
	.globl	lower
	.type	lower, @function
lower:
.LFB35:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	movq	%rdi, %r12
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	xorl	%ebx, %ebx
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	call	strlen@PLT
	jmp	.L4
	.p2align 4,,10
	.p2align 3
.L6:
	movzbl	(%r12,%rbx), %ecx
	leal	-65(%rcx), %edx
	cmpb	$25, %dl
	ja	.L5
	addl	$32, %ecx
	movq	%r12, %rdi
	movb	%cl, (%r12,%rbx)
	call	strlen@PLT
.L5:
	addq	$1, %rbx
.L4:
	cmpq	%rax, %rbx
	jb	.L6
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	movq	%r12, %rdx
	leaq	.LC1(%rip), %rsi
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 16
	movl	$1, %edi
	popq	%r12
	.cfi_def_cfa_offset 8
	jmp	__printf_chk@PLT
	.cfi_endproc
.LFE35:
	.size	lower, .-lower
	.p2align 4
	.globl	sumAndSave
	.type	sumAndSave, @function
sumAndSave:
.LFB36:
	.cfi_startproc
	endbr64
	testl	%esi, %esi
	jle	.L11
	leal	-1(%rsi), %ecx
	movl	(%rdx), %eax
	leaq	4(%rdi,%rcx,4), %rcx
	.p2align 4,,10
	.p2align 3
.L10:
	addl	(%rdi), %eax
	addq	$4, %rdi
	movl	%eax, (%rdx)
	cmpq	%rcx, %rdi
	jne	.L10
.L11:
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE36:
	.size	sumAndSave, .-sumAndSave
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB37:
	.cfi_startproc
	endbr64
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE37:
	.size	main, .-main
	.globl	d
	.data
	.align 8
	.type	d, @object
	.size	d, 8
d:
	.long	2405181686
	.long	1076786626
	.globl	c
	.type	c, @object
	.size	c, 1
c:
	.byte	97
	.globl	x
	.align 4
	.type	x, @object
	.size	x, 4
x:
	.long	100
	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
