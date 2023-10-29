.data
A: .word 0:20
Message: .asciiz "So phan tu cua mang la: "
Meg1: .asciiz "Prefix Sum: "
Meg2: .asciiz "\nlength: "
.text
	add $t7, $zero, $zero
	add $t6, $zero, $zero
main:
	la $a2, A
	#li $a1, 5
	jal input
	j mspfx
	nop
continue:
	li $v0, 4
	la $a0, Meg1
	syscall
	li $v0, 1
	move $a0, $v1
	syscall
	li $v0, 4
	la $a0, Meg2
	syscall
	li $v0, 1
	move $a0, $s5
	syscall
lock:	
	li $v0, 10
	syscall
end_of_main:
input:
	li $v0, 51
	la $a0, Message
	syscall
	move $a1, $a0
input2:
	sll $t8, $t7, 2
	add $t5, $t8, $a2
	li $v0, 5
	syscall
	sw $v0, 0($t5)
	addi $t7, $t7, 1
	beq $t7, $a1, end
	j input2
end:	
	jr $ra
mspfx: 	
	addi $s5, $zero, 0 #initialize length to 0
	addi $v1, $zero, 0 #initialize max sum to 0
	addi $t0, $zero, 0 #initialize the index i to 0
	addi $t1, $zero, 0 #initialize 	the running sum in $t1 to 0
loop:
	add $t2, $t0, $t0 #put 2i in $t2
	add $t2, $t2, $t2 #put 4i in $t2
	add $t3, $t2, $a2 #put 4i + A (address of A{i}) in $t3
	lw $t4, 0($t3) #load A{i} from mem(t3) into $t4
	add $t1, $t1, $t4 #add A{i} to running sum in $t1
	slt $t5, $v1, $t1 #set $t5 to 1 if max sum < new sum
	bne $t5, $zero, mdfy #if max sum is less, modify results
	j test #done?
mdfy: 
	addi $s5, $t0, 1 #new max-sum prefix has length i + 1
	addi $v1, $t1, 0 #new max sum is running sum
test:
	addi $t0, $t0, 1 #advance the index i
	slt $t5, $t0, $a1 #set $t5 to 1 if i < n
	bne $t5, $zero, loop #repeat if i < n
done: j continue
mspfx_end: