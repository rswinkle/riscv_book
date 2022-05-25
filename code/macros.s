
.data

.macro sys_exit
li   a7, 10
ecall
.end_macro

.macro print_int_reg(%x)
	li    a7, 1
	mv    a0, %x
	ecall
.end_macro

.macro print_str_label(%x)
	li     a7, 4
	la     a0, %x
	ecall
.end_macro

.macro print_str(%str)
.data
str: .asciz %str
.text
	li     a7, 4
	la     a0, str
	ecall
.end_macro



str1:   .asciz "Hello 1\n"



.text

main:

	print_str_label(str1)

	print_str("Hello World!\n")

	li   t0, 42
	print_int_reg(t0)




	#sys_exit
	li   a7, 10
	ecall
