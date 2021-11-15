# Idan Turkenits 326685815
.global  even
.global go

.type   go, @function
go:
    pushq %rbp # setup
    movq %rsp, %rbp  # setup

    movq $0, %rax # saving the sum
    movq $0, %rdx # saving i
    
    cmpq $10, %rdx # comparing i : 10
    jge DONE
    L11:
        pushq %rax # pushing sum into the stack
        pushq %rdx # pushing i into the stack
        movq (%rdi, %rdx, 4), %rax
        mov $0, %rdx
        mov $2, %rcx
        idivq %rcx
        cmpq $0, %rdx # comparing 0: (A[i] % 2)
        popq %rdx
        popq %rax
        jne NOT_EQUAL
        # if A[i] % 2 == 0
        EQUAL:
            pushq %rax # pushing sum into the stack
            pushq %rdi # pushing i into the stack
            movq (%rdi, %rdx, 4), %rdi # rdi stires A[i]
            movq %rdx, %rsi # rsi stores i
            call even # even(A[i], i)
            movq %rax, %rcx # num = even (A[i], i);
            popq %rdi # poping i from the stack into rdi
            popq %rax # poping sum from the stack into rax
            addq %rcx, %rax # sum += num
            jmp L12
        # if A[i] % 2 != 0
        NOT_EQUAL:
            addq (%rdi, %rdx, 4), %rax
       
        L12:
            incq %rdx        
            cmpq $10, %rdx # comparing i : 10
            jl L11

    DONE:
        movq %rbp, %rsp #Finish
        popq %rbp       # Finish
        ret


.type   even, @function
even:
    pushq %rbp # setup
    movq %rsp, %rbp  # setup

    movq %rdi, %rax # getting num - the first parameter
    movq %rsi, %rcx
    shlq %cl, %rax # shift with i - the second paraemter

    movq %rbp, %rsp # Finish
    popq %rbp       # Finish
	ret			# return to caller function (main)
