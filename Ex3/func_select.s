#   idan turkenits 326685815
.section .rodata
pstrlen_str:	.string	"first pstring length: %d, second pstring length: %d\n"
invalid_opt_str:	.string	"invalid option!\n"

output_replaceChar_str : .string "old char: %c, new char: %c, first string: %s, second string: %s\n"
input_replaceChar_str : .string " %c %c"

output_pstrijcpy_str : .string "length: %d, string: %s\n"
input_pstrijcpy_str :   .string " %d\n%d"

output_pstrijcmp_str : .string "compare result: %d\n"
input_pstrijcmp_str :   .string " %d\n%d"

.align 8 # Align address to multiple of 8
.L10:
    .quad .L1 # Case 50: loc_A
    .quad .L6 # Case 51: loc_def
    .quad .L2 # Case 52: loc_B
    .quad .L3 # Case 53: loc_C
    .quad .L4 # Case 54: loc_D
    .quad .L5 # Case 55: loc_E
    .quad .L6 # Case 56: loc_def
    .quad .L6 # Case 57: loc_def
    .quad .L6 # Case 58: loc_def
    .quad .L6 # Case 59: loc_def
    .quad .L1 # Case 60: loc_A


.text	# the beggining of the code
.globl run_func
.type  run_func, @function
run_func:   # rdi = opt, rsi = Pstring* str1, rdx = Pstring* str2 
    subq    $50, %rdi  # opt = opt - 50
    movq    %rdi, %rcx # xi = x
    cmpq    $10, %rcx # xi : 10
    ja .L6 # if >, go to invalid option
    jmp     *.L10(,%rcx,8) # goto jt[xi]
    ret

# call pstrlen - case 50/60
.L1: 
    push    %rdx        # push str2 into the stack
    movq    %rsi, %rdi  # moves str1 to be the first parameter
    call    pstrlen     # calling pstrlen
    movq    %rax, %rsi  # saving the return value in rsi
    pop     %rdx        # poping rdx from the stack
    movq    %rdx, %rdi  # moves str2 to be the first parameter
    call    pstrlen     # calling pstrlen
    movq    %rax, %rdx  # saving the return value in rdx
    movq    $pstrlen_str, %rdi  # saving the pstrlen_str in rdi
    movq    $0,%rax
    call    printf # calling printf with (pstrlen_str, return value 1, return value 2)
    ret

# call replace char - case 52
.L2:
    pushq   %rbp # setup
    movq    %rsp, %rbp # setup

    pushq   %rdx # pushing the second string
    pushq   %rsi # pushing the first string

    sub     $16, %rsp # give place for chars on stack

    # setting up the parameters
    movq    $input_replaceChar_str, %rdi
    leaq    (%rsp),%rsi
    leaq    8(%rsp),%rdx

    # input chars from user
    movq    $0,%rax
    call    scanf
    movq    $0,%rax


    popq    %rsi # getting the first char
    popq    %rdx # getting the second char
    popq    %rdi # getting the first string
    call    replaceChar # calling replaceChar(first char, second char, first string)
    movq    %rax, %rcx # saving the result in rcx

    popq    %rdi # getting the second string
    call    replaceChar # calling replaceChar(first char, second char, second string)
    movq    %rax, %r8 # saving the result in r8

    movq    $output_replaceChar_str, %rdi
    incq    %rcx
    incq    %r8
    movq    $0,%rax
    call    printf

    movq    %rbp, %rsp # Finish
    popq    %rbp # Finish
    ret 

# call pstrijcpy - case 53
.L3:
    pushq   %rbp # setup
    movq    %rsp, %rbp # setup

    pushq   %rdx # pushing the source string
    pushq   %rsi # pushing the destination string

    sub     $16, %rsp # give place for chars on stack

    # setting up the parameters
    movq    $input_pstrijcpy_str, %rdi
    leaq    (%rsp),%rsi # giving place for i
    leaq    8(%rsp),%rdx # giving place for j

    # input integers from user
    movq    $0,%rax
    call    scanf
    movq    $0,%rax

    popq    %rdx # popping i from the stack into rdx
    movq    $0, %rcx
    popq    %rcx # popping j from the stack into rcx
    popq    %rdi # popping dest string into rdi
    movq    (%rsp), %rsi # popping src string into rsi

    call   pstrijcpy # calling pstrijcpy(dest str, src str, i, j)

    # printing dest string
    movq    $output_pstrijcpy_str, %rdi
    movq    $0, %rsi
    movb    (%rax), %sil 
    leaq    1(%rax), %rdx
    movq    $0, %rax
    call    printf

    # printing source string
    movq    $output_pstrijcpy_str, %rdi
    popq    %rax
    movq    $0, %rsi
    movb    (%rax), %sil 
    leaq    1(%rax), %rdx
    movq    $0, %rax
    call    printf

    movq    %rbp, %rsp # Finish
    popq    %rbp # Finish
    ret

# call swapCase - case 54
.L4: # rsi = Pstring* str1, rdx = Pstring* str2 
    pushq %rdx
    movq    %rsi, %rdi
    movq    $0, %rsi
    call    swapCase
    movb    (%rax), %sil
    leaq    1(%rax), %rdx
    movq    $output_pstrijcpy_str, %rdi
    movq    $0, %rax
    call    printf

    popq    %rdi
    call    swapCase
    movq    $0, %rsi
    movb    (%rax), %sil
    leaq    1(%rax), %rdx
    movq    $output_pstrijcpy_str, %rdi
    movq    $0, %rax
    call    printf
    ret

# calling pstrijcmp 
.L5:
    pushq   %rbp # setup
    movq    %rsp, %rbp # setup

    pushq   %rdx # pushing the source string
    pushq   %rsi # pushing the destination string

    sub     $16, %rsp # give place for chars on stack

    # setting up the parameters
    movq    $input_pstrijcmp_str, %rdi
    leaq    (%rsp),%rsi # giving place for i
    leaq    8(%rsp),%rdx # giving place for j

    # input integers from user
    movq    $0,%rax
    call    scanf
    movq    $0,%rax

    popq    %rdx # popping i from the stack into rdx
    movq    $0, %rcx
    popq    %rcx # popping j from the stack into rcx
    popq    %rdi # popping string1 into rdi
    movq    (%rsp), %rsi # popping string2 into rsi

    call   pstrijcmp # calling pstrijcmp(str1, str2, i, j)

    # printing dest string
    movq    $output_pstrijcmp_str, %rdi
    movq    %rax, %rsi
    movq    $0, %rax
    call    printf

    movq    %rbp, %rsp # Finish
    popq    %rbp # Finish
    ret

# invalid option 
.L6:
    movq    $invalid_opt_str, %rdi
    movq    $0,%rax
    call    printf
    ret


