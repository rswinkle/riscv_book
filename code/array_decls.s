

.data

array1: .word 0 : 10
array2: .word 0,1,2,3,4,5,6,7,8,9
array3: .space 40
array4: .word 42 : 10

array5: .byte 64 : 10

array6: .float 1.618 : 10
array7: .double 3.14159 : 10

.text

main:
	la     a0, array1
	li     a1, 10
	jal    print_int_array

	la     a0, array2
	li     a1, 10
	jal    print_int_array

	la     a0, array3
	li     a1, 10
	jal    print_int_array

	la     a0, array4
	li     a1, 10
	jal    print_int_array

	la     a0, array5
	li     a1, 10
	jal    print_char_array

	la     a0, array6
	li     a1, 10
	jal    print_float_array

	la     a0, array7
	li     a1, 10
	jal    print_double_array

	li     a7, 10     # exit ecall
	ecall


# void print_int_array(int* a, int size)
print_int_array:
	li    t0, 0
	bge   t0, a1, exit_pia

	mv    t1, a0  # move since we need a0 for ecalls

pia_loop:
	li    a7, 1
	lw    a0, 0(t1)
	ecall

	li    a7, 11
	li    a0, 32  # ' '
	ecall

	addi  t0, t0, 1  # i++
	addi  t1, t1, 4  # t1 = &a[i]
	blt   t0, a1, pia_loop

	li    a7, 11
	li    a0, 10  # '\n'
	ecall

exit_pia:
	ret



# void print_char_array(char* a, int size)
print_char_array:
	li    t0, 0
	bge   t0, a1, exit_pca

	mv    t1, a0  # move since we need a0 for ecalls

pca_loop:
	li    a7, 11
	lb    a0, 0(t1)
	ecall

	li    a7, 11
	li    a0, 32  # ' '
	ecall

	addi  t0, t0, 1  # i++
	addi  t1, t1, 1  # t1 = &a[i]
	blt   t0, a1, pca_loop

	li    a7, 11
	li    a0, 10  # '\n'
	ecall

exit_pca:
	ret

# void print_float_array(float* a, int size)
print_float_array:
	li    t0, 0
	bge   t0, a1, exit_pfa

	mv    t1, a0  # move since we need a0 for ecalls

pfa_loop:
	li    a7, 2
	flw   fa0, 0(t1)
	ecall

	li    a7, 11
	li    a0, 32  # ' '
	ecall

	addi  t0, t0, 1  # i++
	addi  t1, t1, 4  # t1 = &a[i]
	blt   t0, a1, pfa_loop

	li    a7, 11
	li    a0, 10  # '\n'
	ecall

exit_pfa:
	ret



# void print_double_array(double* a, int size)
print_double_array:
	li    t0, 0
	bge   t0, a1, exit_pda

	mv    t1, a0  # move since we need a0 for ecalls

pda_loop:
	li    a7, 3
	fld   fa0, 0(t1)
	ecall

	li    a7, 11
	li    a0, 32  # ' '
	ecall

	addi  t0, t0, 1  # i++
	addi  t1, t1, 8  # t1 = &a[i]
	blt   t0, a1, pda_loop

	li    a7, 11
	li    a0, 10  # '\n'
	ecall

exit_pda:
	ret
