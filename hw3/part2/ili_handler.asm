.globl my_ili_handler

.text
.align 4, 0x90
my_ili_handler:
  ####### Some smart student's code here #######
  
  #save context (because we switched to kernel space):
  
  pushq %rbp
  mov %rsp, %rbp
  
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
  
  
  
  #if an exception of type error occurs, the processor saves the address of the instruction that caused the fault into rip
  #the value of rip is saved on the stack right before we entered the handler
  #so basically it exists 8 bytes above rbp
  
  #load the address
  mov 8(%rbp), %rax
  
  #load the opcode
  mov 0(%rax), %dl
  
  #when dealing with an opcode of size 2 bytes at most:
  #if the first byte is 0x0F then it is one byte
  cmpb $0x0F, %dl
  
  
  
  
  
  
  
  
  
  
  
  
  
  
 
  
  
  iretq
