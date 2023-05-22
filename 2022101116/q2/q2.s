.global _calculate

_calculate:
    movq %rdi, %rax # move a to rax
    movq %rsi, %r15 # move x to r15
    # b is in rdx
    # y is in rcx
    cmpb $0, %cl # is y is negative instead of left shift we do right shift
    js .negative1 
    salq %cl, %rdx # left shift b by y
    movq %r15, %rcx # store x in rcx
    cmpb $0, %cl # is x is negative instead of left shift we do right shift
    js .negative2
    salq %cl, %rax  # left shift a by x
    addq %rdx, %rax # rax = a.2^x + b.2^y
    ret

.negative1:
    neg %cl # negate y
    sarq %cl, %rdx # arithematic right shift b by y
    movq %r15, %rcx # store x in rcx
    cmpb $0, %cl # is x is negative instead of left shift we do right shift
    js .negative2
    salq %cl, %rax # left shift a by x
    addq %rdx, %rax # rax = a.2^x + b.2^y
    ret

.negative2:
    neg %cl # negate x
    sarq %cl, %rax # arithematic right shift a by x
    addq %rdx, %rax # rax = a.2^x + b.2^y
    ret
