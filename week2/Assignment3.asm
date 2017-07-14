#Laboratory Exercise 2, Assignment 3
.text 
	li $s0, 0x2110003d # pseudo instruction = 2 basic instructions
	li $s1, 0x00000002 # but if the immediate value is small, one ins
	
#Cac lenh duoc thuc hien : lui $1, 0x00002110 --> cong 16 bit vao truoc, luu vao thanh ghi tam at
#			   ori $16, $1, 0x0000003d --> ghep them 16 bit sau vao o vi tri thanh ghi tam at, 
#			   sau do luu vao thanh ghi $16, ket qua $16 co gia tri 0x2110003d
#			   addiu $17, $0, 0x00000002 --> cong khong dau (tai sao lai cong khong dau???) gia tri 2 vao $17, s1 se co gia tri 0x00000002
# Nhan xet : li la lenh gia, va duoc chia thanh cac lenh tuong ung nhu tren trong truong hop cong vao so 32 bit
# Truong hop them vao gia tri 16 bit, li se chuyen thanh lenh addiu.


