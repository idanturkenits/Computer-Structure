	.file	"code.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"the result is %d"
	.text
	.globl	arith
	.type	arith, @function
arith:
.LFB34:
	.cfi_startproc
	endbr64
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movl	%edx, %ecx
	leal	(%rdi,%rsi), %edx
	movl	%edx, %eax
	shrl	$31, %eax
	addl	%eax, %edx
	sarl	%edx
	imull	%ecx, %edx
	leal	(%rdx,%rdx,2), %edx
	sall	$4, %edx
	leaq	.LC0(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE34:
	.size	arith, .-arith
	.section	.rodata.str1.1
.LC1:
	.string	"The new string is %s"
	.text
	.globl	lower
	.type	lower, @function
lower:
.LFB35:
	.cfi_startproc
	endbr64
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	movq	%rdi, %rsi
	movl	$0, %edx
	movq	$-1, %r8
	movl	$0, %eax
	jmp	.L4
.L5:
	addq	$1, %rdx
.L4:
	movq	%r8, %rcx
	movq	%rsi, %rdi
	repnz scasb
	notq	%rcx
	subq	$1, %rcx
	cmpq	%rdx, %rcx
	jbe	.L8
	movzbl	(%rsi,%rdx), %ecx
	leal	-65(%rcx), %edi
	cmpb	$25, %dil
	ja	.L5
	addl	$32, %ecx
	movb	%cl, (%rsi,%rdx)
	jmp	.L5
.L8:
	movq	%rsi, %rdx
	leaq	.LC1(%rip), %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE35:
	.size	lower, .-lower
	.globl	sumAndSave
	.type	sumAndSave, @function
sumAndSave:
.LFB36:
	.cfi_startproc
	endbr64
	movl	$0, (%rdx)
	testl	%esi, %esi
	jle	.L9
	movq	%rdi, %rax
	leal	-1(%rsi), %ecx
	leaq	4(%rdi,%rcx,4), %rsi
.L11:
	movl	(%rax), %ecx
	addl	%ecx, (%rdx)
	addq	$4, %rax
	cmpq	%rsi, %rax
	jne	.L11
.L9:
	ret
	.cfi_endproc
.LFE36:
	.size	sumAndSave, .-sumAndSave
	.globl	multArrBy2
	.type	multArrBy2, @function
multArrBy2:
.LFB37:
	.cfi_startproc
	endbr64
	testl	%esi, %esi
	jle	.L13
	movq	%rdi, %rax
	leal	-1(%rsi), %edx
	leaq	4(%rdi,%rdx,4), %rdx
.L15:
	sall	(%rax)
	addq	$4, %rax
	cmpq	%rdx, %rax
	jne	.L15
.L13:
	ret
	.cfi_endproc
.LFE37:
	.size	multArrBy2, .-multArrBy2
	.globl	returnSumWithBias
	.type	returnSumWithBias, @function
returnSumWithBias:
.LFB38:
	.cfi_startproc
	endbr64
	testl	%esi, %esi
	jle	.L20
	imull	%ecx, %edx
	movq	%rdi, %rax
	leal	-1(%rsi), %ecx
	leaq	4(%rdi,%rcx,4), %rcx
	movl	$0, %esi
.L19:
	movl	%edx, %edi
	addl	(%rax), %edi
	addl	%edi, %esi
	addq	$4, %rax
	cmpq	%rcx, %rax
	jne	.L19
.L17:
	movl	%esi, %eax
	ret
.L20:
	movl	$0, %esi
	jmp	.L17
	.cfi_endproc
.LFE38:
	.size	returnSumWithBias, .-returnSumWithBias
	.globl	main
	.type	main, @function
main:
.LFB39:
	.cfi_startproc
	endbr64
	pushq	%rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	subq	$32, %rsp
	.cfi_def_cfa_offset 48
	movl	$40, %ebx
	movq	%fs:(%rbx), %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	movabsq	$5717073776924706120, %rax
	movl	$4475986, %edx
	movq	%rax, (%rsp)
	movq	%rdx, 8(%rsp)
	movl	$0, 16(%rsp)
	movq	%rsp, %rdi
	call	lower
	movq	24(%rsp), %rax
	xorq	%fs:(%rbx), %rax
	jne	.L25
	movl	$0, %eax
	addq	$32, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 16
	popq	%rbx
	.cfi_def_cfa_offset 8
	ret
.L25:
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
