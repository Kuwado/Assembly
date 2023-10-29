.data
xhA: .space 104	  		# mang dem so lan xuat hien chu hoa cua A
xhB: .space 104			# mang dem so lan xuat hien chu hoa cua B
A: .space 100 
B: .space 100
M1: .asciiz "Nhap xau A: "
M2: .asciiz "Nhap xau B: "
M3: .asciiz "Cac ky tu hoa xuat hien trong ca A va B la: "
M4: .asciiz "  "
.text

main:
	li $v0, 4
	la $a0, M1
	syscall
 	li $v0, 8
 	la $a0, A
 	li $a1, 100
 	syscall 					# doc chuoi A
	li $v0, 4
	la $a0, M2
	syscall
 	li $v0, 8
 	la $a0, B
 	li $a1, 100
 	syscall 					# doc chuoi B
 	li $v0, 4
 	la $a0, M3
 	syscall
 	j start
 	
print:
	li $v0, 11
 	move $a0, $t4
 	syscall 
 	li $v0, 4
 	la $a0, M4
 	syscall
 	j next3




start:
	la $t0, A				# $t0 tro toi dia chi A[0]		
	la $t1, B				# $t1 tro toi dia chi B[0]
	la $s2, xhA				# $s0 tro toi dia chi xhA[0]
	la $s1, xhB				# $s1 tro toi dia chi xhB[0]
	li $s0, 0				# i =0
	li $s6, 0
	li $s7, 26
	add $t2, $zero, 'A'			# $t2 = 65 

storeA:
	add $k0, $t0, $s0			# $k0 tro toi dia chi cua A[i]
	lb $t3, 0($k0)				# lay ki tu luu vao $t3
	beqz $t3, next
	sub $t4, $t3, $t2			# $t4 = $t3 - $t2 neu $t4 = 0-->25 thi la chu hoa
	bltz $t4, nextA
	slt $s5, $t4, $s7			# neu $t3 < 26 --> $s5 = 1
	beqz $s5, nextA
	sll $t5, $t4, 2				# $t5 = 4$t4
	add $t6, $s2, $t5			# $t6 tro toi dia chi xhA[$t4]
	lw $t7, 0($t6)				# lay gia tri ra
	addi $t7, $t7, 1				# cong them 1 
	sw $t7, 0($t6)				# luu lai
nextA:	
	addi $s0, $s0, 1
	j storeA

next:
	li $s0, 0
	li $t7, 0
storeB:
	add $k0, $t1, $s0			# $k0 tro toi dia chi cua B[i]
	lb $t3, 0($k0)				# lay ki tu luu vao $t3
	beqz $t3, next2
	sub $t4, $t3, $t2			# $t4 = $t3 - $t2 neu $t4 = 0-->25 thi la chu hoa
	bltz $t4, nextB
	slt $s5, $t4, $s7			# neu $t3 < 26 --> $s5 = 1
	beqz $s5, nextB
	sll $t5, $t4, 2				# $t5 = 4$t4
	add $t6, $s1, $t5			# $t6 tro toi dia chi xhB[$t4]
	lw $t7, 0($t6)				# lay gia tri ra
	addi $t7, $t7, 1				# cong them 1 
	sw $t7, 0($t6)				# luu lai
	
nextB:
	addi $s0, $s0, 1
	j storeB
	
next2:
	li $s0, 0
	
com:		
	sll $s3, $s0, 2				# $s3 = 4i
	add $k0, $s2, $s3			# $k0 tro toi dia chi xhA[i]
	add $k1, $s1, $s3			# $k1 tro toi dia chi xhB[i]
	lw $t2, 0($k0)				# lay so lan xuat hien cua chu hoa tu xhA
	lw $t3, 0($k1)				# lay so lan xuat hien cua chu hoa tu xhB
	beqz $t2, next3				# neu xhA[i] = 0 --> next
	beqz $t3, next3				# neu xhB[i] = 0 --> next
	add $t4, $s0, 'A'
	j print			
	
next3:
	addi $s0, $s0, 1
	beq $s0, $s7, end
	j com
	
end:
	li $v0, 10
	syscall					# exit
	
	
	
	
	
	
	
	
	
	
