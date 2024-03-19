.globl my_ili_handler

.text
.align 4, 0x90
my_ili_handler:
  ####### Some smart student's code here #######
  
  #save context (because we switched to kernel space):
  
  push %rbp
  mov %rsp, %rbp
  
  #push %rdi
  push %rsi
  push %rax
  push %rbx
  push %rcx
  push %rdx	
  push %r8
  push %r9
  push %r10
  push %r11
  push %r12
  push %r13
  push %r14
  push %r15
  push %rdi
  
  #reset registers:
  xor %rax, %rax #will hold the address of the instruction
  xor %rdi, %rdi #will hold the invalid opcode
  xor %rcx, %rcx #the return address
  xor %rbx, %rbx #apparently the return value is incorrect so i'll use this instead of %dil
  
  
  
  #if an exception of type opcode fault occurs, the processor saves the address of the instruction that caused the fault into rip
  #the value of rip is saved on the stack right before we entered the handler
  #so basically it exists 8 bytes above rbp from the frame
  
  #load the address
  mov 8(%rbp), %rax
  
  #load the opcode
  mov 0(%rax), %bl
  
  #when dealing with an opcode of size 2 bytes at most:
  #if the first byte is 0x0F then it is one byte
  cmp $0x0F, %bl
  jne one_byte_opcode
  
  #else: 2 bytes - the first one is irrelevant bc 0x0F
  mov 1(%rax), %bl
  inc %rcx #the return address would be 2 bytes after rax 
  
one_byte_opcode:
  inc %rcx #the return address would be 1 byte after rax
  add %rax, %rcx 
  
  #call the what_to_do function:
  #save the (only) registers we need:
  mov %rbx, %rdi
  push %rdi
  push %rsi
  push %rax
  push %rbx
  push %rcx
  push %rdx	
  push %r8
  push %r9
  push %r10
  push %r11
  #####pushq %rax - no need because we saved the return address in rcx
  
  call what_to_do
  
  pop %r11
  pop %r10
  pop %r9
  pop %r8
  pop %rdx
  pop %rcx
  pop %rbx
  pop %rax
  pop %rsi
  pop %rdi
  
  cmp $0, %rax
  jne cont_our_handler
  
  #continue with the original handler:
  
  #restore the registers:

  pop %rdi
  pop %r15
  pop %r14
  pop %r13
  pop %r12
  pop %r11
  pop %r10
  pop %r9
  pop %r8
  pop %rdx
  pop %rcx
  pop %rbx
  pop %rax
  pop %rsi
  #pop %rdi
  pop %rbp
  #jump to old handler:
  jmp *old_ili_handler
  iretq


cont_our_handler:
	#the value of rdi is the ret_val of what_to_do
	mov %rax, %rdi
	mov %rcx, 8(%rbp) #rbp is the return address and in our case we saved it in rcx
	
  
  #restore the registers:

  #pop %rdi
  pop %r15 #should have been pop rdi but we want the changed value of rdi
  pop %r15
  pop %r14
  pop %r13
  pop %r12
  pop %r11
  pop %r10
  pop %r9
  pop %r8
  pop %rdx
  pop %rcx
  pop %rbx
  pop %rax
  pop %rsi
  #pop %rdi
  pop %rbp
  
  #add $2, (%rsp) 
  
 
  
  iretq
