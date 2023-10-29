.eqv MONITOR_SCREEN 0x10010000
.eqv RED            0x00FF0000
.eqv GREEN          0x0000FF00
.data 
x1: .asciiz "Nhap toa do x1: " 
y1: .asciiz "Nhap toa do y1: "
x2: .asciiz "Nhap toa do x2: "
y2: .asciiz "Nhap toa do y2: "
notx: .asciiz "x1 phai khac x2!. Moi nhap lai: \n"
noty: .asciiz "y1 phai khac y2!. Moi nhap lai: \n"
.text 

nhap:
	li $v0, 4
	la $a0, x1
	syscall
	li $v0, 5
	syscall
	move $t1, $v0			#$t1 la x1
	li $v0, 4
	la $a0, y1
	syscall
	li $v0, 5
	syscall
	move $s1, $v0			#$s1 la y1
	li $v0, 4
	la $a0, x2
	syscall
	li $v0, 5
	syscall
	move $t2, $v0			#$t2 la x2
	li $v0, 4
	la $a0, y2
	syscall
	li $v0, 5
	syscall
	move $s2, $v0			#$s2 la y2
	beq $t1, $t2, printnotx
	beq $s1, $s2, printnoty
	j startx
printnotx:
	li $v0, 4
	la $a0, notx
	syscall
	j nhap
	
printnoty:
	li $v0, 4
	la $a0, noty
	syscall
	j nhap

startx:
	blt $t1, $t2, starty
	move $t3, $t1
	move $t1, $t2
	move $t2, $t3
	
starty:
	blt $s1, $s2, start
	move $s3, $s1
	move $s1, $s2
	move $s2, $s3

start:
	li $k1, MONITOR_SCREEN
	addi $s4, $t1, 0
	addi $s5, $s1, 0
	
color_ngang:
	sll $t7, $s4, 2
	sll $t8, $s1, 5
	sll $t9, $s2, 5
	add $a3, $k1, $t7
	add $a3, $a3, $t8
	jal RED1
	nop
	add $a3, $k1, $t7
	add $a3, $a3, $t9
	jal RED1
	nop
	beq $s4, $t2, color_doc
	addi $s4, $s4, 1
	j color_ngang
	
color_doc:
	sll $t7, $s5, 5
	sll $t8, $t1, 2
	sll $t9, $t2, 2
	add $a3, $k1, $t7
	add $a3, $a3, $t8
	jal RED1
	nop
	add $a3, $k1, $t7
	add $a3, $a3, $t9
	jal RED1
	nop
	beq $s5, $s2, next
	addi $s5, $s5, 1
	j color_doc 

next:
	addi $t3, $t1, 1
	addi $s1, $s1, 1

	
color_nen:
	beq $s1, $s2, exit
	beq $t3, $t2, nexty
	sll $t7, $t3, 2
	sll $t8, $s1, 5
	add $a3, $k1, $t7
	add $a3, $a3, $t8
	jal GREEN1
	nop
	addi $t3, $t3, 1
	j color_nen
	
nexty:
	addi $s1, $s1, 1
	addi $t3, $t1, 1
	j color_nen



RED1: 
	li $t4, RED
 	sw $t4, 0($a3)
 	jr $ra
GREEN1: 
	li $t4, GREEN
 	sw $t4, 0($a3)
 	jr $ra
 	
exit:
	li $v0,10
	syscall