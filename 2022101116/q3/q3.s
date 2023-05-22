.global _divide

_divide:
    movq %rdi, %rax    # m stored in rax
    movq %rsi, %rbx    # n stored in rbx
    movq %rdx, %rcx    # arr stored in rcx
    movq $0, %r15      # initial quotient = 0

    testq %rbx, %rbx # checking if n is zero
    jz .trivial

    testq %rax, %rbx  # checking if both of them are negative
    js .both_negative

    testq %rax, %rax  
    js .m_negative # only m is negative 

    testq %rbx, %rbx  
    js .n_negative # only n is negative 
   
    jmp .both_positive # both are positive

    .both_negative:
        cmpq $0, %rax # m = ?
        jge .End_both_negative # is m has become positive jump to end
        subq %rbx, %rax # else substract n from m till it becomes positive or 0
        inc %r15 # increment quotient
        jmp .both_negative # loop over again

    .m_negative:
        cmpq $0, %rax # m = ?
        jge .End_m_negative # is m has become positive jump to end
        addq %rbx, %rax # else add n to n till it becomes 0 or positive
        inc %r15 # increment quotient
        jmp .m_negative # loop over again

    .n_negative:
        neg %rbx # negate n such that now both are postive
        .n_negative_II: 
        cmpq %rbx, %rax  # #########################################################
        js .End_n_negative # #######################################################
        subq %rbx, %rax # ############ Same As when both are positive ##############
        inc %r15 # #################################################################
        jmp .n_negative_II # #######################################################

    .both_positive:
        cmpq %rbx, %rax # m - n = ?
        js .End_both_postive # is m < n jump to end
        subq %rbx, %rax # else m = m - n
        inc %r15 # increment quotient
        jmp .both_positive # loop over again

    .End_both_negative:
        movq %r15, (%rcx) # move the quotient to arr[0]
        addq $8, %rcx # move to index 1 of array
        movq %rax, (%rcx) # move remainder to arr[1]
        ret

    .End_m_negative:
        neg %r15 # negate the quotient to get the correct quotient
        movq %r15, (%rcx) # move the quotient to arr[0]
        addq $8, %rcx # move to index 1 of array
        movq %rax, (%rcx) # move remainder to arr[1]
        ret

    .End_n_negative:
        neg %r15 # negate the quotient to get the correct quotient
        movq %r15, (%rcx) # move the quotient to arr[0]
        addq $8, %rcx # move to index 1 of array
        movq %rax, (%rcx) # move remainder to arr[1]
        ret

    .End_both_postive:
        movq %r15, (%rcx) # move the quotient to arr[0]
        addq $8, %rcx # move to index 1 of array
        movq %rax, (%rcx) # move remainder to arr[1]
        ret

    .trivial:
        movq $-1, (%rcx) # move -1 to arr[0]
        addq $8, %rcx # move to index 1 of array
        movq $-1, (%rcx) # move -1 to arr[1]
        ret
