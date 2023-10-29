.eqv KEY_CODE 0xFFFF0004 # ASCII code from keyboard, 1 byte
.eqv KEY_READY 0xFFFF0000 # =1 if has a new keycode ?
 # Auto clear after lw
.eqv DISPLAY_CODE 0xFFFF000C # ASCII code to show, 1 byte
.eqv DISPLAY_READY 0xFFFF0008 # =1 if the display has already to do
 # Auto clear after sw
.data
A: .asciiz "exit"
.text
 	li $k0, KEY_CODE
 	li $k1, KEY_READY
 	li $s0, DISPLAY_CODE
 	li $s1, DISPLAY_READY
 	la $s2, A
	li $s4, 0 
 
loop: 
	nop

WaitForKey: 
	lw $t1, 0($k1) # $t1 = [$k1] = KEY_READY
 	nop
 	beq $t1, $zero, WaitForKey # if $t1 == 0 then Polling
 	nop

ReadKey: 
	lw $t0, 0($k0) # $t0 = [$k0] = KEY_CODE
 	nop
 	jal check
 	nop

WaitForDis: 
	lw $t2, 0($s1) # $t2 = [$s1] = DISPLAY_READY
 	nop
 	beq $t2, $zero, WaitForDis # if $t2 == 0 then Polling
 	nop

Encrypt: 
	addi $t0, $t0, 1 # change input key

ShowKey: 
	sw $t0, 0($s0) # show key
 	nop
 	j loop
 	nop
 
check:
	add $s3, $s2, $s4
	lb $t3, 0($s3)
	sub $t4, $t3, $t0
	beqz $t4, next
	j new
	
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
	
	
