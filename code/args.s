
.data

there_are:  .asciz "There are "
arguments:  .asciz " command line arguments:\n"


.text

main:
	mv      t0, a0  # save argc

	li      a7, 4
	la      a0, there_are
	ecall

	mv      a0, t0
	li      a7, 1   # print int
	ecall

	li      a7, 4
	la      a0, arguments
	ecall

	li      t1, 0   # i = 0
	j       arg_loop_test

arg_loop:
	li      a7, 4
	lw      a0, 0(a1)
	ecall

	li      a7, 11
	li      a0, 10    # '\n'
	ecall

	addi    t1, t1, 1   # i++
	addi    a1, a1, 4    # argv++ ie a1 = &argv[i]
arg_loop_test:
	blt     t1, t0, arg_loop  # while (i < argc)


	li      a7, 10
	ecall
