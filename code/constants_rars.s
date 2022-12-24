.eqv sys_print_str 4
.eqv sys_exit 10

.data
hello:   .asciz "Hello World!\n"

.text
main:
	li   a7, sys_print_str
	la   a0, hello  # load address of string to print into a0
	ecall

	li   a7, sys_exit
	ecall
