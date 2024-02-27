.global _start

.section .text
_start:
#your code here
xorq %rcx,%rcx 
 mov (character), %rcx 
# xorq %rbx ,%rbx
 cmp $49,%rcx
 je correct1
 cmp $50,%rcx
 je correct2
 cmp $51,%rcx
 je correct3
 cmp $52,%rcx
 je correct4
 cmp $53,%rcx
 je correct5
 cmp $54,%rcx
 je correct6
 cmp $55,%rcx
 je correct7
 cmp $56, %rcx
 je correct8
 cmp $57,%rcx
 je correct9
 cmp $48, %rcx
 je correct0
 cmp $96, %rcx
 je correct_tag
 cmp $97,%rcx
 jl correct_Less
 cmp $122,%rcx
 jg correct_Less
 subq $32,%rcx
 jmp end_HW1# in end we basically just do the last move that we move rcx to the "shifted"  memory label 
 correct_Less:
 cmp $45,%rcx
 je correct_First_Undefined# -
 cmp $61,%rcx
 je correct_Second_Undefined #=
 cmp $91,%rcx
 je correct_Third_Undefined # [
 cmp $93,%rcx
 je correct_Forth_Undefined # ]
 cmp $59,%rcx
 je correct_Fifth_Undefined # ;
 cmp $39, %rcx
 je correct_Sixth_Undefined # '
 cmp $47, %rcx
 je correct_Seventh_Undefined # /
 cmp $44,%rcx
 je correct_Eigth_Undefined #,
 cmp $46,%rcx
 je correct_Ninth_Undefined #.
 cmp $92,%rcx
 je correct_Tenth_Undefined #\
 jmp else_Last
 
 
 else_Last:
 movq $0xff,%rcx
 jmp end_HW1
 
 correct1:
 movq $33,%rcx #!
 jmp end_HW1
 
 
 correct2:
 movq $64,%rcx  #@
 jmp end_HW1
 
  correct3: # #
 movq $35,%rcx 
 jmp end_HW1
 
  correct4: # $
 movq $36,%rcx 
 jmp end_HW1
 
  correct5: # %
 movq $37,%rcx 
 jmp end_HW1
 
  correct6: # ^
 movq $94,%rcx 
 jmp end_HW1
 
  correct7: # &
 movq $38,%rcx 
 jmp end_HW1
 
  correct8: # *
 movq $42,%rcx 
 jmp end_HW1
 
  correct9: # (
 movq $40,%rcx 
 jmp end_HW1
 
  correct0: # )
 movq $41,%rcx 
 jmp end_HW1
 
  correct_tag: # ~ 
 movq $126,%rcx 
 jmp end_HW1
 
correct_First_Undefined: # _
 movq $95,%rcx 
 jmp end_HW1
 
 correct_Second_Undefined: # +
 movq $43,%rcx 
 jmp end_HW1
 
 correct_Third_Undefined: # {
 movq $123,%rcx 
 jmp end_HW1
 
  correct_Forth_Undefined: # }
 movq $125,%rcx 
 jmp end_HW1
 
 
  correct_Fifth_Undefined: #: 58 
 movq $58,%rcx 
 jmp end_HW1
 
 correct_Sixth_Undefined: #  "
 movq $34,%rcx 
 jmp end_HW1
                             
 correct_Seventh_Undefined: #  |
 movq $124,%rcx 
 jmp end_HW1
 
 
  correct_Eigth_Undefined: #  <
 movq $60,%rcx 
 jmp end_HW1
 
   correct_Ninth_Undefined: #  >
 movq $62,%rcx 
 jmp end_HW1
 
    correct_Tenth_Undefined: #  ?
 movq $63,%rcx 
 jmp end_HW1
 
 
 end_HW1:
 movq %rcx,shifted