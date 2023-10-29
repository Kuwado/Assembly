.data
M1: .asciiz "Nhap so thu nhat: "
M2: .asciiz "Nhap so thu hai: "
M3: .asciiz "Nhap so thu ba: "
M4: .asciiz "Gia tri lon nhat: "
.text
main: 
	li $v0, 4
	la $a0, M1
	syscall			# in chuoi M1
	li $v0, 5
	syscall
	move $s1, $v0		# so thu nhat la $s1
	li $v0, 4
	la $a0, M2
	syscall			# in chuoi M2
	li $v0, 5
	syscall
	move $s2, $v0		# so thu hai la $s2
	li $v0, 4
	la $a0, M3
	syscall			# in chuoi M3
	li $v0, 5
	syscall
	move $s3, $v0		# so thu ba la $s3
 	li $v0,4
 	la $a0, M4
 	syscall
 	jal max 			# jump va link toi max
 	nop
 	add $a0, $zero, $v0	# $a0 = max
 	li $v0, 1
 	syscall
 	li $v0, 10 		# exit
 	syscall
endmain:

max: 
	add $v0,$s1,$zero 	# $v0 = $s1 ( $v0 la max )
 	sub $t0,$s2,$v0 		# $t0 = $s2 - $s1 (so sanh $s2 va $s1)
 	bltz $t0,okay 		# neu $s2 < $s1 --> okay
 	nop
 	add $v0,$s2,$zero	# neu $s2 > $s1 --> $v0 = $s2 ( max bay gio la $s2 ) 

okay: 
	sub $t0,$s3,$v0 		# $t0 = $s3 - $s2 ( so sanh $s3 va $s2 ) 
 	bltz $t0,done 		# neu $s3 < $s2 --> done
 	nop
 	add $v0,$s3,$zero 	# neu $s3 > $s2 --> $v0 = $s3 ( max bay gio la $s3 )
done: 
	jr $ra 			# nhay nguoc lai
