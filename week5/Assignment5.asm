.data
Message: .asciiz "Nhap xau: "
Message2: .asciiz "Xau da duoc dao nguoc lai vi tri !"
String: .space 20
String_reverse: .space 20

.text

main:
get_string:
	li $v0,54
	la $a0,Message
	la $a1,String
	li $a2,50
	syscall
get_length:  # chieu dai xau luu vao $v0
	      la   $a0, String          # a0 = Address(string[0]) 
              xor  $v0, $zero, $zero    # v0 = length = 0 
              xor  $t0, $zero, $zero    # t0 = i = 0 
check_char:   add  $t1, $a0, $t0        # t1 = a0 + t0  
                                        #= Address(string[0]+i)  
              lb   $t2, 0($t1)          # t2 = string[i] 
              beq  $t2,$zero,end_of_str # Is null char?        
              addi $v0, $v0, 1          # v0=v0+1->length=length+1 
              addi $t0, $t0, 1          # t0=t0+1->i = i + 1 
              j    check_char 
end_of_str:                              
end_of_get_length: 



Dao_chuoi:
	addi $s0,$v0,-1 #s0=i=length(String)-1
	add $s1,$0,$0 #s1=j=0
	la $a1,String
	la $a0,String_reverse
L1:
	add $t1,$s0,$a1 #t1=s0+a1=i+y[0]=address of String[i]
	lb $t2,0($t1) #t2=value at t1=String[i]
	add $t3,$s1,$a0 #t3=s0+a0=i+x[0]=address of Reverse[j]
	sb $t2,0($t3)#t3=Reverse[i]  =  t2=String[i]
	beq $t2,$0,end_of_Dao_chuoi #if(String[i]==0) --> end
	nop
	subi $s0,$s0,1 #s0=s0-1<-> i=i-1
	addi $s1,$s1,1 #s1=s1+1<-> j=j+1
	j L1
	nop
end_of_Dao_chuoi:
	
	li $v0,55
	li $a1,1
	syscall
	      
	li $v0, 55
        la $a0, Message2  
        li $a1, 1
	syscall	
	
