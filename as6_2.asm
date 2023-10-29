.data
A: .word 3, 1, -5, 2, 57, -7, 10, 1, -4, 30
Aend: .word
x: .asciiz", "
y: .asciiz "\n"
.text

main:
la $a2, A 				# $a2 trỏ tới địa chỉ của A[0]
la $a1, Aend				
addi $a1, $a1, -4 			# $a2 trỏ tới địa chỉ của A[n-1]
j sort 					

print: 
la $s2, A				# $s2 trỏ tới A[0]
li $s1, 10				# n-1 = 9 hay n = 10
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
	j sort
			

after_sort: 
li $v0, 10 				#exit
 	syscall

sort: 
beq $a2, $a1, done 		# nếu A[0] trùng A[n-1]  done
 	j max 					# nếu khác  max

after_max: 
	lw $t0, 0($a1) 			# $t0 = A[n-1] => giá trị cuối
 	sw $t0, 0($v0) 			# copy A[n-1] vào vị trí của max
 	sw $v1, 0($a1) 			# copy max vào vị trí cuối (n-1)
 	addi $a1, $a1, -4 			# n = n – 1 hay $a1 trỏ tới địa chỉ của A[n-2]
 	j print 				# in dãy sau khi hoàn thành 1 vòng
done: 
j after_sort
max:
addi $v0, $a2, 0 			# $v0 = $a2 => trỏ tới A[i] (i=0)
lw $v1, 0($v0) 			# $v1 = A[0] ( max khởi đầu )
addi $t0, $a2, 0 			# $t0 = $a2 => trỏ tới A[i] (i=0)
loop:
beq $t0, $a1, ret 			# nếu A[i] trùng A[n-1]  ret
addi $t0, $t0, 4 			# trỏ tới địa chỉ tiếp theo A[i+1]
lw $t1, 0($t0) 			# $t1 = A[i+1]
slt $t2, $t1, $v1 			# nếu (next) < (max) => $t2 = 1
bne $t2, $zero, loop 		#nếu (next) < (max) => lặp
addi $v0, $t0, 0 			# $v0 trỏ tới địa chỉ max mới 
addi $v1, $t1, 0 			# $v1 là giá trị max mới
j loop 					# vòng lặp
ret:
j after_max



