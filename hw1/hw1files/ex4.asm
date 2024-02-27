.global _start

.section .text
_start:
#your code here


#start with resetting registers to use for the cur and prev node data:
xor %rax, %rax #rax will represent the current node
xor %rbx, %rbx #rbx will represent the next node's pointer
xor %rcx, %rcx #rcx will represent the next node


#INCREASING SERIES:
movq head(%rip), %rdi #load the start of the list into rdi
testq %rdi, %rdi #check if there isn't a list to begin with
je INCREASING_SERIES_RET_3



INCREASING_SERIES_LOOP:
movq (%rdi), %rax #load the current value into rax 
movq 8(%rdi), %rbx #increase rdi by 8 to get the address of the next element and store it in rbx
testq %rbx, %rbx #check if it's the end of the list
je INCREASING_SERIES_RET_3
movq (%rbx), %rcx #load the cur_element into rcx
cmpq %rax, %rcx # if (cur aka rax >= next aka rcx)
jle END_OF_INCREASING_SERIES_LOOP
movq %rbx, %rdi # cur <- next
jmp INCREASING_SERIES_LOOP
END_OF_INCREASING_SERIES_LOOP:


#zeroes:
xor %rax, %rax #rax will represent the current node
xor %rbx, %rbx #rbx will represent the next node's pointer
xor %rcx, %rcx #rcx will represent the next node


#NON DECREASING SERIES:
movq head(%rip), %rdi #load the start of the list into rdi
testq %rdi, %rdi #check if there isn't a list to begin with
je INCREASING_SERIES_RET_3



NON_DECREASING_SERIES_LOOP:
movq (%rdi), %rax #load the current value into rax 
movq 8(%rdi), %rbx #increase rdi by 8 to get the address of the next element and store it in rbx
testq %rbx, %rbx #check if it's the end of the list
je NON_DECREASING_SERIES_RET_2
movq (%rbx), %rcx #load the cur_element into rcx
cmpq %rax, %rcx # if (cur aka rax >= next aka rcx)
jl END_OF_NON_DECREASING_SERIES_LOOP
movq %rbx, %rdi # cur <- next
jmp NON_DECREASING_SERIES_LOOP
END_OF_NON_DECREASING_SERIES_LOOP:



#zeroes:
xor %rax, %rax #rax will represent the current node
xor %rbx, %rbx #rbx will represent the next node's pointer
xor %rcx, %rcx #rcx will represent the next node
xor %r8, %r8 #r8 will represent how many elements are out of place 




#ALMOST INCREASING SERIES:
movq head(%rip), %rdi #load the start of the list into rdi
testq %rdi, %rdi #check if there isn't a list to begin with
je INCREASING_SERIES_RET_3

#rbx = rbx for me
#rcx = rcx for me
#rax = rax for me

ALMOST_INCREASING_SERIES_LOOP:
movq (%rdi), %rax
movq 0x8(%rdi) , %rbx 
testq %rbx , %rbx
je ALMOST_INCREASING_SERIES_RET_1
movq (%rbx) , %rcx
cmpq %rax , %rcx
jl RemoveElement_HW1
movq %rax , %rcx
movq %rbx , %rdi
jmp ALMOST_INCREASING_SERIES_LOOP




RemoveElement_HW1:
testq %r8 , %r8
jne NOTHING_SPECIAL_SERIES_RET_0
movq 0x8(%rbx) , %rdx
testq %rdx , %rdx
je ALMOST_INCREASING_SERIES_RET_1
movq (%rdx) , %rdx
cmp %rax , %rdx
jge SKIP_ONE_ELEMENT
cmp  %rcx , (%rbx)
jl NOTHING_SPECIAL_SERIES_RET_0
movq %rbx , %rdi
incq %r8
jmp ALMOST_INCREASING_SERIES_LOOP


SKIP_ONE_ELEMENT:
movq (%rdi), %rcx
movq 0x8(%rbx) , %rdi
incq %r8
jmp ALMOST_INCREASING_SERIES_LOOP



END_OF_ALMOST_INCREASING_SERIES_LOOP:


#OTHERWISE:
jmp NOTHING_SPECIAL_SERIES_RET_0




INCREASING_SERIES_RET_3:
movb $3, (result)
jmp END_OF_HW1Q4_CODE


NON_DECREASING_SERIES_RET_2:
movb $2, (result)
jmp END_OF_HW1Q4_CODE


ALMOST_INCREASING_SERIES_RET_1:
movb $1, (result)
jmp END_OF_HW1Q4_CODE


NOTHING_SPECIAL_SERIES_RET_0:
movb $0, (result)
#jmp END_OF_HW1Q4_CODE


END_OF_HW1Q4_CODE:

