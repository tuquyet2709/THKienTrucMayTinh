#Laboratory Exercise 5, Assignment 1 
.data 
test: .asciiz "Day la 1 chuoi de test ma thoi !" 
.text 
   li  $v0, 4 
   la  $a0, test 
   syscall
   
   # Gia tri cua $a0 chinh la dia chi cua chuoi test ta can in ra man hinh