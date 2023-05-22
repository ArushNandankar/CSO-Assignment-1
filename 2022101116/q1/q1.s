.global _get_sum

_get_sum:
    movq $0, %r14 # sum = 0
    movq $0, %r15  # i = 0
    movq %rsi, %rbx # rbx = size
    movq %rdi, %rcx # rcx = arr
    movq $3, %r13 # for divisiblity checking

.Loop:
    cmpq %rbx, %r15 # if index >= size jump to end
    jge .End

    movq (%rcx), %rax # rax = array[i]
    xor %rdx, %rdx # rdx = 0
    idivq %r13 # rax / 3 => remainder stored in rdx
    cmp $0, %rdx # if remainder is 0 jump to divby3
    je .DivBy3

    jmp .NotDivBy3 # else jump to notdivby3

.NotDivBy3:
    addq $8, %rcx # move up the array by 8 because long long is 8 bytes
    inc %r15 # increment index
    jmp .Loop # go back to loop

.DivBy3:    
    addq (%rcx), %r14 # add element to sum
    addq $8, %rcx # move up the array by 8 because long long is 8 bytes
    inc %r15 # increment index
    jmp .Loop # go back to loop

.End:
    movq %r14, %rax # store sum is rax
    ret
