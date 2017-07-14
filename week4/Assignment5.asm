.text
li $s0, 1 # $t0 = 1
li $t1, 0 # i = 0
li $s1, 10 # n = 10
for : beq $t1, $s1, EXIT
      add $s0, $s0, $s0
      addi $t1, $t1, 1
      j for
EXIT : 
