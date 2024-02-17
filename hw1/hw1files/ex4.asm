.global _start

.section .text
_start:
#your code here


#start with zeroing registers to use for the cur and prev node data:
xor %rax, %rax #rax will represent the prev node
xor %rbx, %rbx #rbx will represent the current node


#INCREASING SERIES:
movq head(%rip), %rdi #load the start of the list into rdi
testq %rdi, %rdi #check if there isn't a list to begin with
je INCREASING_SERIES_RET_3
movq (%rdi), %rax #load the first element into rax


INCREASING_SERIES_LOOP:
movq 8(%rdi), %rdi #increase rdi by 8 to get the address of the next element
testq %rdi, %rdi #check if it's the end of the list
je INCREASING_SERIES_RET_3
movq (%rdi), %rbx #load the cur_element into rbx
cmpq %rax, %rbx # if (prev aka rax >= cur aka rbx)
jle END_OF_INCREASING_SERIES_LOOP
movq %rbx, %rax # prev <- cur
jmp INCREASING_SERIES_LOOP
END_OF_INCREASING_SERIES_LOOP:


#zeroes:
xor %rax, %rax #rax will represent the prev node
xor %rbx, %rbx #rbx will represent the current node


#NON DECREASING SERIES:
movq head(%rip), %rdi #load the start of the list into rdi
testq %rdi, %rdi #check if there isn't a list to begin with
je NON_DECREASING_SERIES_RET_2
movq (%rdi), %rax #load the first element into rax


NON_DECREASING_SERIES_LOOP:
movq 8(%rdi), %rdi #increase radi by 8 to get the address of the next element
testq %rdi, %rdi #check if it's the end of the list
je NON_DECREASING_SERIES_RET_2
movq (%rdi), %rbx #load the cur_element into rbx
cmpq %rax, %rbx # if (prev aka rax > cur aka rbx)
jl END_OF_NON_DECREASING_SERIES_LOOP
movq %rbx, %rax # prev <- cur
jmp NON_DECREASING_SERIES_LOOP
END_OF_NON_DECREASING_SERIES_LOOP:



#zeroes:
xor %rax, %rax #rax will represent the prev node
xor %rbx, %rbx #rbx will represent the current node
xor %al, %al #al will represent how many elements are out of place 




#ALMOST INCREASING SERIES:
movq head(%rip), %rdi #load the start of the list into rdi
testq %rdi, %rdi #check if there isn't a list to begin with
je ALMOST_INCREASING_SERIES_RET_1
movq (%rdi), %rax #load the first element into rax





ALMOST_INCREASING_SERIES_LOOP:
movq 8(%rdi), %rdi #increase radi by 8 to get the address of the next element
testq %rdi, %rdi #check if it's the end of the list
je ALMOST_INCREASING_SERIES_RET_1
movq (%rdi), %rbx #load the cur_element into rbx

cmpq %rax, %rbx # if (prev aka rax > cur aka rbx)
jl ONE_ELEMENT_OUT_OF_PLACE

movq %rbx, %rax # prev <- cur
jmp ALMOST_INCREASING_SERIES_LOOP

ONE_ELEMENT_OUT_OF_PLACE:
cmpb $1, %al #if al > 1
jl END_OF_ALMOST_INCREASING_SERIES_LOOP
addb $1, %al #al++

movq %rbx, %rax # prev <- cur
jmp ALMOST_INCREASING_SERIES_LOOP


END_OF_ALMOST_INCREASING_SERIES_LOOP:



#OTHERWISE:
jmp NOTHING_SPECIAL_SERIES_RET_0






INCREASING_SERIES_RET_3:
movb $3, (result)
jmp END_OF_HW1_Q4


NON_DECREASING_SERIES_RET_2:
movb $2, (result)
jmp END_OF_HW1_Q4


ALMOST_INCREASING_SERIES_RET_1:
movb $1, (result)
jmp END_OF_HW1_Q4


NOTHING_SPECIAL_SERIES_RET_0:
movb $0, (result)
#jmp END_OF_HW1_Q4


END_OF_HW1_Q4:

