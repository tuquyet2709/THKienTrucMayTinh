.text
	li $s0,0x12345678
	li $s1,0xf7654321
	
	#abs $t0,$s1
	bltz $s1,Then#if ($s1<0)
	#neu s1 duong
	addi $t0,$s1,0
Then:
	#neu s1 am
	sub $t0,$0,$s1
	
	#move $t1,$s0
	li $t1,0x00000000
	or $t1,$t1,$s0
	
	#not $t2,$s1
	li $t2,0xffffffff
	xor $t2,$s1,$t2
	
	#ble $s0,$s1,L
	slt $t3,$s1,$s0
	bne $t3,$0,EXIT
L:	li $t4,0xfffff111
EXIT:
