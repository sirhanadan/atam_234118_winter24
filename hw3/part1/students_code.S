.global get_element_from_matrix, inner_prod, matrix_multiplication

get_element_from_matrix:

   #we get : 
   #  %rdi - matrix address
   #  %rsi - n
   #  %rdx - row
   #  %rcx - col
    push %rbp
    mov %rsp,%rbp  
    xorq %rax,%rax
    imull %esi, %edx    #%rdx=n*row
    addl %edx,%ecx  #%rcx= n*row+col
    movl (%rdi, %rcx,4), %eax    #moved the matrix address %rcx*4 steps - (each int takes 4 bytes) 
    leave
    ret
	

inner_prod:
    #we work yes we do work

    #rdi : mat_a
    #rsi : mat_b
    #rdx : row_a
    #rcx : col_b
    #r8  : max_col_a ele feyu hu el loop + get 
    #r9  : max_col_b ele hu ll getush
 
    #r12 : our i (counter for the loop)
    #r13 : to save the result of getelement foe matrix 1 
    #r14 : to save the total sum so far
    #i become so alive


    push %rbp
    mov %rsp,%rbp  
    pushq %r12
    pushq %r13
    pushq %r14
    xorq %r12,%r12
    xorq %r13,%r13
    xorq %r14,%r14
    loop:
       #  %rdi - matrix address
       #  %rsi - n
       #  %rdx - row
       #  %rcx - col
    pushq %rdi 
    pushq %rsi
    pushq %rdx
    pushq %rcx
    movl %r8d,%esi
    movl %r12d,%ecx
    call get_element_from_matrix
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    movl %eax ,%r13d

    # second call for the get_element for matrix b or whaeva

    pushq %rdi 
    pushq %rsi
    pushq %rdx
    pushq %rcx
    movq %rsi,%rdi
    movl %r9d,%esi
    movl %r12d,%edx
    call get_element_from_matrix
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi
    mull %r13d
    addl %eax,%r14d



   incq %r12
   cmpq %r12,%r8
   jg loop
   movl %r14,%eax
   popq %r14
   popq %r13
   popq %r12
   

 leave
    ret

matrix_multiplication:
  #we work yes we do work

    #rdi : res
    #rsi : mat_a
    #rdx : mat_b
    #rcx : m row of a
    #r8  : n col of a
    #r9  : row of b (p)
    #     %r12          el m5saneet feha el muta4ayeer el sab3 (el col of b) q 
    push %rbp
    mov %rsp,%rbp  
    movq 16(%rbp),%r12   #check if its right    col of b 
    cmpl %r9d,%r8d
    jne bad_exit_HW2
    xorq %r15,%r15 #rows a
    xorq %r14,%r14 #cols b
    xorq %r13,%r13


    loop_main_HW2:
     pushq %rdi 
    pushq %rsi
    pushq %rdx
    pushq %rcx
    pushq %r8
    pushq %r9
    movq %rsi,%rdi
    movq %rdx,%rsi
    movl %r15d, %edx
    movl %r14d,%ecx
    movl %r12d,%r9d
  
    #max_col_a mawjud 
    call inner_prod
    popq %r9
    popq %r8
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi


    pushq %rdi 
    pushq %rsi
    pushq %rdx
    pushq %rcx
    pushq %r8
    pushq %r9

    movl %r12d,%esi
    movl %r15d,%edx
    movl %r14d, %ecx
    movl %eax,%r8d

    call set_element_in_matrix
    popq %r9
    popq %r8
    popq %rcx
    popq %rdx
    popq %rsi
    popq %rdi

    incl %r14d
    cmpl %r14d,%r12d
    jne loop_main_HW2
    movl $0,%r14d
    incl %r15d
    cmpl %r15d,%ecx
    jne loop_main_HW2
    movq $1, %rax
    jmp Exit_HW2


    

  
    #rdi : res
    #rsi : mat_a
    #rdx : mat_b
    #rcx : m row of a
    #r8  : n col of a
    #r9  : row of b (p)



    


bad_exit_HW2:
movl $0,%rax
jmp Exit_HW2

    Exit_HW2:
    leave
	ret
