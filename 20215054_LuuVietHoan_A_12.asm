.data
M1: .asciiz "Nhap so nguyen duong N: "
M2: .asciiz "Bieu dien he co so 8 cua N la: "
M3: .asciiz "N khong phai la so nguyen duong."
M4: .asciiz "\n "
.text

main: 
	li $v0, 4
	la $a0, M1
	syscall
	li $v0, 5
	syscall
	move $t0, $v0
	li $v0, 4
	la $a0, M2
	syscall
	li $s0, 8			# $s0 = 8
	addi $t3, $sp, 0			# $t3 la dia chi $sp ban dau
	j start
	
print:
	
	li $v0, 1
	move $a0, $t1
	syscall
	j loadnext
	
printnot: 
	li $v0, 4
	la $a0, M3	
	syscall
	li $v0, 4
	la $a0, M4 	
	syscall
	j main
	
start:
	blez $t0, printnot
	div $t0, $s0			# chia cho 10 
	mfhi $t1				# so du 
	mflo $t0				# thuong 
	sw $t1, 0($sp)			# cat $t1 vao stack
	beqz $t0, load
	addi $sp, $sp, -4		# lui con tro stack	
	j start	
	
load:
	lw $t1, 0($sp)
	j print

loadnext:
	beq $sp, $t3, end		# neu con tro tro ve vi tri ban dau --> end
	addi $sp, $sp, 4			# con tro $sp
	j load
	
end:
	li $v0, 10
	syscall				# exit
	



