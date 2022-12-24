.data

there_are:  .asciiz "There are "
arguments:  .asciiz " command line arguments:\n"


.text

main:
	mv      t0, a0  # save argc
	mv      t2, a1  # save argv

	li      a0, 4           # print str
	la      a1, there_are
	ecall

	mv      a1, t0
	li      a0, 1   # print int
	ecall

	li      a0, 4
	la      a1, arguments
	ecall

	li      t1, 0   # i = 0
	j       arg_loop_test

arg_loop:
	li      a0, 4
	lw      a1, 0(t2)
	ecall

	li      a0, 11
	li      a1, 10    # '\n'
	ecall

	addi    t1, t1, 1   # i++
	addi    t2, t2, 4    # argv++ ie t2 = &argv[i]
arg_loop_test:
	blt     t1, t0, arg_loop  # while (i < argc)


	li      a0, 10
	ecall
