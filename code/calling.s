.data
hello:   .asciz "Hello World!\n"
name:    .asciz "Robert"

.text
main:
	jal     hello_world

	# simulating the jal call above manually
	la      ra, next_instr
	j       hello_world
next_instr:

	la      a0, name
	li      a1, 15
	jal     hello_name_number

	# return value already in a0
	li      a7, 1     # so we don't overwrite it and lose it
	ecall

	li      a7, 11    # print char
	li      a0, 10    # '\n'
	ecall

	jal     save_vals

	li      a7, 11    # print char
	li      a0, 10    # '\n'
	ecall

	li      s0, 0     # i = 0 (I can use s regs without saving because I exit from main, rather than return)
	li      s1, 10
fib_loop:
	mv      a0, s0
	jal     fib         # fib(i)

	# return val already in a0
	li      a7, 1      # print int
	ecall

	li      a7, 11    # print char
	li      a0, 32    # ' '
	ecall
	
	addi    s0, s0, 1   # i++
	blt     s0, s1, fib_loop  # while (i < 10)

	li      a7, 11    # print char
	li      a0, 10    # '\n'
	ecall

	li      s0, 0     # i = 0
fib2_loop:
	mv      a0, s0
	jal     fib2         # fib2(i)

	li      a7, 1      # print int, print(fib2(i))
	ecall

	li      a7, 11    # print char
	li      a0, 32    # ' '
	ecall
	
	addi    s0, s0, 1   # i++
	blt     s0, s1, fib2_loop    # while (i < 10)

	li      a7, 11    # print char
	li      a0, 10    # '\n'
	ecall

	li      a7, 10     # exit ecall
	ecall




# void hello_world()
hello_world:
	li   a7, 4      # print string system call
	la   a0, hello  # load address of string to print into a0
	ecall

	ret

.data
hello_space:  .asciz "Hello "
exclaim_nl:   .asciz "!\n"

.text
#int hello_name_number(char* name, int number)
hello_name_number:
	mv      t0, a0   # save name in t0 since we need a0 for the ecall

	li      a7, 4        # print string
	la      a0, hello_space
	ecall

	mv      a0, t0    # print name (a7 is still 4)
	ecall

	la      a0, exclaim_nl
	ecall


	addi    a0, a1, 10  # return number+10
	ret



#void print_letters(char letter, int count)
print_letters:
	ble     a1, x0, exit_pl   # if (count <= 0) goto exit_pl
	li      a7, 11            # print character
pl_loop:
	ecall
	addi    a1, a1, -1       # count--
	bgt     a1, x0, pl_loop   # while (count > 0)

	li      a0, 10            # '\n'
	ecall
	
exit_pl:
	ret


#int save_vals()
save_vals:
	addi    sp, sp, -12
	sw      ra, 0(sp)
	sw      s0, 4(sp)
	sw      s1, 8(sp)

	li      s0, 0  # i = 0
	li      s1, 10
sv_loop:
	addi    a0, s0, 65   # i + 'A'
	addi    a1, s0, 1    # i + 1
	jal     print_letters

	addi    s0, s0, 1        # i++
	blt     s0, s1, sv_loop  # while (i < 10)

	lw      ra, 0(sp)
	lw      s0, 4(sp)
	lw      s1, 8(sp)
	addi    sp, sp, 12
	ret




#int fib(int n)
fib:
	addi    sp, sp, -8
	sw      ra, 0(sp)
	sw      s0, 4(sp)

	# n already in a0 for immediate return
	li      t0, 1
	ble     a0, t0, exit_fib  # if (n <= 1) goto exit_fib (ie return n)

	mv      s0, a0        # save n

	addi    a0, a0, -2
	jal     fib             # fib(n-2)

	addi    t0, s0, -1    # calc n-1 first so we can use s0 to save fib(n-2)
	mv      s0, a0        # save return of fib(n-2) in s0
	mv      a0, t0        # copy n-1 to a0
	jal     fib             # fib(n-1)

	add     a0, a0, s0   #  a0 = fib(n-1) + fib(n-2)

exit_fib:
	lw      ra, 0(sp)
	lw      s0, 4(sp)
	addi    sp, sp, 8
	ret

# identical to fib() except a tiny bit more efficient by saving 6 instructions
# any time n is <= 1
#int fib2(int n)
fib2:
	li      t0, 1
	ble     a0, t0, exit_fib2  # if (n <= 1) goto exit_fib2 (ie return n)

	addi    sp, sp, -8
	sw      ra, 0(sp)
	sw      s0, 4(sp)

	mv      s0, a0        # save n

	addi    a0, a0, -2
	jal     fib2             # fib2(n-2)

	addi    t0, s0, -1    # calc n-1 first so we can use s0 to save v0
	mv      s0, a0        # save return of fib(n-2) in s0
	mv      a0, t0        # copy n-1 to a0
	jal     fib2            # fib2(n-1)

	add     a0, a0, s0   #  a0 = fib2(n-1) + fib2(n-2)

	lw      ra, 0(sp)
	lw      s0, 4(sp)
	addi    sp, sp, 8
exit_fib2:
	ret
