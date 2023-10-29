.eqv KEY_CODE 0xFFFF0004 # ASCII code from keyboard, 1 byte
.eqv KEY_READY 0xFFFF0000 # =1 if has a new keycode ?
 # Auto clear after lw
.eqv DISPLAY_CODE 0xFFFF000C # ASCII code to show, 1 byte
.eqv DISPLAY_READY 0xFFFF0008 # =1 if the display has already to do
 # Auto clear after sw
.data
A: .asciiz "exit"
.text
main:
 	li $k0, KEY_CODE
 	li $k1, KEY_READY
 	li $s0, DISPLAY_CODE
 	li $s1, DISPLAY_READY
 	la $s2, A
	li $s4, 0
	
start:
	nop
	
WaitForKey: 
	lw $t1, 0($k1) 			# $t1 = [$k1] = KEY_READY
 	nop
 	beq $t1, $zero, WaitForKey 	# if $t1 == 0 then Polling
 	nop

ReadKey: 
	lw $t0, 0($k0) 			# $t0 = [$k0] = KEY_CODE
 	nop
 	jal check
 	nop
do_a_A:
	sub $t2, $t0, 'a'		# kiem tra chu thuong
	bltz $t2, do_A_a
	bgt $t2, 26, do_A_a
	addi $t0, $t0, -32		# doi chu thuong thanh chu hoa
	j WaitForDis
	
do_A_a:
	sub $t2, $t0, 'A'		# kiem tra chu hoa
	bltz $t2, do_09
	bgt $t2, 26, do_09
	addi $t0, $t0, 32		# doi chu hoa thanh chu thuong
	j WaitForDis

do_09:
	sub $t2, $t0, '0'		# kiem tra so 0-9
	bltz $t2, do_others
	bgt $t2, 9, do_others
	j WaitForDis			# giu nguyen
	
do_others:
	addi $t0, $zero, 42		# con lai chuyen ve * 

WaitForDis: 
	lw $t2, 0($s1) 			# $t2 = [$s1] = DISPLAY_READY
 	nop
 	beq $t2, $zero, WaitForDis 	# if $t2 == 0 then Polling
 	nop

ShowKey: 
	sw $t0, 0($s0) 			# show key
 	nop
 	j start
 	nop
 
check:
	add $s3, $s2, $s4		# so sanh ky tu nhap vao voi ky tu cua chuoi exit
	lb $t3, 0($s3)
	sub $t4, $t3, $t0
	beqz $t4, next			# neu ky tu giong thi tiep tuc
	j new				# khac thi reset lai
	
next: 
	addi $s4, $s4, 1
	beq $s4, 4, end
	jr $ra
	
new:
	li $s4, 0
	jr $ra
	
end:
	li $v0, 10
	syscall
	