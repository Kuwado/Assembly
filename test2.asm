.data
A: .word 0:20 
Aend: .word
M0: .asciiz "Nhap so phan tu:"
M1: .asciiz "Nhap phan tu: "
M2: .asciiz "Xau dao la: "
M3: .asciiz "\n"
x: .asciiz", "
y: .asciiz "\n"

.text
mainn:
	li $v0, 4
	la $a0, M0
	syscall
	li $v0, 5
	syscall
	move $t5, $v0                  	# So phan tu = n
	addi $t5, $t5, -1
 	add $t0,$zero,$zero		# $t0 = i = 0
get_string: 
 li $v0, 4
 la $a0, M1
 syscall 
 li $v0, 5
 syscall 
 move $t8, $v0
 la $a0, A
 add $s0, $t0, $t0			# $t0 = $t0 + 1 -> i = i + 1
 add $s0, $s0, $s0
 add $t1,$a0,$s0				# $t1 = $a0 + $t0 = address(string[i])
 sw $t8, 0($t1) 				# $v0 = string[i]
 addi $t0, $t0, 1			# $t0 = $t0 + 1 -> i = i + 1
 slt $t2, $t5, $t0 			# neu n<i --> $t2 = 1
 beq $t2, $zero,get_string 

main: 
la $a0, A                           	 # load địa chỉ của bảng A
addi $a1,$t5, 1    				 # $a1 = 5 (n = 5)

mspfx: 
addi $v0, $zero, 0     		# số phần tử của tổng $v0 = 0
 	addi $v1, $zero, 0                  	# tổng max $v1 = 0
 	addi $t0, $zero, 0               	# $t0 = 0 (i=0)
 	addi $t1, $zero, 0                  	# tổng chạy $t1 = 0
 
loop: 
 	add $t2, $t0, $t0                  	# $t2 = 2i
 	add $t2, $t2, $t2                   	# $t2 = 4i
 	add $t3, $t2, $a0                 	# gán địa chỉ của A[i] vào $t3 
 	lw $t4, 0($t3)                     	# $t4 = A[i]
add $t1, $t1, $t4         		# tổng chạy $t1 = $t1 = A[i]
 	slt $t5, $v1, $t1               		# $t5 = 1 nếu tổng max < tổng chạy ( $v0 < $t1)
 	bne $t5, $zero, mdfy               	# nếu tổng max nhỏ hơn  mdfy
 j test                                        		# nhảy đến test

mdfy: 
addi $v0, $t0, 1                 	# số phần tử $v0 = $t0 + 1 (i+1)
addi $v1, $t1, 0                       	# tổng max = tổng chạy ($v1 = $t1)

test: 
addi $t0, $t0, 1                         	# i = i + 1
slt $t5, $t0, $a1                       	# $t5 = 1 nếu  i < n
bne $t5, $zero, loop                   	# nếu i < n  lặp 
end:

