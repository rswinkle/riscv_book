
# RARS .data (like MARS) always starts at 0x10010000, whether pseudoinstructions
# are on or not.

.data

there_are:  .asciz "There are "
arguments:  .asciz " command line arguments:\n"

.text

.globl main
main:
	or        t0, x0, a0  # save argc

	ori       a7, x0, 4

	#la        a0, there_are
	lui       a0, 0x10010    # there_are is at beginning of data so just lui, lower is 0
	ecall

	or        a0, x0, t0
	ori       a7, x0, 1   # print int
	ecall

	ori       a7, x0, 4
	lui       a0, 0x10010
	ori       a0, a0, 11   # 11 is length in bytes of "There are " 10 chars + '\0'
	#la        a0, arguments
	ecall

	ori       t1, x0, 0   # i = 0
	#j         arg_loop_test
	jal       x0, arg_loop_test

arg_loop:
	ori       a7, x0, 4     # print string for argv[i]
	lw        a0, 0(a1)
	ecall

	ori       a7, x0, 11
	ori       a0, x0, 10    # '\n'
	ecall

	addi      t1, t1, 1    # i++
	addi      a1, a1, 4    # argv++ ie a1 = &argv[i]
arg_loop_test:
	blt       t1, t0, arg_loop  # while (i < argc)

	ori       a7, x0, 10
	ecall
