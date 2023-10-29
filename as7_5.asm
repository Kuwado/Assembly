.data
M1: .asciiz "Phan tu lon nhat duoc luu o $s"
M2: .asciiz ", gia tri lon nhat la: "
M3: .asciiz "Phan tu nho nhat duoc luu o $s"
M4: .asciiz ", gia tri nho nhat la: "
M5: .asciiz "\n"
Ms0: .asciiz "Nhap phan tu $s0: "
Ms1: .asciiz "Nhap phan tu $s1: "
Ms2: .asciiz "Nhap phan tu $s2: "
Ms3: .asciiz "Nhap phan tu $s3: "
Ms4: .asciiz "Nhap phan tu $s4: "
Ms5: .asciiz "Nhap phan tu $s5: "
Ms6: .asciiz "Nhap phan tu $s6: "
Ms7: .asciiz "Nhap phan tu $s7: "
.text
main: 
	li $v0, 4
	la $a0, Ms0
	syscall
	li $v0, 5
	syscall
	move $s0, $v0
	sw $s0, -4($sp)
	li $v0, 4
	la $a0, Ms1
	syscall
	li $v0, 5
	syscall
	move $s1, $v0
	sw $s1, -12($sp)
	li $v0, 4
	la $a0, Ms2
	syscall
	li $v0, 5
	syscall
	move $s2, $v0
	sw $s2, -20($sp)
	li $v0, 4
	la $a0, Ms3
	syscall
	li $v0, 5
	syscall
	move $s3, $v0
	sw $s3, -28($sp)
	li $v0, 4
	la $a0, Ms4
	syscall
	li $v0, 5
	syscall
	move $s4, $v0
	sw $s4, -36($sp)
	li $v0, 4
	la $a0, Ms5
	syscall
	li $v0, 5
	syscall
	move $s5, $v0
	sw $s5, -44($sp)
	li $v0, 4
	la $a0, Ms6
	syscall
	li $v0, 5
	syscall
	move $s6, $v0
	sw $s6, -52($sp)
	li $v0, 4
	la $a0, Ms7
	syscall
	li $v0, 5
	syscall
	move $s7, $v0
	sw $s7, -60($sp)
	jal start			# (*)
	nop
print_max: 
	li $v0, 4
	la $a0, M1
	syscall	
	li $v0, 1
	add $a0, $t2, $zero
	syscall				# in M1
	li $v0, 4
	la $a0, M2
	syscall
	li $v0, 1
	add $a0, $k0, $zero
	syscall	
	li $v0, 4
	la $a0, M5
	syscall	
print_min: 
	li $v0, 4
	la $a0, M3
	syscall	
	li $v0, 1
	add $a0, $t3, $zero
	syscall				# in M1
	li $v0, 4
	la $a0, M4
	syscall
	li $v0, 1
	add $a0, $k1, $zero
	syscall	
quit: 
	li $v0, 10 			# thoát chương trình
 	syscall
 	
start:
	add $t0, $zero, $zero		# i = 0
store:
	sw $t0, 0($sp)			# cho i vao stack
	addi $t0, $t0, 1			# i = i+1
	slti $t1, $t0, 8			# neu i+1 < 8 --> $t1 = 1
	bne $t1, $zero, addsp		# lap den khi i = 8
	lw $k0, -4($sp)
	lw $t2, 0($sp)			# max ban dau =$s7
max:
	lw $t4, 8($sp)			# 
	lw $t3, 4($sp)			# phan tu de so sanh
	slt $t1, $t3, $k0		# neu $t3 < $k0 --> $t1 = 1
	bne $t1, $zero, addimax
	add $k0, $t3, $zero
	add $t2, $t4, $zero
	
addimax:	
	addi $sp, $sp, 8
	bgtz $t4, max
	
	lw $k1, -4($sp)
	lw $t3, 0($sp)
min:
	lw $t5, -8($sp)
	lw $t4, -12($sp)
	slt $t1, $k1, $t4		# neu $k1 < $t5 --> $t1 = 1
	bne $t1, $zero, addimin
	add $k1, $t4, $zero
	add $t3, $t5, $zero
	
addimin:
	addi $sp, $sp, -8
	slti $t1, $t5, 7			# neu $t5 < 7 --> $t1 =1
	bne $t1, $zero, min
	jr $ra

addsp:
	addi $sp, $sp, -8		# lui con tro stack
	j store
	
	
	
	
	
	
	
	
	
	
	
