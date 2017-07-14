.data 
maxprint: .asciiz "Max la :"
minprint: .asciiz "Min la :"
.text
	#Khoi tao gia tri cac thanh ghi tu $s0 den $s7
	li $s0, 68
	li $s1, 9
	li $s2, 76
	li $s3, 44
	li $s4, 55
	li $s5, 48
	li $s6, -87
	li $s7, 86
	
	
	add $v1, $sp, $0 #Luu gia tri con tro $sp ban dau 
	addi $sp, $sp, -32 #Tao 8 khoang trong luu 8 gia tri cua bien
	# luu bien 
	sw $s0, 0($sp)
	sw $s1, 4($sp)
	sw $s2, 8($sp)
	sw $s3, 12($sp)
	sw $s4, 16($sp)
	sw $s5, 20($sp)
	sw $s6, 24($sp)
	sw $s7, 28($sp)
	
	lw $a2, 0($sp) #Lay gia tri dinh ra $a2 de so sanh max
	lw $a3, 0($sp) #Lay gia tri dinh ra $a3 de so sanh max
	j pop1
	
	
pop1:	
	beq $sp, $v1, end1 # $sp bang gia tri ban dau thi end 
	addi $sp, $sp, 4 # Giam so luong trong stack di 1
	lw $a1, 0($sp)
	
	slt $t2, $a2, $a1 #$a2 < $a1 vua lay ra ?
	beq $t2, 1, max #$a2 < $a1 thi chuyen sang max, luu $a1 bang max
	j pop1	 	
	 	 	
	 	 	 	
max : 	add $a2, $a1, 0
       	j pop1
       	
pop2:	
	beq $sp, $v1, end2 # $sp bang gia tri ban dau thi end 
	addi $sp, $sp, 4 # Giam so luong trong stack di 1
	lw $a1, 0($sp)
	
	slt $t2, $a1, $a3 #$a1 < $a3 ?
	beq $t2, 1, min #$a1 < $a3 thi chuyen sang min, luu $a1 bang min
	j pop2	 	
	 	 	
	 	 	 	
min : 	add $a3, $a1, $0
       	j pop2
       	
       	
end1 : 	add $a1, $a2, $0
	la $a0, maxprint
	li $v0, 56
	syscall
	addi $sp, $v1, -32 #Hoan lai gia tri $sp
	j pop2

end2 : 	add $a1, $a3, $0
	la $a0, minprint
	li $v0, 56
	syscall

