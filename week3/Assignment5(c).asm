#Laboratory 3, Home Assigment 2
.data 
A : .word 1,2,3,4,5,6,7,8,9 #khoi tao mang A
.text 
addi $s1, $0, 0x0000 # Khoi tao i = 0x0000, luu vao $s1
addi $s4, $0, 0x0001 # Khoi tao step = 0x0001, luu vao $s4
la $s2, A # Lay dia chi A, luu vao $s2
addi $s3, $0, 0x0004 # Khoi tao n = 0x0004, luu vao $s3
addi $s5, $0, 0x0005 # Khoi tao sum = 0x0005, luu vao $s5
loop: 
  add  $s1,$s1,$s4    #i=i+step 
  add  $t1,$s1,$s1    #t1=2*s1 
  add  $t1,$t1,$t1    #t1=4*s1   
  add  $t1,$t1,$s2    #t1 store the address of A[i] 
  lw  $t0,0($t1)     #load value of A[i] in $t0 
  add  $s5,$s5,$t0    #sum=sum+A[i] 
  slt $t2, $s5,$0   # so sanh sum va 0, i < n thi $t2 bang 1
  bne  $t2,$zero,loop    #Neu sum<0, goto loop 
  
