.data
	CharPtr: 	.word 0		# Bien con tro, tro toi kieu asciiz
	BytePtr: 	.word 0		# Bien con tro, tro toi kieu Byte
	WordPtr: 	.word 0		# Bien con tro, tro toi mang kieu Word
	ArrayPtr: 	.word 0		# Bien con tro, tro toi mang hai chieu
	CharPtr1: 	.word 0		# Bien con tro, dung trong yeu cau copy xau
	CharPtr2: 	.word 0		# Bien con tro, dung trong yeu cau copy xau
	Newline: 	.asciiz 	"\n"
	row:		.word 1	
	col:		.word 1
	menu: 		.asciiz 	"\n Chon chuc nang tu 1-11, an so nguyen khac de thoat\n1. Malloc CharPtr.\n2. Malloc BytePtr.\n3. Malloc WordPtr.\n4. Lay gia tri cua cac bien con tro.\n5. Lay dia chi cua cac bien con tro.\n6. Copy 2 con tro xau ki tu.\n7. Giai phong bo nho.\n8. Tinh toan bo nho da cap phat.\n9. Malloc Array.\n10. Set Array[i][j].\n11. Get Array[i][j]."
	char_str:	.asciiz	"\nNhap so phan tu cua mang kieu Char (>0): "
	byte_str:	.asciiz 	"\nNhap so phan tu cua mang kieu Byte (>0): "
	word_str:	.asciiz 	"\nNhap so phan tu cua mang kieu Word (>0): "
	copy_str:	.asciiz 	"\nXau da duoc copy: "
	free_mem:	.asciiz "\nDa giai phong bo nho"
	nb_row:		.asciiz 	"\nNhap so hang cua mang: "
	nb_col:		.asciiz 	"\nNhap so cot cua mang: "
	input_row:	.asciiz 	"\nNhap i (so thu tu cua dong): "
	input_col:	.asciiz 	"\nNhap j (so thu tu cua cot): "
	input_val:	.asciiz 	"\nNhap gia tri gan cho phan tu cua mang: "
	output_val:	.asciiz 	"\nGia tri tra ve: "
	address_str:	.asciiz 	"\nDia chi cua bien con tro CharPtr | BytePtr | WordPtr | ArrayPtr la: "
	value_str:	.asciiz 	"\nGia tri cua bien con tro CharPtr | BytePtr | WordPtr | ArrayPtr la: "
	malloc_str:	.asciiz 	"\nBo nho da cap phat: "
	bytes_str:	.asciiz 	" bytes"
	input_str:	.asciiz 	"\nNhap vao mot xau ky tu: "
	malloc_success:	.asciiz	"\nCap phat bo nho thanh cong.\n Mang bat dau tai dia chi: "
	int_error:	.asciiz 	"\nError: Vui long nhap so nguyen."
	mal_error:	.asciiz 	"\nError: So hang hoac so cot phai nho hon 1000"
	bound_error:	.asciiz 	"\nError: Ngoai vung bo nho cho phep cua mang"
	null_error:	.asciiz 	"\nError: Chua khoi tao mang"
	overflow_error:	.asciiz 	"\nError: Gia tri input qua lon (> 2000)"
	zero_error:	.asciiz 	"\nError: Gia tri input phai lon hon 0"
	string_copy:	.space	100	# Xau copy

.kdata
	# Luu gia tri la dia chi dau tien cua vung nho con trong
	Sys_TheTopOfFree: 	.word 1
	# Vung khong gian tu do, dung de cap phat bo nho cho cac bien con tro
	Sys_MyFreeSpace:	

.text
	# Khoi tao vung nho cap phat dong
	jal	SysInitMem
	
main:
print_menu:
	la 	$a0, menu
	jal	integer_input		
	move 	$s0, $a0		
	beq	$s0, 1, option1
	beq	$s0, 2, option2
	beq	$s0, 3, option3
	beq	$s0, 4, option4
	beq	$s0, 5, option5
	beq	$s0, 6, option6
	beq	$s0, 7, option7
	beq	$s0, 8, option8
	beq	$s0, 9, option9
	beq	$s0, 10, option10
	beq 	$s0, 11, option11
	j	end
	
option1:					# cap phat cho con tro kieu char 
	la 	$a0, char_str
	jal	integer_input		# kiem tra so phan tu nhap vao co phai so nguyen khong
	jal	check_input		# kiem tra gia tri input (0 < input < 2000)
	move	$a1, $a0			# Luu input (so phan tu cua mang) vao $a1
	la	$a0, CharPtr		# Luu dia chi cua CharPtr vao $a0
	li	$a2, 1			# Kich thuoc Char = 1 byte
	jal	malloc			# Cap phat bo nho 
	move	$s0, $v0			# Luu gia tri tra ve cua ham malloc vao $s0
	la	$a0, malloc_success	# Thong bao cap phat thanh cong
	li	$v0, 4			# print string service
	syscall
	move	$a0, $s0			# Chuyen gia tri tu $s0 vao $a0
	li	$v0, 34			# print integer in hexadecimal service
	syscall				# in ra gia tri integer cua $a0
	j 	main

option2:					# Malloc Byte
	la	$a0, byte_str
	jal	integer_input		# kiem tra so phan tu nhap vao co phai so nguyen khong
	jal	check_input		# kiem tra gia tri input (0 < input < 2000)
	move	$a1, $a0			# Luu input (so phan tu cua mang) vao $a1
	la	$a0, BytePtr		# Luu dia chi cua BytePtr vao $a0
	li	$a2, 1			# Kich thuoc Byte = 1 byte
	jal	malloc			# Cap phat bo nho
	move	$s0, $v0			# Luu gia tri tra ve cua ham malloc vao $s0
	la	$a0, malloc_success	# Thong bao cap phat thanh cong
	li	$v0, 4			# print string service
	syscall
	move	$a0, $s0			# Chuyen gia tri tu $s0 vao $a0
	li	$v0, 34			# print integer in hexadecimal service
	syscall
	j	main
			

option3:					# Malloc Word
	la	$a0, word_str
	jal	integer_input		# kiem tra so phan tu nhap vao co phai so nguyen khong
	jal	check_input		# kiem tra gia tri input (0 < input < 2000)
	move	$a1, $a0			# Luu input (so phan tu cua mang) vao $a1
	la	$a0, WordPtr		# Luu dia chi cua WordPtr vao $a0
	li	$a2, 4			# Kich thuoc Word = 4 bytes
	jal	malloc			# Cap phat bo nho
	move	$s0, $v0			# Luu gia tri tra ve cua ham malloc vao $s0
	la	$a0, malloc_success	# Thong bao cap phat thanh cong
	li	$v0, 4			# print string service
	syscall
	move 	$a0, $s0			# Chuyen gia tri tu $s0 vao $a0
	li	$v0, 34			# print integer in hexadecimal service
	syscall
	j	main

option4:					# ham tra ve gia tri cua bien con tro
	la	$a0, value_str
	li	$v0, 4			# print string service
	syscall
	li	$a0, 0			
	jal	ptr_value		# Lay gia tri cua CharPtr
	jal 	print_value    			

	li 	$a0, 1
	jal 	ptr_value             	# Lay gia tri cua BytePtr
	jal 	print_value   			

	li 	$a0, 2
	jal 	ptr_value             	# Lay gia tri cua WordPtr
	jal 	print_value    			

	li 	$a0, 3
	jal 	ptr_value              	# Lay gia tri cua ArrayPtr
	jal 	print_value   			

	j 	main

option5:					# ham lay dia chi cua bien con tro 
	la 	$a0, address_str		
	li 	$v0, 4			# print string service
	syscall

	li 	$a0, 0			# Lay dia chi cua CharPtr
	jal 	ptr_address				
	jal 	print_value

	li 	$a0, 1			# Lay dia chi cua BytePtr
	jal 	ptr_address										
	jal 	print_value

	li 	$a0, 2			# Lay dia chi cua WordPtr
	jal 	ptr_address										
	jal 	print_value

	li 	$a0, 3			# Lay dia chi cua ArrayPtr
	jal 	ptr_address										
	jal 	print_value

	j 	main

option6:					# copy 2 con tro xau ki tu
input_string:
	li  	$v0, 54       		# InputDialogString
  	la   	$a0, input_str     		
  	la   	$a1, string_copy        	# Dia chi luu string dung de copy
  	li	$a2, 100			# So ki tu toi da co the doc duoc = 100
  	syscall
  	la   	$a1, string_copy        	# gan dia chi cua string_copy vao a1
  	la 	$s1, CharPtr1		# Load dia chi cua con tro CharPtr1     
  	sw 	$a1, 0($s1) 		# Luu string vua nhap vao CharPtr1
copy:
	la	$a0, CharPtr2		# Load dia chi cua con tro CharPtr2
	la   	$t9, Sys_TheTopOfFree 	# load dia chi con tro quan li cap phat kdata
	lw    	$t8, 0($t9) 		# Lay dia chi dau tien con trong xem o dau trong vung nho day
	sw   	$t8, 0($a0)    	        	# Cat dia chi do vao bien con tro CharPtr2
	lw 	$t4, 0($t9)            	# Dem so luong ki tu trong string
	lw	$t1, 0($s1)		# Load gia tri con tro CharPtr1 dang tro toi 
	lw 	$t2, 0($a0)	   	# Load gia tri con tro CharPtr2 dang tro toi
copy_loop:
	lb 	$t3, 0($t1)		# Load 1 ki tu (tren cung) tai $t1 vao $t3
	sb 	$t3, 0($t2)		# Luu 1 ki tu cua $t3 vao o nho tai dia chi $t2
	addi 	$t1, $t1, 1		# tang gia tri dia chi de tro toi ki tu tiep theo
	addi 	$t2, $t2, 1		# Chuyen sang dia chi ki tu tiep theo cua CharPtr2
	beq 	$t3, '\0', exit_copy	# Check null => end string
	addi 	$t4, $t4, 1		# $t4 : dem so luong ki tu string
	j 	copy_loop
exit_copy:
	la 	$a0, copy_str		
	li 	$v0, 4			# print string service
	syscall
	sw 	$t4, 0($t9)		# Luu so byte(s) dung de luu string cap nhat con tro quan ly trong free space
	la 	$a2, CharPtr2		# Load dia chi CharPtr2 vao $a2
	lw 	$a0, 0($a2)		# Luu xau da copy tu $a0 vao CharPtr2
	li 	$v0, 4			# In ra gia tri CharPtr2
	syscall
	la 	$a0, Newline
	syscall
	j 	main
	
option7: 				# giai phong bo nho
	la 	$a0, CharPtr
	sw	$zero, 0($a0)		# gan gia tri con tro = 0
	la 	$a0, BytePtr
	sw	$zero, 0($a0)		# gan gia tri con tro = 0
	la 	$a0, WordPtr
	sw	$zero, 0($a0)		# gan gia tri con tro = 0
	la 	$a0, ArrayPtr
	sw	$zero, 0($a0)		# gan gia tri con tro = 0
	jal 	SysInitMem		# khoi tao lai cap phat dong
	la 	$a0, free_mem
	li 	$v0, 4
	syscall
	j main
	
option8:					# Tinh luong bo nho da cap phat
	la 	$a0, malloc_str
	li 	$v0, 4			# print string service
	syscall
	jal 	MemoryCount		# tinh luong bo nho da cap phat va luu vao $v0
	move 	$a0, $v0
	li 	$v0, 1			# print integer
	syscall
	la 	$a0, bytes_str
	li 	$v0, 4			# print string service
	syscall
	j 	main

option9:					# Cap phat bo nho cho mang 2 chieu Malloc2
	la 	$a0, nb_row		
	jal 	integer_input 		# Nhap vao so hang
	move 	$s0, $a0			# gan s0 = a0
	la 	$a0, nb_col
	jal 	integer_input 		# Nhap vao so cot
	move 	$a1, $s0 		# a1 la row
	move 	$a2, $a0 		# a2 la column
	la 	$a0, ArrayPtr		# gan dia chi con tro array cho a0 
	jal 	Malloc2 			# Cap phat bo nho
	move 	$s0, $v0 		# luu lai gia tri
	la 	$a0, malloc_success
	li 	$v0, 4
	syscall 				
	move 	$a0, $s0
	li	$v0, 34
	syscall				
	j 	main

option10:				# Set[i][j]
	la 	$a0, ArrayPtr
	lw 	$s7, 0($a0)
	beqz 	$s7, nullptr 		# neu con tro rong thi bao loi (chua cap phat mang)
	la 	$a0, input_row
	jal 	integer_input 		# get row
	move 	$s0, $a0
	la 	$a0, input_col
	jal 	integer_input  		# get col
	move 	$s1, $a0
	la 	$a0, input_val
	jal 	integer_input  		# get val
	move 	$a3, $a0			# params cho setArray (gia tri)
	move 	$a1, $s0			# params cho setArray (hang)
	move 	$a2, $s1			# params cho setArray (cot)
	move 	$a0, $s7			# params cho setArray (dia chi)
	jal 	SetArray
	j 	main

option11:				# Get[i][j]
	la 	$a0, ArrayPtr
	lw 	$s1, 0($a0)
	beqz 	$s1, nullptr 		# neu con tro rong thi bao loi (chua cap phat mang)
	la 	$a0, input_row
	jal 	integer_input 		# get row
	move 	$s0, $a0			# $s0 = so hang
	la 	$a0, input_col
	jal 	integer_input  		# get col
	move 	$a2, $a0			# $a2 = so cot
	move 	$a1, $s0			# $a1 = so hang
	move 	$a0, $s1			# $a0 = gia tri ArrayPtr (dia chi dau tien)
	jal 	GetArray
	move 	$s0, $v0 		
	la 	$a0, output_val
	li 	$v0, 4
	syscall
	move 	$a0, $s0
	li 	$v0, 34
	syscall
	j 	main


	
	
#-------------------------------------------------------------------
# Ham khoi tao cho viec cap phat dong
# @param khong co
# @detail Danh dau vi tri bat dau cua vung nho co the cap phat duoc
#-------------------------------------------------------------------
SysInitMem:
	la 	$t9, Sys_TheTopOfFree 		# Lay con tro chua dau tien con trong, khoi tao
	la 	$t7, Sys_MyFreeSpace 		# Lay dia chi dau tien con trong, khoi tao
	sw 	$t7, 0($t9) 			# Luu lai
	jr 	$ra
	
#------------------------------------------------------------------------------
# Ham cap phat bo nho dong cho cac bien con tro
# @param [in/out] $a0 Chua dia chi cua bien con tro can cap phat
# Khi ham ket thuc, dia chi vung nho duoc cap phat se luu tru vao bien con tro
# @param [in] $a1 So phan tu can cap phat
# @param [in] $a2 Kich thuoc 1 phan tu, tinh theo byte
# @return $v0 Dia chi vung nho duoc cap phat
#------------------------------------------------------------------------------
malloc:
	la 	$t9, Sys_TheTopOfFree
	lw 	$t8, 0($t9) 			# Lay dia chi dau tien con trong
	bne 	$a2, 4, skip			# Neu khong phai kieu Word thi nhay sang skip
	addi 	$t8, $t8, 3			
	andi 	$t8, $t8, 0xfffffffc 		# gia tri luu tai $t8 luon la 1 so chia het cho 4
skip:
	sw 	$t8, 0($a0) 			# Cat dia chi do vao bien con tro
	addi 	$v0, $t8, 0 			# Dong thoi la ket qua tra ve cua ham
	mul 	$t7, $a1, $a2 			# Tinh kich thuoc cua mang can cap phat
	add 	$t6, $t8, $t7 			# Tinh dia chi dau tien con trong
	sw 	$t6, 0($t9) 			# Luu tro lai dia chi dau tien do vao bien Sys_TheTopOfFree
	jr 	$ra
	
#------------------------------------------
# Wrapper for syscall 51 (InputDialogInt)
# repeat if status value !=0
#------------------------------------------
integer_input:
	move 	$t9, $a0                        	# t9 = message
	li 	$v0, 51
	syscall
	beq 	$a1, 0, doneIn			# neu nhap dung so nguyen thi tiep tuc chuong trinh		
	beq 	$a1, -2, end			# neu CANCEL thi thoat ct
	la 	$a0, int_error			# neu khong nhap so nguyen hoac khong nhap gi va an OK --> bao loi
	li 	$v0, 4
	syscall
	move 	$a0, $t9				# dua lai message ve $a0 de lap lai den khi nhap dung so nguyen
	j 	integer_input
doneIn:
	jr 	$ra
	
#------------------------------------------
# kiem tra gia tri nhap vao >0 va <2000
#------------------------------------------
check_input:
	bge 	$a0, 2000, too_big
	blez 	$a0, zero_err
	jr 	$ra

#---------------------------------------------------------
# Ham lay gia tri cua cac bien con tro
# @param [in] $a0 {0: char ; 1: byte ; 2: word ; 3: array}
# @return $v0 gia tri bien con tro
#---------------------------------------------------------
ptr_value:
	la 	$t0, CharPtr			# Luu dia chi bien con tro CharPtr vao $t0
	sll 	$t1, $a0, 2			# CharPtr, BytePtr, WordPtr nam lien tiep nhau
	add 	$t0, $t0, $t1			# $t0 luu dia chi cua CharPtr/BytePtr/WordPtr/ArrayPtr
	lw 	$v0, 0($t0)			# lay gia tri luu tai bien con tro va luu vao $v0 (gia tri tra ve)
	jr 	$ra	
	
#---------------------------------------------------------
# Ham lay dia chi cua cac bien con tro
# @param [in] $a0 {0: char ; 1: byte ; 2: word ; 3: array}
# @return $v0 dia chi bien con tro
#---------------------------------------------------------
ptr_address:
	la 	$t0, CharPtr			# Luu dia chi bien con tro CharPtr vao $t0
	sll  	$t1, $a0, 2			# CharPtr, BytePtr, WordPtr nam lien tiep nhau
	add 	$v0, $t0, $t1			# $v0 luu dia chi cua CharPtr/BytePtr/WordPtr/ArrayPtr
	jr 	$ra
	
print_value:	  				# in ra gia tri $v0
	move 	$a0, $v0
	li 	$v0, 34				# print integer in hexadecimal service
	syscall
	li 	$a0, ';'
	li 	$v0, 11				# print character service
	syscall
	jr 	$ra
	
#------------------------------------------
# Tinh tong luong bo nho da cap phat
# @param: none
# @return $v0 chua luong bo nho da cap phat
#------------------------------------------
MemoryCount:
	la 	$t9, Sys_TheTopOfFree
	lw 	$t9, 0($t9)			# $t9 = Gia tri tai dia chi con trong dau tien
	la 	$t8, Sys_MyFreeSpace		# Sys_MyFreeSpace luon co dinh la thanh ghi ngay sau Sys_TheTopOfFree
	sub 	$v0, $t9, $t8			# Tra ve gia tri $v0 = luong bo nho da cap phat
	jr 	$ra

#-------------------------------------------------------------------------------------------
# Ham cap phat bo nho dong cho mang 2 chieu
# Idea: Dua ve cap phat bo nho cho mang 1 chieu co ROW * COL phan tu, su dung lai ham malloc
# @param [in/out] $a0 Chua dia chi cua bien con tro can cap phat
# Khi ham ket thuc, dia chi vung nho duoc cap phat se luu tru vao bien con tro
# @param [in] $a1 so hang
# @param [in] $a2 so cot
# @return $v0 Dia chi vung nho duoc cap phat
#-------------------------------------------------------------------------------------------
Malloc2:                                      	# a0 = ArrayPtr, a1 = row, a2 = col
	addiu 	$sp, $sp, -4			# them 1 phan tu vao stack
	sw 	$ra, 4($sp) 			# cat $ra
	bgt 	$a1, 1000, mal_err		# kiem tra loi so luong
	bgt 	$a2, 1000, mal_err		# phan tu hang (cot) qua lon
	la 	$s0, row				# dia chi row vao s0
	sw 	$a1, 0($s0)			# luu so hang vao row
	sw 	$a2, 4($s0)			# luu so cot vao col 
	mul 	$a1, $a1, $a2			# tra ve so phan tu cua Array
	li 	$a2, 4				# kich thuoc kieu Word = 4 bytes
	jal 	malloc
	lw 	$ra, 4($sp)			# luu lai ra de backup quay ve option9
	addiu 	$sp, $sp, 4 			# pop $ra
	jr 	$ra
	
#--------------------------------------------------------
# gan gia tri cua phan tu trong mang hai chieu
# @param [in] $a0 Chua dia chi bat dau mang
# @param [in] $a1 hang (i)	# @param [in] $a2 cot (j)
# @param [in] $a3 gia tri gan
#--------------------------------------------------------
SetArray:
	la 	$s0, row 			# $s0 = dia chi so hang
	lw 	$s1, 0($s0) 			# $s1 so hang
	lw 	$s2, 4($s0) 			# $s2 so cot
	bge 	$a1, $s1, bound_err 		# Neu so cot vuot qua gioi han => error
	bge 	$a2, $s2, bound_err 		# Neu so hang vuot qua gioi han => error
	mul 	$s0, $s2, $a1
	addu 	$s0, $s0, $a2 			# $s0 = i*col +j
	sll 	$s0, $s0, 2
	addu 	$s0, $s0, $a0 			# $s0 = *array + (i*col +j)*4
	sw 	$a3, 0($s0)
	jr 	$ra
	
#------------------------------------------
# lay gia tri cua trong mang
# @param [in] $a0 Chua dia chi bat dau mang
# @param [in] $a1 hang (i)
# @param [in] $a2 cot (j)
# @return $v0 gia tri tai hang a1 cot a2 trong mang
#	------------------------------------------
GetArray:
	la 	$s0, row 			# $s0 = dia chi so hang
	lw 	$s1, 0($s0) 			# $s1 so hang
	lw 	$s2, 4($s0) 			# $s2 so cot
	bge 	$a1, $s1, bound_err 		# Neu so cot vuot qua gioi han => error
	bge 	$a2, $s2, bound_err 		# Neu so hang vuot qua gioi han => error
	mul 	$s0, $s2, $a1			# convert 2 chieu sang 1 chieu
	addu 	$s0, $s0, $a2 			# $s0= i*col +j
	sll 	$s0, $s0, 2			
	addu 	$s0, $s0, $a0 			# $s0 = *array + (i*col +j)*4
	lw 	$v0, 0($s0)			# lay gia tri ra
	jr 	$ra
	

too_big:
	la    	$a0, overflow_error
	j 	error
zero_err:
	la 	$a0, zero_error
	j 	error
	
mal_err:						# In ra thong bao loi so luong malloc
	la 	$a0, mal_error
	j 	error
	
bound_err:					# In ra thong bao loi chi so vuot ngoai pham vi
	la 	$a0, bound_error
	j 	error
	
nullptr:						# In ra thong bao loi con tro rong ( null) (chua cap phat mang)
	la 	$a0, null_error
	j 	error
	
error:	
	li 	$v0, 4				# In ra thong bao loi
	syscall
	j 	main

end:
	li 	$v0, 10				# thoat ct
	syscall
