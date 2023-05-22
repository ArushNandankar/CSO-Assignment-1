.global _get_product_assembly

_get_product_assembly:
    movq $1, %rax     # initialize the product to 1
    movq %rdi, %rbx   # move the address of head node to %rbx
    jmp .Loop

.Loop:
    cmpq $0, %rbx   # see if rbx is null
    je .End            # if it's 0, we have reached the end of the list
    imulq (%rbx), %rax  # multiply the product by the value of the data at current node

    movq $9223372036854775807, %rcx     # move the value of LLONG_MAX to %rcx
    movq $0, %rdx        # because remainder is stored in %rdx we first clear it
    idivq %rcx         # dividing the product by LLONG_MAX
    movq %rdx, %rax      # now product % LLONG_MAX is stored in %rax

    movq 8(%rbx), %rbx   # move the pointer field (next node's address) to %rbx
    jmp .Loop          # jump back to the start of the loop

.End:
    ret
