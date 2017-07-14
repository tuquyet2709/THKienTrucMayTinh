.data
dialog1: .asciiz "Nhap vao bieu thuc trung to di nao ^^: (Cancel hoac ESC de thoat)"
dialog2: .asciiz "Vua nhap loi hoac khong nhap gi. Nhap lai di ! (Cancel hoac ESC de thoat)"
dialog3: .asciiz "Vi pham dieu kien: Ton tai so hang > 99. Moi ban nhap lai: (Cancel de thoat)"
dialog4: .asciiz "Vi pham dieu kien: Ton tai so hang < 0. Moi ban nhap lai: (Cancel de thoat)"
dialog5: .asciiz "Bieu thuc trung to: "
dialog6: .asciiz "Bieu thuc hau to: "
loivedau: .asciiz "Loi ve dau! Ban chi co the nhap dau + - * / ( ). Moi ban nhap lai: (Cancel de thoat)"
print_result: .asciiz "\nKet qua cua bieu thuc tinh duoc: "
string1: .space 1000 #buffer 1000 byte chua chuoi
string2: .space 1000 #buffer 1000 byte chua chuoi
string3: .space 1000 #buffer 1000 byte chua chuoi
string4: .space 1000 #buffer 1000 byte chua chuoi

.text

add $s6, $sp, $0 # Luu gia tri con tro sp de su dung ve sau 

input:
	li $v0, 54
	la $a0, dialog1
	li $a2, 100 # max ki tu nhap vao la 100
	la $a1, string1
	syscall
	j check_input
	
gt99:
	li $v0, 54
	la $a0, dialog3
	li $a2, 100
	la $a1, string1
	syscall
	j check_input
	
lt0:
	li $v0, 54
	la $a0, dialog4
	li $a2, 100
	la $a1, string1
	syscall
	j check_input

nodata:	#no input. try again
	li $v0, 54
	la $a0, dialog2
	li $a2, 100
	la $a1, string1
	syscall

check_input:
	beq $a1, -2, exit # nhan cancel thi $a1 luu -2
	beq $a1, -3, nodata # rong thi $a1 luu -3
	la $a0, string1 #in ki tu trong print1 ra
	li $v0, 4
	syscall

la $s0, string2

loop1:	# Xoa khoang trang thua
	lb $s1, 0($a0) #Lay tung ki tu ra
	beq $s1, 0x20, skip1 #0x20 -> dau cach

	sb $s1, 0($s0) #luu no lai, luu co chon loc
	beq $s1, 0, quit1 #0 thi la ket thuc
	addi $s0, $s0, 1

skip1:
	addi $a0, $a0, 1
	j loop1

quit1:

la $s0, string2 #luu lai string khi no da duoc xoa khoang trang

check2: #check < 100
	lb $s1, 0($s0) #load tung ki tu mot
	beq $s1, 0, quit2
	addi $s0, $s0, 1
checkso: #add duoc 3 lan nghia la so co 3 chu so -> loi 99
	sgt $t0, $s1, 0x2f #so 0 la 0x30 --> >2f
	slti $t1, $s1, 0x3a #so 9 la 0x39 --> <3a
	add $t0, $t0, $t1
	bne $t0, 2, checkdau # ko thoa man ca doi thi check tiep
	lb $s1, 0($s0)
	beq $s1, 0, quit2
	addi $s0, $s0, 1
	sgt $t0, $s1, 0x2f
	slti $t1, $s1, 0x3a
	add $t0, $t0, $t1
	bne $t0, 2, checkdau
	lb $s1, 0($s0)
	beq $s1, 0, quit2
	addi $s0, $s0, 1
	sgt $t0, $s1, 0x2f
	slti $t1, $s1, 0x3a
	add $t0, $t0, $t1
	bne $t0, 2, checkdau
	j gt99
checkdau :
	beq $s1, 0x2b, check2 #xem phai dau + khong
	beq $s1, 0x2d, check2 # -
	beq $s1, 0x2a, checkdautru # *
	beq $s1, 0x2f, checkdautru # /

	beq $s1, 0x28, check2 # decima : 40 : (
	beq $s1, 0x29, check2 # decima : 41 : )
	beq $s1, 0x0a, check2 # dau enter cuoi cung
	#Neu ko phai +-*/() thi in ra la loi dau
	li $v0, 54
	la $a0, loivedau
	li $a2, 100
	la $a1, string1
	syscall
	j check_input
	
checkdautru : 
	lb $s1, 0($s0) #load ki tu phia sau
	beq $s1, 0x2d, lt0
	addi $s0, $s0, -1
	lb $s1, 0($s0)
	addi $s0, $s0, 1 #tra lai $s1, $s0 nhu ban dau
	j check2
quit2:
# Han che o day la chi co the check ki tu dau tien
la $s0, string2	#check < 0
lb $s1, 0($s0)
beq $s1, 0x2d, lt0

check3: # thoa mann >0 va <99, cho hien thi bieu thuc trung to ra
	lb $s1, 0($s0)
	beq $s1, 0, quit3
	addi $s0, $s0, 1
	bne $s1, 0x28, check3 #la dau ( thi tiep tuc quet
	lb $s1, 0($s0)
	beq $s1, 0x2d, lt0 #sau dau ( la dau - thi bao loi <0
	j check3
	
quit3:
#Sau khi quet xong, in ra
	la $a0, dialog5
	li $v0, 4
	syscall
	la $a0, string2
	syscall

la $s0, string2
la $s7, string3
	
stack1:
	lb $s1, 0($s0)	# load tung tu mot
	beq $s1, 0, quit4	#rong --> null
	addi $s0, $s0, 1
	#check xem la so hay ko 
	sgt $t0, $s1, 47
	slti $t1, $s1, 58
	add $t0, $t0, $t1	#t0 = 2 -> 1 chu so
	
	bne $t0, 2, skip7
	sb $s1, 0($s7)
	addi $s7, $s7, 1
	j stack1
	
	skip7:
	bne $s1, 0x28, skip3	#Gap ( thi push vao stack
	
	addi $sp, $sp, -4
	sb $s1, 0($sp)
	j stack1
	
	skip3:
	bne $s1, 0x29, skip5	#khong phai ( thi xem no phai ) hay khong
	
	addi $t4, $zero, 32
	sb $t4, 0($s7)
	addi $s7, $s7, 1
	
	loop2:
	lb $s2, 0($sp)
	addi $sp, $sp, 4
	
	beq $s2, 40, stack1
	
	sb $s2, 0($s7)
	addi $s7, $s7, 1
	j loop2
	
	skip5:

	loop3:	 #no la dau +-*/
	
	move $t4, $s1
	addi $s7, $s7, -1
	lb $s1, 0($s7)
	addi $s7, $s7, 1 
	sgt $t0, $s1, 47
	slti $t1, $s1, 58
	move $s1, $t4
	add $t0, $t0, $t1
	
	bne $t0, 2, skip11
	addi $t4, $zero, 32 #xu li ki tu linh tinh -> khong trang
	sb $t4, 0($s7)
	addi $s7, $s7, 1
	
	skip11: 
	
	beq $sp, $s6, skip6  #khi ma stack rong ? neu co them toan tu thi phai them cho no
	lb $s2, 0($sp)
	
	jal mucdouutien
	#xem xem muc do uu tien la 0 hoac 3 -> ( hoac linh tinh
	beq $v0, 0, skip6
	beq $v0, 3, skip6
	move $v1, $v0
	
	move $s3, $s2
	move $s2, $s1
	jal mucdouutien
	sge $t3, $v1, $v0 #>=

	beq $t3, 0, skip6
	sb $s3, 0($s7) #uu tien cao hon duoc ghi ra hau to
	addi $s7, $s7, 1
	addi $sp, $sp, 4
	j loop3
	
	skip6:	#push vao stack
	addi $sp, $sp, -4
	sb $s1, 0($sp)
	
j stack1


quit4:	#viet vao cai string ket qua (postfix) cho den khi stack rong
	
	beq $sp, $s6, end1 #sp bang sp ban dau duoc luu -> ket thuc file hau to
	lb $s2, 4($sp)
	addi $sp, $sp, 4
	sb $s2, 0($s7)
	addi $s7, $s7, 1
	j quit4
	
end1:	#add '\0'
	sb $zero, 0($s7)

la $s1, string3

quit5:	#in postfix
	la $a0, dialog6
	li $v0, 4
	syscall
	
	loop6:
	lb $a0, 0($s1)
	beq $a0, 0, result1
	addi $s1, $s1, 1
	li $v0, 11
	syscall
	j loop6
	
exit:	#exit
	#j top
	li $v0, 10
	syscall

result1:	
	la $s0, string3 #xu li so co 2 chu so
	la $s7, string4
	li $s3, 10
	
	loop5:
	lb $s1, 0($s0)
	beq $s1, 0, skip12
	addi $s0, $s0, 1
	sgt $t0, $s1, 0x2f
	slti $t1, $s1, 58
	add $t0, $t0, $t1
	addi $s2, $s1, -0x30 #lay so don vi
	bne $t0, 2, skip13
	
	lb $s1, 0($s0)
	beq $s1, 0, skip15
	addi $s0, $s0, 1
	sgt $t0, $s1, 47
	slti $t1, $s1, 58
	add $t0, $t0, $t1
	
	addi $s4, $s1, -48	
	bne $t0, 2, skip14
	mul $s5, $s3, $s2 # hai chu so thi phai nhan 10 + so don vi
	mflo $s5
	add $s5, $s5, $s4
	sb $s5, 0($s7)
	addi $s7, $s7, 1
	j loop5
	
	skip13:
	sb $s1, 0($s7)
	addi $s7, $s7, 1
	j loop5
	
	skip14:
	sb $s2, 0($s7)
	addi $s7, $s7, 1
	sb $s1, 0($s7)
	addi $s7, $s7, 1
	j loop5
	
	skip12:
	sb $zero, 0($s7)
	j result
	
	skip15:
	sb $s2, 0($s7)
	addi $s7, $s7, 1
	sb $zero, 0($s7)
	
	
result:	# tinh ket qua
	la $a0, print_result
	li $v0, 4
	syscall

	la $s0, string4
	move $sp, $s6 #lay lai con tro sp, chi co 1 stack duy nhat nen moi co the lam ntn 
	
	loop4:
	lb $s1, 0($s0)
	beq $s1, 0, quit7
	addi $s0, $s0, 1
	
	beq $s1, 0x20, loop4 #dau trang thi tiep tuc vong lap
	
	beq $s1, 0x2b, cong
	beq $s1, 0x2d, tru
	beq $s1, 0x2a, nhan
	beq $s1, 0x2f, chia
	j skip16
	
	cong:
	lb $s3, 0($sp)
	addi $sp, $sp, 4
	lb $s4, 0($sp)
	addi $sp, $sp, 4
	add $s5, $s3, $s4
	j skip9
	
	tru:
	lb $s3, 0($sp)
	addi $sp, $sp, 4
	lb $s4, 0($sp)
	addi $sp, $sp, 4
	sub $s5, $s4, $s3
	j skip9
	
	nhan:
	lb $s3, 0($sp)
	addi $sp, $sp, 4
	lb $s4, 0($sp)
	addi $sp, $sp, 4
	mul $s5, $s3, $s4
	mflo $s5
	j skip9
	
	chia:
	lb $s3, 0($sp)
	addi $sp, $sp, 4
	lb $s4, 0($sp)
	addi $sp, $sp, 4
	div $s5, $s4, $s3
	mflo $s5
	
	skip9:
	addi $sp, $sp, -4
	sb $s5, 0($sp)
	j loop4
	
	skip16:
	addi $sp, $sp, -4
	sb $s1, 0($sp)
	j loop4

quit7:
	lb $a0, 0($sp)
	li $v0, 1
	syscall
	j exit
	
mucdouutien:
	beq $s2, 0x28, return0 #(
	beq $s2, 0x2b, return1 #+
	beq $s2, 0x2d, return1 #-
	beq $s2, 0x2a, return2 #*
	beq $s2, 0x2f, return2 #/
	
	li $v0, 3
	j skip
	
	return0:
		li $v0, 0
		j skip
	return1:
		li $v0, 1
		j skip
	return2:
		li $v0, 2
		
	skip:
	jr $ra
