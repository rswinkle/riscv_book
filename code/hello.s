.data
hello:   .asciz "Hello World!\n"

.text
main:
	li   a7, 4      # load immediate, a7 = 4 (4 is print string system call)
	la   a0, hello  # load address of string to print into a0
	ecall

	li   a7, 10     # exit ecall
	ecall
