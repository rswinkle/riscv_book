.data
hello:   .asciz "Hello World!\n"

.text
main:
	li    a7, 4      # print string system call
	la    a0, hello  # load address of string to print into a1
	ecall

	li    a7, 10     # exit syscall
	ecall

