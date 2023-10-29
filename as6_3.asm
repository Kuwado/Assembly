.data
A: .word 2,5,10,6,-1,8,7,4,3
Aend: .word
x: .asciiz", "
y: .asciiz "\n"
.text

start:
li $s1, 9				# n = 9
	j main
print: 
la $s2, A				# $s2 trỏ tới A[0]
li $s0, 0      				# i = 0
j print2
print3:
li $v0, 4
la $a0, x				
syscall				# in chuỗi x
print2:
add $s3, $s0, $s0    		# $s0 = 2i
add $s3, $s3, $s3    		# $s0 = 4i
add $s3, $s2, $s3    		# $s3 trỏ tới địa chỉ A[i]
lw $a0, 0($s3)       			# $a0 = A[i]
li $v0, 1
syscall				# in phần tử của mảng
addi $s0, $s0, 1       		# i = i + 1
slt $s4, $s0, $s1   			# nếu i < n --> $s2 = 1
bne $s4, $zero, print3    		# nếu i < n --> print3
end:
li $v0, 4
la $a0, y
syscall				# in chuỗi y
	j step

main:
addi $t0, $zero, 0			# $t0 = i = 0
la $a1, A				# $a1 trỏ tới địa chỉ của A[0]

step:
subi $t4, $s1, 1			# $t4 = n - 1
slt $t7, $t0, $t4			# nếu i < n-1 --> $t7 = 1
beq $t7, $zero, end2		# nếu i >= n - 1 --> end
addi $t0, $t0, 1			# i = i + 1
addi $t1, $zero, 0			# $t1 = j = 0
sort:
sub $t4, $s1, $t0			# $t4 = n - 1 - i
slt $s7, $t1, $t4			# nếu j < n - 1 - i --> $s7 = 1
beq $s7, $zero, print		# nếu j >= n - 1 - i --> 
add $s5, $t1, $t1			# $s5 = 2j
add $s5, $s5, $s5			# $s5 = 4j
add $s5, $s5, $a1			# $s5 trỏ tới địa chỉ của A[j]
addi $s6, $s5, 4			# $s6 trỏ tới địa chỉ của A[j+1]
lw $t5, 0($s5)			# $s7 = A[j]
lw $t6, 0($s6)			# $s6 = A[j+1]
slt $t2, $t6, $t5			# nếu A[j+1] < A[j] --> $t2 = 1
bne $t2, $zero, swap		# nếu A[j+1] < A[j] --> swap

continue:
addi $t1, $t1, 1			# j = j + 1
j sort

swap:
	lw $t3, 0($s5) 			# $t3 = A[j] 
 	sw $t3, 0($s6) 			# A[j+1] = $t3 = A[j]
 	sw $t6, 0($s5)			# A[j] = A[j+1]
 	j continue

end2:
