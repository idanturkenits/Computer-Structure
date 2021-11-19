.section .rodata
pstrlen_str:	.string	"first pstring length: %d, second pstring length: %d\n"
invalid_opt_str:	.string	"invalid option!\n"
replace_char_str : .string "old char: %c, new char: %c, first string: %s, second string: %s\n"

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
    push    %rdx
    movq    %rsi, %rdi
    call    pstrlen
    movq    %rax, %rsi
    pop     %rdx
    movq    %rdx, %rdi
    call    pstrlen
    movq    %rax, %rdx
    movq    $pstrlen_str, %rdi
    movq    $0,%rax
    call    printf
    ret

.L2:
.L3:
.L4:
.L5:

# invalid option 
.L6:
    movq $invalid_opt_str, %rdi
    movq    $0,%rax
    call    printf
    ret


