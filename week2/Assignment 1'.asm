#Laboratory Exercise 2, Assignment 1
# Sua lenh lui thanh : addi $s0, $zero, 0x2110003d
.text
	addi $s0, $zero, 0x2110003d # $s0 = 0 + 0x2110003d = 0x2110003d; I - type
	add  $s0, $zero, $0 # $s0 = 0 + 0 = 0 ; R - type

# Sau khi cong 0x2110003d vào thanh ghi $s0, do imm chi cong duoc toi da 16 bit, vì the khi thêm vào mot giá tri 32 bit, nó se phai cat 32 bit ra thanh
# lui va ori tuong ung : 
#			lui $1, 0x00002110
#			ori $1, $1, 0x0000003d 
# tuc là cong 16 bit vào truoc, luu vào thanh ghi tam $at , sau do ghep 
# 16 bit tiep theo và luu vào $at, tiep theo lay giá tri o $at thuc hien lenh cong và luu vào thanh ghi $s0 bang lenh 
#			add $16, $0, $1
# ket qua là thanh ghi
# $s0 (number là 16) se có giá tri 0x2110003d
	
