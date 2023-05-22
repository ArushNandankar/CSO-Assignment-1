.global _get_address_smallest

_get_address_smallest:
    movq %rdi, %rcx # address of first element of array stored in rax
    movq %rdi, %rax # store the address of the smallest element (by default the first element)
    movq %rsi, %rbx # size of array stored in rbx
    movq $0, %rdx # store the current index

.Loop:
    cmpq %rbx, %rdx # if current index >= size jump to end
    jge .End

    movq (%rcx), %r15 # store value of current element in r15
    movq (%rax), %r14 # store value of smallest element in r14

    cmpq %r15, %r14 # is smallest element is greater than current element jump to smaller
    jg .Smaller

    jmp .notSmaller

.Smaller:
    movq %rcx, %rax # store the address of new smallest to rax
    addq $8, %rcx # increment rcx by 8 to move through the array
    inc %rdx # increment index
    jmp .Loop

.notSmaller:
    addq $8, %rcx # increment rcx by 8 to move through the array
    inc %rdx # increment index
    jmp .Loop

.End:
    ret
