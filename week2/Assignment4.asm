#Laboratory Exercise 2, Assignment 4
.text
	#Assign X, Y
	addi $t1, $zero, 5 # X = $t1 = ?
	addi $t2, $zero, -1 # X = $t1 = ?
	#Expression Z = 2X + Y
	add $s0, $t1, $t1 #$s0 = $t1 + $t1 = X + X = 2X
	add $s0, $s0, $t2 #$s0 = $s0 + $t2 = 2X + Y
	
	
# Sau khi thuc hien lenh dau tien va thu hai, $t1 va $t2 co gia tri 0x00000005 va 0xffffffff, sau do thuc hien cong $t1 voi $t1 luu vao $s0,
# $s0 se co gia tri  0x0000000a, va sau khi cong $t2 vao $s0 va luu vao $s0, $s0 bay gio se co gia tri 0x00000009
# 2*5 - 1 = 9 --> dung 
# Hop ngu va ma may co cau truc tuong tu nhau, chi thay ten thanh ghi bang so thu tu thanh ghi, vi du $s0 --> $16



# So sanh
# addi $t1, $zero, 5  
	# 8 $zero $t1 5
	# 8 0 9 5
	# 001000 00000 01001 0000 0000 0000 0101
	# 0010 0000 0000 1001 0000 0000 0000 0101
	# 0x20090005
# addi $t2, $zero, -1 
	# 8 $zero $t2 -1
	# 8 0 10 -1
	# 001000 00000 01010 1111 1111 1111 1111
	# 0010 0000 0000 1010 1111 1111 1111 1111
	# 0x200affff
# add $s0, $t1, $t1  
	# 0 $t1 $t1 $s0 0 32
	# 0 9 9 16 0 32
	# 000000 01001 01001 10000 00000 100000
	# 0000 0001 0010 1001 1000 0000 0010 0000
	# 0x01298020
# add $s0, $s0, $t2
	# 0 $s0, $t2 $s0 0 32
	# 0 16 10 16 0 32
	# 000000 10000 01010 10000 00000 100000
	# 0000 0010 0000 1010 1000 0000 0010 0000
	# 0x020a8020
# KET QUA O TREN HOAN TOAN TRUNG KHOP VOI DONG CODE TRONG TEXT SEGMENT