
.data

in2cm: .float 2.54

fahrenheit2celsius: .float 0.5555555

sixft: .float 72.0

prompt_height: .asciz "Enter your height in inches (doesn't have to be integer): "
prompt_temp:   .asciz "Enter the temperature in fahrenheit (doesn't have to be integer): "

height_in_cm:  .asciz "Your height in centimeters: "
temp_in_C:     .asciz "The temperature in Celsius is: "

at_least72: .asciz "You are at least 6 ft tall\n"

shorter_than72: .asciz "You are less than 6 ft tall\n"

.text

main:
	li       a7, 4
	la       a0, prompt_height
	ecall

	li       a7, 6    # read float
	ecall

	la       t0, sixft
	flw      ft0, 0(t0)    # get 72.0

	li       a7, 4
	la       a0, shorter_than72   # preset for ecall, default shorter

	flt.s    t0, fa0, ft0
	bne      t0, x0, print_ht_str   # if (height < 72.0) goto print_ht_str

	la       a0, at_least72   # otherwise set a0 to >= string

print_ht_str:
	ecall           # print taller/shorter str


	# read float is already in fa0
	jal      convert_in2cm

	li       a7, 4
	la       a0, height_in_cm
	ecall

	# print cm height already in fa0
	li       a7, 2     # print float
	ecall

	li       a7, 11  # print char
	li       a0, 10   # '\n'
	ecall

	li       a7, 4
	la       a0, prompt_temp
	ecall

	li       a7, 6    # read float
	ecall

	# put read float already in fa0
	jal      convert_F2C

	li       a7, 4
	la       a0, temp_in_C
	ecall

	# print degrees C already in fa0
	li       a7, 2     # print float
	ecall

	li       a7, 11  # print char
	li       a0, 10   # '\n'
	ecall

	li       a7, 10
	ecall



# float convert_in2cm(float inches)
convert_in2cm:
	la       t0, in2cm
	flw      ft0, 0(t0)    # get conversion factor

	fmul.s   fa0, ft0, fa0  # fa0 = 2.54 * inches

	ret

# float convert_F2C(float degrees_f)
convert_F2C:
	la       t0, fahrenheit2celsius
	flw      ft0, 0(t0)    # get conversion factor

	# C = (F - 32) * 5/9
	li       t0, 32
	fcvt.s.w ft1, t0       # convert to 32.0

	fsub.s   fa0, fa0, ft1  # fa0 = degrees_f - 32
	fmul.s   fa0, ft0, fa0  # fa0 = 0.555555 * fa0

	ret
