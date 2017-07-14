#Laboratory Exercise 3, Assignment 4(c), i+j <= 0 
start: 
  addi $s1, $0, 0x0011 #Khoi tao i, luu vao $s1
  addi $s2, $0, 0x0010 #Khoi tao j, luu vao $s2
  add $s3, $s1, $s2 # Tinh sum = tong gia tri $s1 va $s2, luu vao $s3
  slt  $t0,$0,$s3    # Neu 0 < sum  
  bne  $t0,$zero,else    # branch to else if j<i   
  addi $t1,$t1,1     #   then part: x=x+1 
  addi $t3,$zero,1    # z=1 
  j  endif       # skip “else” part 
else: 
  addi $t2,$t2,-1     # begin else part: y=y-1 
  addi $t3, $0, 2     # Khoi tao z = 2
  add  $t3,$t3,$t3    # z=2*z 
endif: 
