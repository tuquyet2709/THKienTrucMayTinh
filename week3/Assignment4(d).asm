#Laboratory Exercise 3,  Assignment 4(d) : i+j>m+n  
start: 
  addi $s1, $0, 0x0009 #Khoi tao i, luu vao $s1
  addi $s1, $s1, 0x0010 #Cong them j vao $s1, luu vao $s1
  addi $s2, $0, 0x0002 #Khoi tao m, luu vao $s2
  addi $s2, $s2, 0x0004 #Cong them n vao $s2, luu vao $s2
  slt  $t0,$s2,$s1    # m+n<i+j 
  beq  $t0,$zero,else    # Neu m+n khong nho hon i+j thi $t0 se khac $zero, nen nhay sang else  
  addi $t1,$t1,1     #   then part: x=x+1 
  addi $t3,$zero,1    # z=1 
  j  endif       # skip “else” part 
else: 
  addi $t2,$t2,-1     # begin else part: y=y-1 
  addi $t3, $0, 2     # Khoi tao z = 2
  add  $t3,$t3,$t3    # z=2*z 
endif: 