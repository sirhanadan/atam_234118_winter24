.global _start

.section .text
_start:
 


   xorq %r15,%r15# array size
    xorq %r14,%r14
    xorq %r13,%r13
    xorq %r12,%r12# pointer for source array
    xorq %rbx,%rbx# pointer for up_array
    xorq %rcx,%rcx# pointer for down_array
    xorq %rax,%rax# temp for bool
    xorq %r8,%r8  #temp for source array
    xorq %r9,%r9  #another temp fpr source array
    movl (size),%r15d
    movq $100000,%r14 #last one for down
    movq $-1000000,%r13# last one for up
    
   cmpl $0,%r15d
   je true_case
   cmpl $1,%r15d
   je one_member_HW1
first_member:#and we know we have more than one member ins ource array
movl source_array(,%r12,4),%r8d
inc %r12 # e7na be 1 be source array
movl source_array(,%r12,4),%r9d
cmp %r8d,%r9d
jg up_add_first
jmp down_add_first



up_add_first:
movl %r8d,up_array(,%rbx,4)
inc %rbx
movl %r8d,%r13d
jmp loop_Hw1


down_add_first:
movl %r8d,down_array(,%rcx,4)
inc %rcx
movl %r8d,%r14d
jmp loop_Hw1


loop_Hw1:
inc %r12
cmpl %r12d,%r15d
je last_member_add_HW1
movl source_array(,%r12,4),%r9d
dec %r12
movl source_array(,%r12,4),%r8d

cmp %r8d, %r13d
jge check_down
cmp %r8d,%r14d
jge equal
#cmp %r8d,%r14d
jmp add_up
check_down:
cmpl %r8d,%r14d
jle no_sol
cmp %r8d,%r13d
jg add_down
jmp no_sol
equal:
cmp %r8d,%r9d
jge add_up
jmp add_down
add_up:
movl %r8d,up_array(,%rbx,4)
movl %r8d,%r13d
inc %rbx
inc %r12
jmp loop_Hw1


add_down:
movl %r8d,down_array(,%rcx,4)
movl %r8d,%r14d
inc %rcx
inc %r12
jmp loop_Hw1



one_member_HW1:# we just add it in a random array
movl source_array(,%r12,4),%r8d
movl %r8d,up_array(,%rbx,4)
jmp true_case
#up_array, down_array

last_member_add_HW1:
dec %r12
movl source_array(,%r12,4),%r8d
cmp %r8d,%r13d
jl add_last_up
cmp %r8d,%r14d
jg add_last_down
jmp no_sol




add_last_up:
movl %r8d,up_array(,%rbx,4)
jmp true_case

add_last_down:
movl %r8d,down_array(,%rcx,4)
jmp true_case



true_case:
movb $1,%al
movb %al,(bool)
jmp end_Hw1

no_sol:

movb $0,%al
movb %al,(bool)
jmp end_Hw1

end_Hw1:
