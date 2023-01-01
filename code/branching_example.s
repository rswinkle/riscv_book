.data
prompt:    .asciz "Enter your score: "
grade_str: .asciz "You got a "

.text
main:
	li     a7, 4    # print str
	la     a0, prompt
	ecall

	li     a7, 5    # read int
	ecall

	mv     t0, a0   # move score into t0
	li     t1, 70   # letter_grade default to 'F' ascii value
	
	li     t2, 90
	blt    t0, t2, not_a    # if (score < 90) goto not_a
	li     t1, 65           # leter_grade = 'A'
	j      grade_done

not_a:
	li     t2, 80
	blt    t0, t2, not_b    # if (score < 80) goto not_b
	li     t1, 66           # leter_grade = 'B'
	j      grade_done

not_b:
	li     t2, 70
	blt    t0, t2, not_c    # if (score < 70) goto not_c
	li     t1, 67           # leter_grade = 'C'
	j      grade_done

not_c:
	li     t2, 60
	blt    t0, t2, grade_done   # if (score < 60) goto grade_done
	li     t1, 68               # leter_grade = 'D'

grade_done:
	li     a7, 4      # print str
	la     a0, grade_str
	ecall

	li     a7, 11      # print character
	mv     a0, t1      # char to print
	ecall

	li     a0, 10    # print '\n'
	ecall

	li     a7, 10    # exit
	ecall
