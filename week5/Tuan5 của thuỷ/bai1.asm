.data
Message: .asciiz "MD_Thuy"
String: .space 50
.text
	li $v0,54
	la $a0,Message
	la $a1,String
	li $a2,50
	syscall

	li $v0,4
	la $a0,String
	syscall