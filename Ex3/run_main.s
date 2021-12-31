#	idan turkenits 326685815
.section .rodata
input_len_string: .string " %d"
input_option_string: .string " %d"
input_string_string: .string " %s"

.text
.globl run_main
.type   run_main, @function
run_main:
    pushq   %rbp # setup
    movq    %rsp, %rbp # setup

    # input first pstring
    subq    $256, %rsp
    movq    $input_len_string, %rdi
    leaq    (%rsp), %rsi
    call    scanf 
    movq    $input_string_string, %rdi
    leaq    1(%rsp), %rsi
    call    scanf

    # input second pstring
    subq    $256, %rsp
    movq    $input_len_string, %rdi
    leaq    (%rsp), %rsi
    call    scanf
    movq    $input_string_string, %rdi
    leaq    1(%rsp), %rsi
    call    scanf

    # input option
    subq    $16, %rsp
    movq    $input_option_string, %rdi
    leaq    (%rsp), %rsi
    call    scanf

    movq    (%rsp), %rdi
    leaq    272(%rsp), %rsi
    leaq    16(%rsp), %rdx
    call    run_func

    movq    %rbp, %rsp # Finish
    popq    %rbp # Finish
    retq
