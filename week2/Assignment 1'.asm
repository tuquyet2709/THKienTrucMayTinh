#Laboratory Exercise 2, Assignment 1
# Sua lenh lui thanh : addi $s0, $zero, 0x2110003d
.text
	addi $s0, $zero, 0x2110003d # $s0 = 0 + 0x2110003d = 0x2110003d; I - type
	add  $s0, $zero, $0 # $s0 = 0 + 0 = 0 ; R - type

# Sau khi cong 0x2110003d v�o thanh ghi $s0, do imm chi cong duoc toi da 16 bit, v� the khi th�m v�o mot gi� tri 32 bit, n� se phai cat 32 bit ra thanh
# lui va ori tuong ung : 
#			lui $1, 0x00002110
#			ori $1, $1, 0x0000003d 
# tuc l� cong 16 bit v�o truoc, luu v�o thanh ghi tam $at , sau do ghep 
# 16 bit tiep theo v� luu v�o $at, tiep theo lay gi� tri o $at thuc hien lenh cong v� luu v�o thanh ghi $s0 bang lenh 
#			add $16, $0, $1
# ket qua l� thanh ghi
# $s0 (number l� 16) se c� gi� tri 0x2110003d
	
