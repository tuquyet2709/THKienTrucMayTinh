.data
string : .space 50
string2 : .space 50
Message1:    .asciiz "Nhap xau: "
Message2:    .asciiz "Xau da duoc copy ! " 
.text 
main: 
get_string:   li $v0, 54
	      la $a0, Message1
	      la $a1, string
	      li $a2, 50
	      syscall
	    
	      xor $t0, $0, $0 # $t0 = i =0
	      la $a1, string # $a1 luu vi tri string
	      la $a0, string2	# $a0 luu vi tri string2	      
strcpy :      
	      add $t1, $a1, $t0 # $t1 luu vi tri string + i
	      lb $t2, 0($t1) # $t2 = string[i]
	      add $t3,  $a0, $t0 # $t3 luu vi tri string2 +i
	      sb $t2, 0($t3) # $t2 = string2[i]
	      beq  $t2,$zero,end_of_str # $t2 rong ?  
	      nop 
  	      addi $t0, $t0, 1          # t0=t0+1-> i = i + 1  
  	      j strcpy
  	      nop 
end_of_str :
	      li $v0, 55 
	      li $a1, 1
	      syscall # $a0 luc nay chua string2, in string2 ra
	     
	      li $v0, 55
              la $a0, Message2
	      li $a1, 1
	      syscall
	           	     
	      