.data

test: .asciz "hello 1\n"

test2: .asciz "hello 2\n"


.text
main:
	li     t0, 1
	bltz   t0, label1

	li     a7, 4
	la     a0, test
	ecall

	j      exit_prog


label1:
	li     a7, 4
	la     a0, test2
	ecall

exit_prog:
	li     a7, 10     # exit ecall
	ecall
