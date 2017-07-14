#Laboratory Exercise 3,  Assignment 4(a) : i<j  
start: 
  addi $s1, $0, 0x0009 #Khoi tao i, luu vao $s1
  addi $s2, $0, 0x0010 #Khoi tao j, luu vao $s2
  slt  $t0,$s1,$s2    # i<j 
  beq  $t0,$zero,else    # Neu i khong nho hon j thi $t0 se khac $zero, nen nhay sang else  
  addi $t1,$t1,1     #   then part: x=x+1 
  addi $t3,$zero,1    # z=1 
  j  endif       # skip “else” part 
else: 
  addi $t2,$t2,-1     # begin else part: y=y-1 
  addi $t3, $0, 2     # Khoi tao z = 2
  add  $t3,$t3,$t3    # z=2*z 
endif: 
