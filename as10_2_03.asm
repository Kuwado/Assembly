.eqv HEADING 0xffff8010 			# Integer: An angle between 0 and 359
.eqv MOVING 0xffff8050 			# Boolean: whether or not to move
.eqv LEAVETRACK 0xffff8020 		# Boolean (0 or non-0):
 					# whether or not to leave a track
.eqv WHEREX 0xffff8030 			# Integer: Current x-location of MarsBot
.eqv WHEREY 0xffff8040 			# Integer: Current y-location of MarsBot

.eqv KEY_CODE 0xFFFF0004 			# ASCII code from keyboard, 1 byte
.eqv KEY_READY 0xFFFF0000 		# =1 if has a new keycode ?
 					# Auto clear after lw
.eqv DISPLAY_CODE 0xFFFF000C 		# ASCII code to show, 1 byte
.eqv DISPLAY_READY 0xFFFF0008 		# =1 if the display has already to do
 					# Auto clear after sw
 					
.text
main:
 	li $k0, KEY_CODE
 	li $k1, KEY_READY
 	li $s0, DISPLAY_CODE
 	li $s1, DISPLAY_READY
 	li $t7, 0

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
	beq $t0, 32, runn		# menu kiem tra chuc nang
	beq $t0, 87, W_up
	beq $t0, 119, W_up
	beq $t0, 65, A_right
	beq $t0, 97, A_right
	beq $t0, 68, D_left
	beq $t0, 100, D_left
	beq $t0, 83, S_down
	beq $t0, 115, S_down
	jr $ra


runn:
	beq $t7, 0, run			# neu $t7 = 0 bat dau chay
	beq $t7, 1, stop			# neu $t7 = 1 dung lai
	nop

run:
	addi $a0, $zero, 180     
 	jal ROTATE
 	nop
 	jal GO
 	nop
 	jal TRACK # draw track line
	nop
	li $t7, 1
	j WaitForDis
	
stop:
	jal STOP
	nop
	li $t7, 0
	j WaitForDis

W_up:
	jal UNTRACK 
 	nop
	jal TRACK 
	nop
	addi $a0, $zero, 0     
	jal ROTATE
 	nop
 	j WaitForDis

A_right:
	jal UNTRACK
 	nop
	jal TRACK 
	nop
	addi $a0, $zero, 270      
	jal ROTATE
 	nop
	j WaitForDis
	
D_left:
	jal UNTRACK 
 	nop
	jal TRACK 
	nop
	addi $a0, $zero, 90      
	jal ROTATE
 	nop
	j WaitForDis
	
S_down:
	jal UNTRACK
 	nop
	jal TRACK 
	nop
	addi $a0, $zero, 180     
	jal ROTATE
 	nop
	j WaitForDis	
	
#-----------------------------------------------------------
# GO procedure, to start running
# param[in] none
#-----------------------------------------------------------
GO: li $at, MOVING # change MOVING port
 addi $s2, $zero,1 # to logic 1,
 sb $s2, 0($at) # to start running
 nop
 jr $ra
 nop
#-----------------------------------------------------------
# STOP procedure, to stop running
# param[in] none
#-----------------------------------------------------------
STOP: li $at, MOVING # change MOVING port to 0
 sb $zero, 0($at) # to stop
 nop
 jr $ra
 nop
#-----------------------------------------------------------
# TRACK procedure, to start drawing line
# param[in] none
#-----------------------------------------------------------
TRACK: li $at, LEAVETRACK # change LEAVETRACK port
 addi $s2, $zero,1 # to logic 1,
 sb $s2, 0($at) # to start tracking
 nop
 jr $ra
 nop
#-----------------------------------------------------------
# UNTRACK procedure, to stop drawing line
# param[in] none
#-----------------------------------------------------------
UNTRACK:li $at, LEAVETRACK # change LEAVETRACK port to 0
 sb $zero, 0($at) # to stop drawing tail
 nop
 jr $ra
 nop
#-----------------------------------------------------------
# ROTATE procedure, to rotate the robot
# param[in] $a0, An angle between 0 and 359
# 0 : North (up)
# 90: East (right)
# 180: South (down)
# 270: West (left)
#-----------------------------------------------------------
ROTATE: li $at, HEADING # change HEADING port
 sw $a0, 0($at) # to rotate robot
 nop
 jr $ra
 nop
 
end:
	li $v0, 10
	syscall
