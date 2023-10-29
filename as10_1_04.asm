.eqv MONITOR_SCREEN 0x10010000
.eqv RED            0x00FF0000
.eqv BLUE           0x000000FF
.text 

start:
	li $k1, MONITOR_SCREEN  		#Nap dia chi bat dau cua man hinh
	li $s0, 0			# i la hang
	li $t0, 2
do:
	li $s1, 1
	div $s0, $t0
	mfhi $t1
	bnez $t1, do_le
	li $s1, 0
do_chan:
	sll $s2, $s0, 5
	sll $s3, $s1, 2
	add $a3, $k1, $s2		
	add $a3, $a3, $s3 		# $a3 la dia chi cua o thu i
	jal RED1
	nop
	addi $s1, $s1, 2
	beq $s1, 8, next_do
	j do_chan
	
do_le:
	sll $s2, $s0, 5
	sll $s3, $s1, 2
	add $a3, $k1, $s2		
	add $a3, $a3, $s3 		# $a3 la dia chi cua o thu i
	jal RED1
	nop
	addi $s1, $s1, 2
	beq $s1, 9, next_do
	j do_le
	
next_do: 
	addi $s0, $s0, 1
	beq $s0, 8, next_color
	j do
	
next_color:
	li $s0, 0

xanh:
	li $s1, 1
	div $s0, $t0
	mfhi $t1
	beqz $t1, xanh_le
	li $s1, 0
	
xanh_chan:
	sll $s2, $s0, 5
	sll $s3, $s1, 2
	add $a3, $k1, $s2		
	add $a3, $a3, $s3 		# $a3 la dia chi cua o thu i
	jal BLUE1
	nop
	addi $s1, $s1, 2
	beq $s1, 8, next_xanh
	j xanh_chan
	
xanh_le:
	sll $s2, $s0, 5
	sll $s3, $s1, 2
	add $a3, $k1, $s2		
	add $a3, $a3, $s3 		# $a3 la dia chi cua o thu i
	jal BLUE1
	nop
	addi $s1, $s1, 2
	beq $s1, 9, next_xanh
	j xanh_le
	
next_xanh: 
	addi $s0, $s0, 1
	beq $s0, 8, exit
	j xanh
	
	
RED1: 
	li $t4, RED
 	sw $t4, 0($a3)
 	jr $ra
BLUE1: 
	li $t4, BLUE
 	sw $t4, 0($a3)
 	jr $ra
 	
exit:
	li $v0,10
	syscall