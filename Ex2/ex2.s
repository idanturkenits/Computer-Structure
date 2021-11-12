
main:





go:
    mov %rdi, %rbx



even:
    movq %rdi %rax ;getting num - the first parameter
    shlq %rax, %rsi ;shift with i - the second paraemter
	ret			;return to caller function (main)

 
