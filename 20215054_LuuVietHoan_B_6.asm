.data
A: .space 100 
M1: .asciiz "Nhap so phan tu cua mang: "
M2: .asciiz "Nhap phan tu cua mang(bao gom so am): "
M3: .asciiz "Mang sau khi sap xep cac phan tu am giam dan: "
M4: .asciiz "  "
.text

main:
	li $v0, 4
	la $a0, M1
	syscall				# in chuoi M1
	li $v0, 5
	syscall
	move $t0, $v0			# $t0 la so phan tu cua mang
	li $s0, 0			# i = 0
	la $a3, A			# $a3 tro toi dia chi cua A[0]
	
nhappt:
	li $v0, 4
	la $a0, M2
	syscall
	li $v0, 5
	syscall
	move $t2, $v0			# $t2 la phan tu duoc nhap
	sll $s1, $s0, 2			# $s1 = 4i
	add $t3, $a3, $s1		# $t3 tro toi dia chi cua A[i]
	sw $t2, 0($t3)			# cat phan tu vao mang
	addi $s0, $s0, 1  
	slt $s2, $s0, $t0		# neu i < n --> $s2 = 1
	bnez $s2, nhappt
	
	li $v0, 4
	la $a0, M3
	syscall
	j start
	
print:
	li $s0, 0
printarr:
	sll $s1, $s0, 2				# $s1 = 4i
	add $s2, $a3, $s1			# $s2 tro to dia chi cua A[i]
	lw $t2, 0($s2)				# lay gia tri cua A[i] vao $t2
	li $v0, 1
	move $a0, $t2
	syscall
	li $v0, 4
	la $a0, M4
	syscall
	addi $s0, $s0, 1				# i = i + 1	
	slt $s3, $s0, $t0			# neu i < n --> $s3 = 1
	bnez $s3, printarr
	j end	
	
start:
	li $s1, 0				# i = 0
	li $s2, 0				# j = 0
	la $a3, A				# $a3 tro toi dia chi cua A[0]
	sll $k0, $t0, 2				# $k0 = 4n
	addi $k1, $t0, -1			# $k1 = n-1
run_i:
	sll $s4, $s1, 2				# $s4 = 4i
	add $t4, $s4, $a3			# $t4 tro toi dia chi cua A[i]
	lw $t1, 0($t4)				# $t1 = A[i] ( max ban dau )
	bgez $t1, next_i
	addi $s2, $s4, 4				# $s2 =4(i+1) --> j = i + 1
run_j:
	add $t5, $s2, $a3			# $t5 tro toi dia chi cua A[i+1]
	lw $t2, 0($t5)				# $t2 = A[j]
	bgez $t2, next_j
	slt $s3, $t1, $t2			# neu A[i] < A[j] --> $s3 = 1
	bnez $s3, exchange

next_j:
	addi $s2, $s2, 4				# $s2 = $s2 + 4
	beq $s2, $k0, next_i			# neu j = n --> tang i va lap lai
	j run_j
	
next_i:
	addi $s1, $s1, 1
	beq $s1, $k1, print
	j run_i
	

exchange:
	move $t3, $t1				# $t3 = $t1 
	move $t1, $t2				# $t1 = $t2 
	move $t2, $t3				# $t2 = $t1 
	sw $t1, 0($t4)
	sw $t2, 0($t5)
	j next_j 
	
end:
	li $v0, 10
	syscall					# exit
	
