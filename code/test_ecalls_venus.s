
.data

testing:  .asciiz "\ntesting ecall "
num:  .asciiz "+14"

strbuf: .space 20

# both versions of venus support 5, atoi, fails and returns 0 if
# there is any white space before or after the number


.text

main:

	li      a0, 5
	la      a1, num
	ecall

	mv      a1, a0
	li      a0, 1           # print int
	ecall

	li      a0, 11
	li      a1, '\n'
	ecall

	li      t0, 1
	li      t1, 50
	li      t2, 10
	li      t3, 17
loop:
	li      a0, 4           # print str
	la      a1, testing
	ecall

	li      a0, 1           # print int
	mv      a1, t0
	ecall

	li      a0, 11
	li      a1, '\n'
	ecall

	beq     t0, t2, continue
	beq     t0, t3, continue   # skip both exit ecalls
	mv      a0, t0
	mv      a1, x0
	mv      a2, x0
	ecall

continue:

	addi    t0, t0, 1  # i++
	blt     t0, t1, loop



	li      a0, 10
	ecall

