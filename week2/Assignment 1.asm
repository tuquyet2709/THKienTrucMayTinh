#Laboratory Exercise 2, Assignment 1
.text
	addi $s0, $zero, 0x3007 # $s0 = 0 + 0x30007 = 0x3007; I - type
	add  $s0, $zero, $0 # $s0 = 0 + 0 = 0 ; R - type
	
	# Su thay doi gi� tri cua thanh ghi $s0 : 
	# Ban dau thanh ghi $s0 c� gi� tri b?ng 0, sau khi thuc hien lenh dau ti�n, $s0 c� gi� tri 0x30007
	# Sau khi thuc hien lenh thu hai, $s0 c� gi� tri bang 0
	# Thanh ghi pc tang tu 0x00400000 l�n 0x00400004 v� 0x00400008 sau moi lenh duoc thuc hien
