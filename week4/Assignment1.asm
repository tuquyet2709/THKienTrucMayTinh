#Laboratory Exercise 4, Assignment 1
.text
 li $s0, 0xabcd1234 # Luu gia tri vao $s0
 andi $s1, $s0, 0xff000000 # and voi 1111 1111 0000 0000 0000 0000 0000 0000. Lay 2 MSVB, luu vao $t0
 srl $t1, $s0, 8 # lui sang phai 2
 sll $s2, $t1, 8 # sang trai 2
 ori $s3, $s0, 0x000000ff # or voi 0000 0000 0000 0000 0000 0000 1111 1111
 li $s5, 0xffffffff
 nor $s4, $s0, $s5 # nor voi 1111 1111 1111 1111 1111 1111 1111 1111 
 
 # $s1 lay ra MSB
 # $s2 xoa LSB
 # $s3 thiet lap LSB
 # $s4 $s0 = 0
