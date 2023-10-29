.data
x: .space 21
string: .space 21
M1: .asciiz "Nhap ky tu: "
M2: .asciiz "Xau dao la: "
M3: .asciiz "\n"
.text
main:

 add $t0,$zero,$zero # $t0 = i = 0
 li $t5, 20
get_string: 
 li $v0, 4
 la $a0, M1
 syscall 
 li $v0, 12
 syscall 
 move $t8, $v0
 beq $t8, 10, re
 li $v0, 4
 la $a0, M3
 syscall

 la $a0, string
 add $t1,$a0,$t0 # $t1 = $a0 + $t0 = address(string[i])
 sb $t8, 0($t1) # $v0 = string[i]
 addi $t0, $t0, 1 # $t0 = $t0 + 1 -> i = i + 1
 sub $t7, $t0, $t5
 bgez $t7, re
 j get_string
re:

store: 
 subi $t7, $t0, 1
 li $t0, 0
 li $s0, 0
store1:
 la $a1, string
 add $t1,$s0,$a1        # $t1 = $s0 + $a1 = i + y[0] = address of y[i]
 lb $t2,0($t1)          # $t2 = value at $t1 = y[i]
 la $a0, x
 sub $s1, $t7, $s0      # $s1 = imax - i
 add $t3,$s1,$a0        # $t3 = $s1 + $a0 = imax - i + x[0] = address of x[imax - i]
 sb $t2,0($t3)          # x[i]= $t2 = y[i]
 beq $t2,$zero,end  # if y[i] == 0, exit
 nop
 addi $s0,$s0,1         # $s0 = $s0 + 1 <-> i = i + 1
 j store1                   # next character
 nop
end:
print_length: 
li $v0, 4
la $a0, M2
syscall

li $v0, 4
la $a0, x
syscall






