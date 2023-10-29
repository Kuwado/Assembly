.data
A: .word 4,3,2,10,12,1,5,6
Aend: .word
x: .asciiz", "
y: .asciiz "\n"
.text

start:
li $s1, 8				# n = 9
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
	j ij


main:
la $a2, A 				# $a2 trỏ tới địa chỉ của A[0]
add $s7, $a2, $zero			# $s7 tro toi A[0]
la $a1, Aend				
ij: 
addi $a2, $a2, 4				# $a2 trỏ tới địa chỉ của A[i] (i=1)
addi $t0, $a2, -4			# $t0 tro toi dia chi A[j] (j=i-1)
lw $t1, 0($a2)				# $t1 = A[i]
beq $a2, $a1, done			# Neu dia chi A[i] trung voi A[n] --> done

sort: 
slt $s6, $t0, $s7			# neu dia chi A[j] < A[0] --> $s6 = 1
bne $s6, $zero, step
lw $t2, 0($t0)				# $t2 = A[j]
slt $s5, $t1, $t2			# neu A[i] < A[j] --> $s5 = 1
beq $s5, $zero, step			# neu A[i] >= A[j] --> step
sw $t2, 4($t0)				# A[j+1] = A[j]
addi $t0, $t0, -4			# j=j-1
j sort
step:
sw $t1, 4($t0)				# A[j+1] = A[i]
j print
done:















