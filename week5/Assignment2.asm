.data
message : .asciiz "The sum of "
a : .asciiz " and "
is : .asciiz " is "
.text
# Khoi tao $s0 va $s1
li $s0, 6
li $s1, 21
add $s2, $s0, $s1 # $s2 = $s0 + $s1
# in message : "The sum of"
li $v0, 4
la $a0, message
syscall
# in $s0
add $a0, $s0, $0
li  $v0, 1
syscall
# in a : "and"
li $v0, 4
la $a0, a
syscall
# in $s1
add $a0, $s1, $0
li  $v0, 1
syscall
# in is : "is"
li $v0, 4
la $a0, is
syscall
# in $s2
add $a0, $s2, $0
li  $v0, 1
syscall
