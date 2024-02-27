.global _start

.section .text
_start:


#first start with resetting all the registers you might use
xor %rax, %rax #rax will represent the current vertix
xor %rbx, %rbx #rbx will represent the current vertix's list of neighbors
xor %r11, %r11 #r11 will represent the first degree neighbors
xor %r12, %r12 #r12 will represent the second degree neighbors
xor %r13, %r13 #r13 will represent the third degree neighbors
xor %r14, %r14 #r14 will represent the fourth degree neighbors
xor %r15, %r15 #r15 will represent the fifth degree neighbors
xor %r9, %r9 #r9 will represent the sixth degree neighbors
xor %r10, %r10 #r10 will represent the seventh degree neighbors
xor %r8, %r8 #r8 will represent the eighth degree neighbors

#note: if the graph is A -> B -> C then B is A's first degree neighbor
#and C is A's second degree neighbor and B's first degree neighbor

#load the vertices pointer into rax (aka current vertix pointer)
movq $vertices, %rax
#load the first neighbor of rax into rbx 
movq (%rax), %rbx

#base case if the list is empty
movb $-1, (circle)


LOOP_THROUGH_VERTICES:
cmpq $0, %rbx #if we've reached the end of the list with no cycles finish
je NO_CYCLE_RET_M1

FIRST_DEGREE_NEIGHBORS_LOOP:
movq (%rbx), %r11
cmpq $0, %r11 #if we've reached the end of the first neighbors with no cycles, go to the next vertix
je LOOP_THROUGH_VERTICES_CONT 
cmpq %r11, (%rax) #is there a cycle? aka can this current vertix be reached by his neighbors
je FOUND_CYCLE_RET_1 

#same loop for each degree of neighbors, since there can only be 8 at most then 8 loops as sufficient
SECOND_DEGREE_NEIGHBORS_LOOP:
movq (%r11), %r12
cmpq $0, %r12
je FIRST_DEGREE_NEIGHBORS_LOOP_CONT
cmpq %r12, (%rax)
je FOUND_CYCLE_RET_1

THIRD_DEGREE_NEIGHBORS_LOOP:
movq (%r12), %r13
cmpq $0, %r13
je SECOND_DEGREE_NEIGHBORS_LOOP_CONT
cmpq %r13, (%rax)
je FOUND_CYCLE_RET_1

FOURTH_DEGREE_NEIGHBORS_LOOP:
movq (%r13), %r14
cmpq $0, %r14
je THIRD_DEGREE_NEIGHBORS_LOOP_CONT
cmpq %r14, (%rax)
je FOUND_CYCLE_RET_1

FIFTH_DEGREE_NEIGHBORS_LOOP:
movq (%r14), %r8
cmpq $0, %r8
je FOURTH_DEGREE_NEIGHBORS_LOOP_CONT
cmpq %r8, (%rax)
je FOUND_CYCLE_RET_1

SIXTH_DEGREE_NEIGHBORS_LOOP:
movq (%r8), %r9
cmpq $0, %r9
je FIFTH_DEGREE_NEIGHBORS_LOOP_CONT
cmpq %r9, (%rax)
je FOUND_CYCLE_RET_1

SEVENTH_DEGREE_NEIGHBORS_LOOP:
movq (%r9), %r10
cmpq $0, %r10
je SIXTH_DEGREE_NEIGHBORS_LOOP_CONT
cmpq %r10, (%rax)
je FOUND_CYCLE_RET_1

EIGHTH_DEGREE_NEIGHBORS_LOOP:
movq (%r10), %r15
cmpq $0, %r15
je SEVENTH_DEGREE_NEIGHBORS_LOOP_CONT
cmpq %r15, (%rax)
je FOUND_CYCLE_RET_1

jmp FOUND_CYCLE_RET_1 #i'm not sure if this should be the found cycle or the no cycle jump

SEVENTH_DEGREE_NEIGHBORS_LOOP_CONT:
addq $8, %r9
jmp SEVENTH_DEGREE_NEIGHBORS_LOOP

SIXTH_DEGREE_NEIGHBORS_LOOP_CONT:
addq $8, %r8
jmp SIXTH_DEGREE_NEIGHBORS_LOOP

FIFTH_DEGREE_NEIGHBORS_LOOP_CONT:
addq $8, %r14
jmp FIFTH_DEGREE_NEIGHBORS_LOOP

FOURTH_DEGREE_NEIGHBORS_LOOP_CONT:
addq $8, %r13
jmp FOURTH_DEGREE_NEIGHBORS_LOOP

THIRD_DEGREE_NEIGHBORS_LOOP_CONT:
addq $8, %r12
jmp THIRD_DEGREE_NEIGHBORS_LOOP

SECOND_DEGREE_NEIGHBORS_LOOP_CONT: #this loop moves the neighbor of the neighbor of the current vertix
addq $8, %r11
jmp SECOND_DEGREE_NEIGHBORS_LOOP

FIRST_DEGREE_NEIGHBORS_LOOP_CONT: #this loop stays in the same current verix but moves to the next neighbor of this vertix
addq $8, %rbx
jmp FIRST_DEGREE_NEIGHBORS_LOOP

LOOP_THROUGH_VERTICES_CONT: #this loop moves to the next current vertix
addq $8, %rax
movq (%rax), %rbx
jmp LOOP_THROUGH_VERTICES


FOUND_CYCLE_RET_1:
movb $1, (circle)
jmp END_OF_HW1Q2_CODE

NO_CYCLE_RET_M1:
movb $-1, (circle)

END_OF_HW1Q2_CODE:
