.global _start


.section .text
_start:

#your code here
xorq %r15,%r15# temp
xorq %r14,%r14# pointer for command number 1
xorq %r13,%r13# pointer for command number 2
xorq %rbx,%rbx
xorq %r8,%r8# our number
movb command,%r15b
findNumberPart1_Hw1:# we dont have to check for the validity of the instruction
cmpb $0x20, %r15b
je findNumberWithoutSpaces_Hw1
inc %r14
movb command(,%r14,1),%r15b
jmp findNumberPart1_Hw1

findNumberWithoutSpaces_Hw1:
cmpb $0x20, %r15b
jne isLegalLabel
inc %r14
movb command(,%r14,1),%r15b
jmp findNumberWithoutSpaces_Hw1


isLegalLabel:
cmp $0x24 ,%r15b
jne isntLegal_hw1
inc %r14
movb command(,%r14,1),%r15b
cmpb $0x30,%r15b
je binaryOrHexaOrOctal
cmpb $0x30,%r15b
jne Decimal


Decimal:
movq %r14,%r13
last_digit_decimal:
inc %r13
movb command(,%r13,1),%r15b
cmpb $0x2C, %r15b
jne last_digit_decimal

dec %r13
movb command(,%r13,1),%r15b
cmpb $0x30,%r15b
jl isntLegal_hw1
cmpb $0x39,%r15b
jg isntLegal_hw1
and $0xFF , %r15
subq $0x30, %r15
movq %r15, %r8
dec %r13
cmp %r14 , %r13
jl BinaryLegal_Hw1
movb command(,%r13,1),%r15b
cmpb $0x30,%r15b
jl isntLegal_hw1
cmpb $0x39,%r15b
jg isntLegal_hw1
and $0xFF , %r15
subq $0x30, %r15
imul $10,%r15,%r15
add %r15,%r8
dec %r13
cmp %r14 , %r13
jl BinaryLegal_Hw1
movb command(,%r13,1),%r15b
cmpb $0x30,%r15b
jl isntLegal_hw1
cmpb $0x39,%r15b
jg isntLegal_hw1
and $0xFF , %r15
subq $0x30, %r15
imul $100,%r15,%r15
add %r15,%r8
jmp BinaryLegal_Hw1



binaryOrHexaOrOctal:
inc %r14
movb command(,%r14,1),%r15b
inc %r14 #we arrice to the right section with our lsb
cmpb $0x78,%r15b
je hexa_Hw1
cmpb $0x62,%r15b
je binary_Hw1
dec %r14
jmp octal_Hw1



hexa_Hw1:
mov %r14,%r13
findLSB_hexa_Hw1:
movb command(,%r13,1),%r15b
cmpb $0x2c,%r15b
je foundHexaLsb_Hw1
inc %r13
jmp findLSB_hexa_Hw1

foundHexaLsb_Hw1:
dec %r13
movb command(,%r13,1),%r15b
cmpb $0x30,%r15b
jl isntLegal_hw1
cmpb $0x46,%r15b
jg isntLegal_hw1
cmpb $0x41,%r15b
jge letters
cmp $0x39,%r15b
jle numbers
jmp isntLegal_hw1
#בשביל להקל עליכם תניחו שהA-F של ההקסא הנתונים בטסטים יהיו רק באותיות גדולות ושהגדרת הבסיס(0x, 0b) יהיו רק באותיות קטנות

letters:
and $0xFF , %r15b
subq $0x37, %r15
movq %r15, %r8
jmp second

numbers:

and $0xFF , %r15b
subq $0x30, %r15
movq %r15, %r8
second:
dec %r13
cmp %r14 , %r13
jl BinaryLegal_Hw1
movb command(,%r13,1),%r15b
cmpb $0x30,%r15b
jl isntLegal_hw1
cmpb $0x46,%r15b
jg isntLegal_hw1
cmpb $0x41,%r15b
jge letters2
cmp $0x39,%r15b
jle numbers2
jmp isntLegal_hw1

letters2:
and $0xFF , %r15b
subq $0x37, %r15
shl $4 , %r15
add %r15, %r8
jmp third

numbers2:


and $0xFF , %r15b

subq $0x30, %r15
shl $4 , %r15
add %r15, %r8
 jmp third


third:

dec %r13
cmp %r14 , %r13
jl BinaryLegal_Hw1
movb command(,%r13,1),%r15b
cmpb $0x30,%r15b
jl isntLegal_hw1
cmpb $0x46,%r15b
jg isntLegal_hw1
cmpb $0x41,%r15b
jge letters3
cmp $0x39,%r15b
jle numbers3
jmp isntLegal_hw1

letters3:
and $0xFF , %r15b
subq $0x37, %r15
shl $8 , %r15
add %r15, %r8
jmp BinaryLegal_Hw1

numbers3:

and $0xFF , %r15b

subq $0x30, %r15
shl $8 , %r15
add %r15, %r8
 jmp BinaryLegal_Hw1


binary_Hw1:

movq %r14,%r13
findLSB_Binary_Hw1:
movb command(,%r13,1),%r15b
cmpb $0x2c,%r15b
je foundBinaryLsb_Hw1
inc %r13
jmp findLSB_Binary_Hw1
foundBinaryLsb_Hw1:
dec %r13
notLoopBinary_Hw1:
cmp %r14,%r13
jl BinaryLegal_Hw1
movb command(,%r13,1),%r15b
cmpb $0x30,%r15b # see if its 0
je legalBinary1
cmpb $0x31,%r15b # see if its 0
je legalBinary1
jne isntLegal_hw1
legalBinary1:
and $0xFF , %r15b
subq $0x30, %r15
movq %r15, %r8
dec %r13# second number if exists
cmp %r14,%r13
jl BinaryLegal_Hw1
movb command(,%r13,1),%r15b
cmpb $0x30,%r15b # see if its 0
je legalBinary2
cmpb $0x31,%r15b # see if its 0
je legalBinary2
jne isntLegal_hw1
legalBinary2:
and $0xFF , %r15d
subq $0x30, %r15
shl %r15
add %r15, %r8

dec %r13
cmp %r14,%r13
jl BinaryLegal_Hw1
movb command(,%r13,1),%r15b
cmpb $0x30,%r15b # see if its 0
je legalBinary3
cmpb $0x31,%r15b # see if its 0
je legalBinary3
jne isntLegal_hw1
legalBinary3:
and $0xFF , %r15d
subq $0x30, %r15
shl $0x2, %r15
add %r15, %r8
jmp BinaryLegal_Hw1




BinaryLegal_Hw1:
movb $1 , (legal)
movl %r8d , (integer)
jmp end_HW1



octal_Hw1:
movq %r14,%r13
lastDigit_HW1:
inc %r13
movb command(,%r13,1),%r15b
cmpb $0x2C, %r15b
jne lastDigit_HW1

dec %r13
OctalBegin:
movb command(,%r13,1),%r15b
cmpb $0x30 , %r15b
jl isntLegal_hw1
cmpb $0x37 , %r15b
jg isntLegal_hw1

and $0xFF , %r15d
subq $0x30, %r15
movq %r15, %r8

dec %r13
cmpb %r14b,%r13b
jl BinaryLegal_Hw1
movb command(,%r13,1),%r15b
cmpb $0x30 , %r15b
jl isntLegal_hw1
cmpb $0x37 , %r15b
jg isntLegal_hw1
and $0xFF , %r15d
subq $0x30, %r15
shl $3, %r15
add %r15, %r8
dec %r13
cmpb %r14b,%r13b
jl BinaryLegal_Hw1
movb command(,%r13,1),%r15b
cmpb $0x30 , %r15b
jl isntLegal_hw1
cmpb $0x37 , %r15b
jg isntLegal_hw1
and $0xFF , %r15d
subq $0x30, %r15
shl $6, %r15
add %r15, %r8
jmp BinaryLegal_Hw1



isntLegal_hw1:
movb $0 ,%bl
movb %bl ,(legal)
jmp end_HW1


end_HW1:
