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
	leaq	.LC0(%rip), %rsi
	movl	$1, %edi
	movl	%edx, %eax
	shrl	$31, %eax
	addl	%eax, %edx
	xorl	%eax, %eax
	sarl	%edx
	imull	%r8d, %edx
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
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	call	strlen@PLT
	testq	%rax, %rax
	je	.L4
	xorl	%ebx, %ebx
	.p2align 4,,10
	.p2align 3
.L7:
	movzbl	(%r12,%rbx), %ecx
	leal	-65(%rcx), %edx
	cmpb	$25, %dl
	ja	.L5
	addl	$32, %ecx
	movq	%r12, %rdi
	movb	%cl, (%r12,%rbx)
	addq	$1, %rbx
	call	strlen@PLT
	cmpq	%rax, %rbx
	jb	.L7
.L4:
	addq	$8, %rsp
	.cfi_remember_state
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
	.p2align 4,,10
	.p2align 3
.L5:
	.cfi_restore_state
	addq	$1, %rbx
	cmpq	%rax, %rbx
	jb	.L7
	jmp	.L4
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
	movl	$0, (%rdx)
	testl	%esi, %esi
	jle	.L12
	leal	-1(%rsi), %eax
	leaq	4(%rdi,%rax,4), %rcx
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L14:
	addl	(%rdi), %eax
	addq	$4, %rdi
	movl	%eax, (%rdx)
	cmpq	%rcx, %rdi
	jne	.L14
.L12:
	ret
	.cfi_endproc
.LFE36:
	.size	sumAndSave, .-sumAndSave
	.p2align 4
	.globl	multArrBy2
	.type	multArrBy2, @function
multArrBy2:
.LFB37:
	.cfi_startproc
	endbr64
	testl	%esi, %esi
	jle	.L17
	leal	-1(%rsi), %eax
	cmpl	$2, %eax
	jbe	.L22
	movl	%esi, %edx
	movq	%rdi, %rax
	shrl	$2, %edx
	salq	$4, %rdx
	addq	%rdi, %rdx
	.p2align 4,,10
	.p2align 3
.L20:
	movdqu	(%rax), %xmm0
	addq	$16, %rax
	pslld	$1, %xmm0
	movups	%xmm0, -16(%rax)
	cmpq	%rdx, %rax
	jne	.L20
	movl	%esi, %eax
	andl	$-4, %eax
	testb	$3, %sil
	je	.L24
.L19:
	movslq	%eax, %rdx
	sall	(%rdi,%rdx,4)
	leal	1(%rax), %edx
	cmpl	%edx, %esi
	jle	.L17
	movslq	%edx, %rdx
	addl	$2, %eax
	sall	(%rdi,%rdx,4)
	cmpl	%eax, %esi
	jle	.L17
	cltq
	sall	(%rdi,%rax,4)
.L17:
	ret
	.p2align 4,,10
	.p2align 3
.L24:
	ret
.L22:
	xorl	%eax, %eax
	jmp	.L19
	.cfi_endproc
.LFE37:
	.size	multArrBy2, .-multArrBy2
	.p2align 4
	.globl	returnSumWithBias
	.type	returnSumWithBias, @function
returnSumWithBias:
.LFB38:
	.cfi_startproc
	endbr64
	testl	%esi, %esi
	jle	.L31
	imull	%ecx, %edx
	leal	-1(%rsi), %eax
	cmpl	$2, %eax
	jbe	.L32
	movl	%esi, %r8d
	movd	%edx, %xmm3
	pxor	%xmm0, %xmm0
	movq	%rdi, %rax
	shrl	$2, %r8d
	pshufd	$0, %xmm3, %xmm2
	salq	$4, %r8
	addq	%rdi, %r8
	.p2align 4,,10
	.p2align 3
.L28:
	movdqu	(%rax), %xmm1
	addq	$16, %rax
	paddd	%xmm2, %xmm1
	paddd	%xmm1, %xmm0
	cmpq	%r8, %rax
	jne	.L28
	movdqa	%xmm0, %xmm1
	movl	%esi, %ecx
	psrldq	$8, %xmm1
	andl	$-4, %ecx
	paddd	%xmm1, %xmm0
	movdqa	%xmm0, %xmm1
	psrldq	$4, %xmm1
	paddd	%xmm1, %xmm0
	movd	%xmm0, %eax
	testb	$3, %sil
	je	.L34
.L27:
	movslq	%ecx, %r8
	movl	(%rdi,%r8,4), %r9d
	leal	1(%rcx), %r8d
	addl	%edx, %r9d
	addl	%r9d, %eax
	cmpl	%r8d, %esi
	jle	.L25
	movslq	%r8d, %r8
	addl	$2, %ecx
	movl	(%rdi,%r8,4), %r10d
	addl	%edx, %r10d
	addl	%r10d, %eax
	cmpl	%ecx, %esi
	jle	.L25
	movslq	%ecx, %rcx
	addl	(%rdi,%rcx,4), %edx
	addl	%edx, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L31:
	xorl	%eax, %eax
.L25:
	ret
	.p2align 4,,10
	.p2align 3
.L34:
	ret
.L32:
	xorl	%ecx, %ecx
	xorl	%eax, %eax
	jmp	.L27
	.cfi_endproc
.LFE38:
	.size	returnSumWithBias, .-returnSumWithBias
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB39:
	.cfi_startproc
	endbr64
	subq	$40, %rsp
	.cfi_def_cfa_offset 48
	movdqa	.LC2(%rip), %xmm0
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	movq	%rsp, %rdi
	movl	$0, 16(%rsp)
	movaps	%xmm0, (%rsp)
	call	lower
	movq	24(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L38
	xorl	%eax, %eax
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L38:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE39:
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
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC2:
	.quad	5717073776924706120
	.quad	4475986
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
