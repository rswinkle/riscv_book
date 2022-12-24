#define sys_print_str 4
#define sys_exit 10

.data
hello:   .asciiz "Hello World!\n"

.text
main:
	li   a0, sys_print_str
	la   a1, hello  # load address of string to print into a1
	ecall

	li   a0, sys_exit
	ecall
