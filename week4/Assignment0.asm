#Laboratory Exercise 4, Home Assignment 1, Assignment 0
.text 
start: 
  li   $t0,0 #No Overflow is default status 
  li $s1, 1000000000
  li $s2, 2000000000
  add  $s3,$s1,$s2 
  xor  $t1,$s1,$s2  #Test if $s1 and $s2 have the same sign
   
  bltz  $t1, EXIT    #If not, exit, $t1 < 0 --> EXIT
  slt  $t2,$s3,$s1   
  bltz  $s1,NEGATIVE  #Test if $s1 and $s2 is negative? 
  beq  $t2,$zero,EXIT  #s1 and $s2 are positive 
# if $s3 > $s1 then the result is not overflow 
  b  OVERFLOW           
NEGATIVE:              
  bne  $t2,$zero,EXIT  #s1 and $s2 are negative 
     # if $s3 < $s1 then the result is not overflow  
OVERFLOW: 
  li  $t0,1     #the result is overflow 
EXIT:

  #dung xor de xem $s1 va $s2 co cung dau ko, neu ko cung thi $t1 < 0--> thoat
  #neu cung dau, kiem tra $s1 < 0 hay ko, neu nho hon thi nhay sang NEGATIVE, o NEGATIVE kiem tra tong $s3 < $s1 ko
