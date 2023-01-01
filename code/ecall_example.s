.data

name:     .space 50

nameprompt:  .asciz "What's your name? "
hello_space: .asciz "Hello "
how_old:     .asciz "How old are you? "
ask_height:  .asciz "Enter your height in inches: "
ageplusheight: .asciz "Your age + height = "


.text
main:
	li    a7, 4      # print string
	la    a0, nameprompt  # load address of string to print into a7
	ecall

	li    a7, 8      # read string
	la    a0, name
	li    a1, 50
	ecall

	li    a7, 4
	la    a0, hello_space
	ecall

	la    a0, name  # note 4 is still in a7
	ecall

	# don't print a newline here because
	# one will be part of name unless they typed >48 characters

	li    a7, 4
	la    a0, how_old
	ecall

	li    a7, 5   # read integer
	ecall
	mv    t0, a0  # save age in t0

	li    a7, 4
	la    a0, ask_height
	ecall

	li    a7, 5   # read integer
	ecall
	add   t0, t0, a0 # t0 += height

	li    a7, 4
	la    a0, ageplusheight
	ecall

	li    a7, 1  # print int
	mv    a0, t0  # a0 = age + height
	ecall

	# print newline
	li    a7, 11   # print char
	li    a0, 10   # ascii value of '\n'
	ecall

	li    a7, 10     # exit ecall
	ecall
