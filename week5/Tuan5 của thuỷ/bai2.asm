.data
Result: .asciiz "The sum of:.... "
.text
	li $s0,0x26
	li $s1,0x02
	
	
	add $a1,$s0,$s1
	
	li $v0,56
	la $a0,Result
	syscall