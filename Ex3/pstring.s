
.globl pstrlen
.type   pstrlen, @function
pstrlen:
    xor     %rax, %rax
    movb    (%rdi), %al
	ret	

.globl replaceChar
.type   replaceChar, @function
replaceChar: # rdi = Pstring*, rsi = oldchar , rdx = newchar
movq    %rdi, %rax
incq    %rdi
cmpb    $0, (%rdi)
loop:
je finish
cmpb    %sil, (%rdi)
jne finish_iteration
movb    %dl, (%rdi)
finish_iteration:
incq    %rdi
cmpb    $0, (%rdi)
jmp loop
finish:
ret


.globl pstrijcpy
.type   pstrijcpy, @function
pstrijcpy: # rdi = Pstring* dst, rsi = Pstring* src , rdx = char i, rcx = char j
# To Do: check for valid input 
movq    %rdi, %rax
incq    %rdi
incq    %rsi
cmpq    %rcx,%rdx # i : j
jg finish_pstrijcpy
loop_pstrijcpy:
movb    (%rsi, %rdx), %r8B
movb    %r8B, (%rdi, %rdx)
incq    %rdx
cmpq    %rcx , %rdx # i : j
jg finish_pstrijcpy
jmp loop_pstrijcpy
finish_pstrijcpy:
ret
