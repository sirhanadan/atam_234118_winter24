.globl my_ili_handler

.text
.align 4, 0x90
my_ili_handler:
  ####### Some smart student's code here #######
  
  #save context (because we switched to kernel space):
  
  pushq %rbp
  mov %rsp, %rbp
  
  pushq %rdi
  pushq %rsi
  pushq %rax
  pushq %rbx
  pushq %rcx
  pushq %rdx	
  pushq %r8
  pushq %r9
  pushq %r10
  pushq %r11
  pushq %r12
  pushq %r13
  pushq %r14
  pushq %r15
  
  #reset registers:
  xorq %rax, %rax #will hold the address of the instruction
  xorq %rdi, %rdi #will hold the invalid opcode
  xorq %rcx, %rcx #the return address
  
  
  
  #if an exception of type opcode fault occurs, the processor saves the address of the instruction that caused the fault into rip
  #the value of rip is saved on the stack right before we entered the handler
  #so basically it exists 8 bytes above rbp
  
  #load the address
  mov 8(%rbp), %rax
  
  #load the opcode
  mov 0(%rax), %dil
  
  #when dealing with an opcode of size 2 bytes at most:
  #if the first byte is 0x0F then it is one byte
  cmpb $0x0F, %dil
  jne one_byte_opcode
  
  #else: 2 bytes - the first one is irrelevant bc 0x0F
  mov 1(%rax), %dil
  inc %rcx #the return address would be 2 bytes after rax 
  
one_byte_opcode:
  inc %rcx #the return address would be 1 byte after rax
  add %rax, %rcx 
  
  #call the what_to_do function:
  #save the (only) registers we need:
  pushq %rdi
  pushq %rcx
  #####pushq %rax - no need because we saved the return address in rcx
  
  call what_to_do
  
  popq %rcx
  popq %rdi
  
  cmp $0, %rax
  jne cont_our_handler
  
  #continue with the original handler:
  
  #restore the registers:

  popq %r15
  popq %r14
  popq %r13
  popq %r12
  popq %r11
  popq %r10
  popq %r9
  popq %r8
  popq %rdx
  popq %rcx
  popq %rbx
  popq %rax
  popq %rsi
  popq %rdi
  popq %rbp
  #jump to old handler:
  jmp *old_ili_handler
  iretq


cont_our_handler:
	#the value of rdi is the ret_val of what_to_do
	mov %rax, %rdi
	mov %rcx, 8(%rbp) #rbp is the return address and in our case we saved it in rcx
	

  
  
  
  #restore the registers:

  popq %r15
  popq %r14
  popq %r13
  popq %r12
  popq %r11
  popq %r10
  popq %r9
  popq %r8
  popq %rdx
  popq %rcx
  popq %rbx
  popq %rax
  popq %rsi
  # popq %rdi
  # popq %rbp
  
  #addq $2, (%rsp) #??? ro ignore the last 2 pops
  
 
  
  iretq
