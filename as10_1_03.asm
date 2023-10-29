.eqv SEVENSEG_LEFT 0xFFFF0011	# Dia chi cua den led 7 doan trai.
 				# Bit 0 = doan a;
 				# Bit 1 = doan b; ...
				# Bit 7 = dau .
.eqv SEVENSEG_RIGHT 0xFFFF0010 	# Dia chi cua den led 7 doan phai
.data
M1: .asciiz "Nhap ky tu: "
M2: .asciiz "Ma ascii cua ky tu la: "
M3: .asciiz "\n"
.text
start: 
	li $v0, 4
	la $a0, M1
	syscall
	li $v0, 12
	syscall 
	move $t0, $v0			# so ky tu vao
	li $v0, 4
	la $a0, M3
	syscall
	li $v0, 4
	la $a0, M2
	syscall
	li $v0, 1
	move $a0, $t0
	syscall
	
last:
	li $t1, 10
	div $t0, $t1
	mfhi $t2				# so du
	sw $t2, 0($sp)			# cat chu so cuoi cung vao stack
	mflo $t0				# thuong
	div $t0, $t1
	mfhi $t2				# so du 
	sw $t2, -4($sp)			# cat chu so thu 2 tu duoi len vao stack
	
take:
	lw $t1, -4($sp)			# chu so thu 2 tu duoi len
	lw $t2, 0($sp)			# chu so cuoi cung
	move $t3, $t1
	jal check
	nop
	jal SHOW_7SEG_LEFT
	nop
	move $t3, $t2
	jal check
	nop
	jal SHOW_7SEG_RIGHT
	nop
 
exit: 
	li $v0, 10
 	syscall
endmain:

SHOW_7SEG_LEFT: 
	li $t0, SEVENSEG_LEFT 		# assign port's address
 	sb $a0, 0($t0) 			# assign new value
 	nop
	jr $ra
	nop

SHOW_7SEG_RIGHT: 
	li $t0, SEVENSEG_RIGHT	 	# assign port's address
 	sb $a0, 0($t0) 			# assign new value
 	nop
	jr $ra
 	nop
 	
check:
	beq $t3, 0, check0
	beq $t3, 1, check1
	beq $t3, 2, check2
	beq $t3, 3, check3
	beq $t3, 4, check4
	beq $t3, 5, check5
	beq $t3, 6, check6
	beq $t3, 7, check7
	beq $t3, 8, check8
	beq $t3, 9, check9
	
check0: 
	li $a0, 63
	jr $ra
check1: 
	li $a0, 6
	jr $ra
check2: 
	li $a0, 91
	jr $ra
check3: 
	li $a0, 79
	jr $ra
check4: 
	li $a0, 102
	jr $ra
check5: 
	li $a0, 109
	jr $ra
check6: 
	li $a0, 125
	jr $ra
check7: 
	li $a0, 7
	jr $ra
check8: 
	li $a0, 127
	jr $ra
check9: 
	li $a0, 111
	jr $ra

