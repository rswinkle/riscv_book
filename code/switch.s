.data

a_str:  .asciz "Excellent job!\n"
b_str:  .asciz "Good job!\n"
c_str:  .asciz "At least you passed?\n"
d_str:  .asciz "Probably should have dropped it...\n"
f_str:  .asciz "Did you even know you were signed up for the class?\n"

invalid_str:  .asciz "You entered an invalid grade!\n"

enter_grade:  .asciz "Enter your grade (capital): "

switch_labels: .word a_label, b_label, c_label, d_label, default_label, f_label

.text

main:

	li      a7, 4
	la      a0, enter_grade
	ecall

	li      a7, 12    # read char
	ecall

	li      t2, 5    # f is at index 5

	la      t0, switch_labels
	addi    t1, a0, -65   # t1 = grade - 'A'
	blt     t1, x0, default_label   # if (grade-'A' < 0) goto default
	bgt     t1, t2, default_label  # if (grade-'A' > 5) goto default

	slli    t1, t1, 2     # offset *= 4 (sizeof(word))
	add     t0, t0, t1    # t0 = switch_labels + byte_offset = &switch_labels[grade-'A']
	lw      t0, 0(t0)     # load address from jump table
	jr      t0            # jump to address

a_label:
	la      a0, a_str
	j       end_switch

b_label:
	la      a0, b_str
	j       end_switch

c_label:
	la      a0, c_str
	j       end_switch
	
d_label:
	la      a0, d_str
	j       end_switch

f_label:
	la      a0, f_str
	j       end_switch

default_label:
	la      a0, invalid_str


end_switch:
	li      a7, 4
	ecall

	li      a7, 10   # exit
	ecall

