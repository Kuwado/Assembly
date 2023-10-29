.data
Message: .asciiz "Ket qua tinh giai thua la: "
.text
main: 
	jal WARP
print: 
	add $a1, $v0, $zero 		# $v0 = n!
 	li $v0, 56
 	la $a0, Message
 	syscall				# in
quit: 
	li $v0, 10 			# thoát chương trình
 	syscall
endmain:
WARP: 
	sw $fp, -4($sp)		 	# lưu địa chỉ con trỏ frame vào stack
 	addi $fp, $sp, 0 		# con trỏ frame mới $fp = $sp
 	addi $sp, $sp, -8 		# điều chỉnh con trỏ stack $sp ( lùi 2 ô)
 	sw $ra, 0($sp) 			# lưu địa chỉ return $ra vào stack
 	li $a0, 3 			# giá trị của n 
 	jal FACT 			# jump và link tới FACT
 	nop
 	lw $ra, 0($sp) 			# lấy địa chỉ $ra ra từ trong stack
 	addi $sp, $fp, 0 		# trả về con trỏ stack $sp ban đầu
 	lw $fp, -4($sp) 			# trả về con trỏ frame $fp ban đầu
 	jr $ra
wrap_end:
FACT: 
	sw $fp, -4($sp) 			# lưu địa chỉ của $fp vào stack
 	addi $fp, $sp, 0	 		# con trỏ frame mới $fp = $sp 
 	addi $sp, $sp, -12 		# lùi 3 ô cho $fp, $a0, $ra trong stack
 	sw $ra, 4($sp) 			# lưu địa chỉ $ra vào stack
 	sw $a0, 0($sp) 			# lưu giá trị $a0 vào stack
 	slti $t0, $a0, 2 		# nếu $a0 < 2  $t0 = 1
 	beq $t0, $zero, recursive	# nếu $a0 >= 2  recursive
 	nop
 	li $v0, 1 			# đưa $v0 về 1
 	j done
 	nop
recursive:
 	addi $a0, $a0, -1 		# giảm $a0 1 đơn vị: $a0 = $a0 - 1
	jal FACT 			# nhảy ngược về FACT và link lại
 	nop
 	lw $v1, 0($sp) 			# $v1 = $a0
 	mult $v1, $v0 			# lo = $v1 * $v0
 	mflo $v0				# $v0 = $v1 * $v0
done: 
	lw $ra, 4($sp) 			# lấy lại địa chỉ $ra từ stack
 	lw $a0, 0($sp) 			# lấy lại $a0 từ stack
 	addi $sp, $fp,0 			# trả lại con trỏ stack trước đó
 	lw $fp, -4($sp) 			# trả lại con trỏ frame trước đó
 	jr $ra 				# nhảy ngược lại $ra
fact_end:
