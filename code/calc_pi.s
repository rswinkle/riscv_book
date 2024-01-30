
.data

pi_float:  .float 3.14159265358979323846264338327950288 
pi_double: .double 3.14159265358979323846264338327950288


.text
main:
	# print best representation of pi as float
	li      a7, 2
	la      t0, pi_float
	flw     fa0, (t0)
	ecall

	li      a7, 11   # print char
	li      a0, 10   # '\n'
	ecall

	# calculate and print pi using floats to compare
	li      a0, 5000000
	jal     calc_pi_float

	li      a7, 2   # result from calc_pi already in fa0
	ecall

	li      a7, 11
	li      a0, 10   # '\n'
	ecall


	# print best representation of pi as double
	li      a7, 3
	la      t0, pi_double
	fld     fa0, 0(t0)
	ecall

	li      a7, 11
	li      a0, 10  # '\n'
	ecall

	# calculate and print pi using doubles to compare
	li      a0, 5000000
	jal     calc_pi_double


	li      a7, 3   # result from calc_pi_double already in fa0
	ecall

	li      a7, 11
	li      a0, 10  # '\n'
	ecall

	li      a7, 10     # exit ecall
	ecall



# float calc_pi_float(int iterations)
calc_pi_float:
	fmv.s.x  fa0, x0     # sum = 0 (0 integer == 0.0 float)

	# get 4 to 4.0 in ft1
	li       t0, 4
	fcvt.s.w ft1, t0

	li       t0, 1    # denominator
	fcvt.s.w ft2, t0  # ft2 = 1.0

	# 2 for add
	li       t0, 2
	fcvt.s.w ft3, t0  # ft3 = 2.0

	li       t0, 0     # negate = false, i = 0

gregory_leibniz_loop:

	fdiv.s   ft4, ft1, ft2   # ft4 = 4 / denom

	andi     t2, t0, 0x1
	beq      t2, x0, no_negate  # if (negate % 2 == 0) goto no_negate
	fneg.s   ft4, ft4

no_negate:
	fadd.s   fa0, fa0, ft4       # sum += term  (sum approaches pi)
	

	addi     t0, t0, 1     # negate++
	fadd.s   ft2, ft2, ft3   # denominator += 2
	blt      t0, a0, gregory_leibniz_loop  # while (negate aka i < iterations)

	# sum already in fa0 for return

	ret



# double calc_pi_double(int iterations)
calc_pi_double:
	fcvt.d.w fa0, x0    # sum = 0 (0 integer == 0.0 float)

	# get 4 to 4.0 in ft1
	li       t0, 4
	fcvt.d.w ft1, t0

	li       t0, 1    # denominator
	fcvt.d.w ft2, t0  # ft2 = 1.0

	# 2 for add
	li       t0, 2
	fcvt.d.w ft3, t0  # ft3 = 2.0

	li       t0, 0     # negate = false, i = 0

gregory_leibniz_loop_d:

	fdiv.d   ft4, ft1, ft2   # ft4 = 4 / denom

	andi     t2, t0, 0x1
	beq      t2, x0, no_negate_d  # if (negate % 2 == 0) goto no_negate_d
	fneg.d   ft4, ft4

no_negate_d:
	fadd.d   fa0, fa0, ft4       # sum += term  (sum approaches pi)
	

	addi     t0, t0, 1     # negate++
	fadd.d   ft2, ft2, ft3   # denominator += 2
	blt      t0, a0, gregory_leibniz_loop_d  # while (negate aka i < iterations)

	# sum already in fa0 for return

	ret
