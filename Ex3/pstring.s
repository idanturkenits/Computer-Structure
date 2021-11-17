.global pstrlen

.type   pstrlen, @function
pstrlen:
    xor %rax, %rax
    movq (%rdi), %rax