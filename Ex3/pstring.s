#   idan turkenits 326685815
.section .rodata
invalid_input_str:	.string	"invalid input!\n"


.text
# #################################
# pstrlen function.
#
#
#
# #################################
.globl pstrlen
.type   pstrlen, @function
pstrlen:
    xor     %rax, %rax
    movb    (%rdi), %al
	ret	


# #################################
# replaceChar function.
#
#
#
# #################################
.globl replaceChar
.type   replaceChar, @function
replaceChar: # rdi = Pstring*, rsi = oldchar , rdx = newchar
    movq    %rdi, %rax
    incq    %rdi
    cmpb    $0, (%rdi)
loop_replaceChar:
    je      finish
    cmpb    %sil, (%rdi)
    jne     finish_iteration
    movb    %dl, (%rdi)
finish_iteration:
    incq    %rdi
    cmpb    $0, (%rdi)
    jmp     loop_replaceChar
finish:
    ret


# #################################
# pstrijcpy function.
#
#
#
# #################################
.globl pstrijcpy
.type   pstrijcpy, @function
pstrijcpy: # rdi = Pstring* dst, rsi = Pstring* src , rdx = char i, rcx = char j
    pushq   %rbp # setup
    movq    %rsp, %rbp # setup
    push    %rdi
    movq    $0, %r9
    movb    %dl, %r9B
    movq    %r9, %rdx
    # input validation:
    # validate with dst string
    cmpb    (%rdi), %cl # len(dst) : j
    jae     invalid_input
    cmpb    (%rdi), %dl  # len(dst) : j
    jae     invalid_input

    # validate with src string
    cmpb     (%rsi), %cl # len(dst) : j
    jae     invalid_input
    cmpb    (%rsi), %dl # len(dst) : j
    jae     invalid_input

    incq    %rdi # dst = dst + 1
    incq    %rsi # src = src + 1
    cmpb    %cl,%dl # i : j
    ja      finish_pstrijcpy

loop_pstrijcpy:
    movb    (%rsi, %rdx), %r8B
    movb    %r8B, (%rdi, %rdx)
    incq    %rdx
    cmpb    %cl , %dl # i : j
    ja      finish_pstrijcpy
    jmp     loop_pstrijcpy
invalid_input:
    movq    $invalid_input_str, %rdi
    movq    $0, %rax
    call    printf
finish_pstrijcpy:
    pop     %rax
    movq    %rbp, %rsp # Finish
    popq    %rbp # Finish
    retq

# #################################
# swapCase function.
#
#
#
# #################################
.globl swapCase
.type  swapCase, @function
swapCase: # rdi = Pstring* string
    movq    %rdi, %rax
    incq    %rdi
    cmpb    $0, (%rdi)
loop_swap_case:
    je      finish_swap_case
    cmpb    $65, (%rdi) # string[i] : 'A'
    jl      finish_iteration_swap_case
    cmpb    $90, (%rdi) # string[i] : 'Z'
    jg      check_lower_case
    movb    (%rdi), %r8b
    addb    $32, %r8b
    movb    %r8b, (%rdi)
    jmp finish_iteration_swap_case
check_lower_case:
    cmpb    $97, (%rdi) # string[i] : 'a'
    jl      finish_iteration_swap_case
    cmpb    $122, (%rdi) # string[i]: 'z'
    jg      finish_iteration_swap_case
    movb    (%rdi), %r8b
    subb    $32, %r8b
    movb    %r8b, (%rdi)
finish_iteration_swap_case:
    incq    %rdi
    cmpb    $0, (%rdi)
    jmp     loop_swap_case
finish_swap_case:
    ret

# #################################
# swapCase function.
#
#
#
# #################################
.globl pstrijcmp
.type   pstrijcmp, @function
pstrijcmp: # rdi = Pstring* dst, rsi = Pstring* src , rdx = char i, rcx = char j
    pushq   %rbp # setup
    movq    %rsp, %rbp # setup
    movq    $0, %r9
    movb    %dl, %r9B
    movq    %r9, %rdx
     # input validation:
    # validate with dst string
    cmpb    (%rdi), %cl # len(dst) : j
    jae     invalid_input_pstrijcmp
    cmpb    (%rdi), %dl  # len(dst) : j
    jae     invalid_input_pstrijcmp

    # validate with src string
    cmpb     (%rsi), %cl # len(dst) : j
    jae     invalid_input_pstrijcmp
    cmpb    (%rsi), %dl # len(dst) : j
    jae     invalid_input_pstrijcmp

    incq    %rdi # dst = dst + 1
    incq    %rsi # src = src + 1
    cmpb    %cl,%dl # i : j
    ja      finish_pstrijcpy

loop_pstrijcmp:
    movb    (%rsi, %rdx), %r8B
    cmpb    %r8B, (%rdi, %rdx) # str1[i] : str2[i]
    ja      greater_pstrijcmp # if str1[i] > str2[i]
    jl      smaller_pstrijcmp # if str1[i] < str2[i]
    movq    $0, %rax
    incq    %rdx
    cmpb    %cl , %dl # i : j
    ja      finish_pstrijcmp
    jmp     loop_pstrijcmp
invalid_input_pstrijcmp: # if the input is invalid 
    movq    $invalid_input_str, %rdi
    movq    $0, %rax
    call    printf
    movq    $-2, %rax
    jmp finish_pstrijcmp
greater_pstrijcmp: # if str1[i] > str2[i] 
    movq    $1, %rax
    jmp     finish_pstrijcmp
smaller_pstrijcmp: # if str1[i] < str2[i]
    movq    $-1, %rax
finish_pstrijcmp:
    movq    %rbp, %rsp # Finish
    popq    %rbp # Finish
    retq
