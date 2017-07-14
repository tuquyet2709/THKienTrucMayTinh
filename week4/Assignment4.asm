.text 
start: 
  li   $t0,0 #No Overflow is default status 
  li $s1,2000000000
  li $s2,1000000000
  add  $s3,$s1,$s2 
  xor  $t1,$s1,$s2  # $s1 va $s2 co cung dau hay khong
  bltz  $t1, EXIT    #$t1 < 0, khac dau --> EXIT
 # Khi cung dau
  xor $t2, $s3, $s1 # So sanh tong voi $s1
  bltz  $t2, OVERFLOW  # Neu tong khac dau $s1, OVERFLOW
  xor $t2, $s3, $s2 #So sanh tong voi $s2
  bltz  $t2, OVERFLOW  # Neu tong khac dau $s2, OVERFLOW
  b   EXIT     #Neu tong cung dau $s2, EXIT
OVERFLOW: 
  li  $t0,1     #the result is overflow 
EXIT:

 
