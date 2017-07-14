.data 
  Nhap: .asciiz "Enter a command : " 
  continueMessage: .asciiz "Do you want to continue ?(0.Yes/1.No)" 
  errMessage: .asciiz "Command is invalid,please try again \n" 
  NF: .asciiz "Invalid\n" 
  endMess: .asciiz "\n OK,your command is valid \n" 
  hopLe1: .asciiz "Opcode: " 
  hopLe11: .asciiz "Operand: " 
  hopLe2: .asciiz " OK\n" 
  chuKyMess: .asciiz "The cycle of command :  " 
  command: .space 100 
  opcode: .space 10 
  token: .space 20 
  number: .space 15 
  ident: .space 30 
  # do dai opcode 5 byte 
  # quy dinh : thanh ghi = 1,so nguyen =2, nhan = 3 hoac khong co = 0.  
 
  library: .asciiz "or***1111;xor**1111;lui**1201;jr***1001;jal**3002;addi*1121;add**1111;sub**1111;ori**1121;and**1111;beq**1132;bne**1132;j****3002;" 
  charGroup: .asciiz "qwertyuiopasdfghjklmnbvcxzQWERTYUIOPASDFGHJKLZXCVBNM_" 
  tokenRegisters: .asciiz "$zero $at   $v1   $a0   $a1   $a2   $a3   $t0   $t1   $t2   $t3   $t4   $t5   $t6   $t7   $s0   $s1   $s2   $s3   $s4   $s5   $s6   $s7   $t8   $t9   $k0   $k1   $gp   $sp   $fp   $ra   $0    $1    $2    $3    $4    $5    $7    $8    $9    $10   $11   $12   $13   $14   $15   $16   $17   $18   $19   $20   $21   $22   $21   $22   $23   $24   $25   $26   $27   $28   $29   $30   $31   " 
 
.text 
 
readData:  
  li $v0, 4 
  la $a0, Nhap 
  syscall 
  li $v0, 8 
  la $a0, command # chua dia chi cua lenh nhap vao 
  li $a1, 100 
  syscall 
main: 
  li $t2, 0 # i 
readOpcode:             #Doc lenh va lay opcode ra  
 
  la $a1, opcode            # $a1 chua dia chi cua cac opcode 
  add $t3, $a0, $t2         # $t3 = (*beq $t1,$t2,label) -> $t3 = (b*eq $t1,$t2,label)......  
  add $t4, $a1, $t2          
  lb $t1, 0($t3)   # $t1 = lay gia tri cua dia chi $t3 (b->e->...) 
  sb $t1, 0($t4)    # luu gia tri $t1 vao thanh ghi $t4 
  beq $t1, 32, done  # khi gap ki tu ' ' -> luu ki tu nay vao opcode de xu ly 
  beq $t1, 0, done   # ket thuc chuoi command 
  addi $t2, $t2, 1 
  j readOpcode 
   
                     # $a1 co gia tri = opcode (beq )  
#<--xu ly opcode--> 
done: 
  li $t7,-10             
  la $a2, library 
xuLyOpcode: 
  li $t1, 0 # i 
  li $t2, 0 # j 
  addi $t7,$t7,10 # buoc nhay = 10 de den vi tri opcode trong library 
  add $t1,$t1,$t7 # i = i + 10 
 
  compare: 
  add $t3, $a2, $t1 # t3 tro thanh con tro cua library  
  lb $s0, 0($t3)     #$s0 chua noi dung cua dia chi $t3 
  beq $s0, 0, notFound # doc het library -> khong tim thay lenh phu hop 
  beq $s0, 42, check # gap ki tu '*' -> check xem opcode co giong nhau tiep ko?. 
  add $t4, $a1, $t2     # 
  lb $s1, 0($t4) 
  bne $s0,$s1,xuLyOpcode # so sanh 2 ki tu. dung thi so sanh tiep, sai thi nhay den phan tu chua khuon danh lenh tiep theo. 
  addi $t1,$t1,1 # i+=1 
  addi $t2,$t2,1 # j+=1 
  j compare 
   
  check: 
  add $t4, $a1, $t2 
  lb $s1, 0($t4) 
  bne $s1, 32, notFound # neu ki tu tiep theo khong phai ' ' vidu bnej thi khong phai 
  checkContinue: 
  add $t9,$t9,$t2 # t9 = luu vi tri de xu ly token trong command 
  li $v0, 4 
  la $a0, hopLe1 # opcode hop le   
 
  syscall 
  li $v0, 4 
  la $a0, opcode 
  syscall 
  li $v0, 4 
  la $a0, hopLe2 
  syscall 
  j readToanHang1 
   
  check2: # neu ki tu tiep theo khong phai '\n' => lenh khong hop le. chi co doan dau giong. 
  bne $s1, 10, notFound 
  j checkContinue 
   
# <!--ket thuc xu ly opcode --> 
 
#<--xu li toan hang--> 
readToanHang1: 
  # xac dinh kieu toan hang trong library 
  # t7 dang chua vi tri khuon dang lenh trong library 
  li $t1, 0 
  addi $t7, $t7, 5 # or***1111;xor**1111;  $t7 = 10 +5  
 
  add $t1, $a2, $t7 # or***1111;xor**($t1)1111; 
  lb $s0, 0($t1)    #$s0 = "1" .... 
  addi $s0,$s0,-48 # chuyen tu char -> int 
   
  #todo 
  li $t8, 1 # thanh ghi = 1 
  beq $s0, $t8, checkTokenReg 
  li $t8, 2 # hang so nguyen = 2 
  beq $s0, $t8, checkHSN 
  li $t8, 3 # dinh danh = 3 
  beq $s0, $t8, checkIdent 
  li $t8, 0 # khong co toan hang = 0 
  beq $s0, $t8, checkNT 
  j end 
   
#<--check Token Register--> 
checkTokenReg: 
  la $a0, command 
  la $a1, token # luu ten thanh ghi vao token de so sanh 
  li $t1, 0 
  li $t2, -1   
 
  addi $t1, $t9, 0                   #$t9 la khoang cach tu dau command den vi tri hien tai 
  readToken: 
    addi $t1, $t1, 1 # i         
    addi $t2, $t2, 1 # j 
    add $t3, $a0, $t1            # beq ($t3)t1,t2,label; ($t1 = 4) beq t($t3)1,t2,label 
    add $t4, $a1, $t2            #($t4)                ;   
    lb $s0, 0($t3)                # $s0 = t 
    add $t9, $zero, $t1          # $t9 = $t1 = 4 
    beq $s0, 44, readTokenDone # gap dau ',' 
    beq $s0, 0, readTokenDone # gap ki tu ket thuc 
    sb $s0, 0($t4)            #luu $s0 = t vao $t4 -> t($t4)... t1 
    j readToken 
   
  readTokenDone: 
   
    sb $s0, 0($t4) # luu them ',' vao de compare   se duoc ($t4)t4, 
    li $t1, -1 # i 
    li $t2, -1 # j 
    li $t4, 0 
    li $t5, 0 
    add $t2, $t2, $k1   
 
    la $a1, token              #a1 chua dia chi label token 
    la $a2, tokenRegisters 
    j compareToken 
 
compareToken: 
  addi $t1,$t1,1   #i=0 
  addi $t2,$t2,1   #j=0 
  add $t4, $a1, $t1     #($t4)t4,   $a1 
  lb $s0, 0($t4)        #lay chu t ra 
  beq $s0, 0, end       # 
  add $t5, $a2, $t2     #"($t5)$zero $at   $t1   ...... " 
  lb $s1, 0($t5)        # lay ky tu ra 
  beq $s1, 0, notFound  # neu = 0 thi da chay het chuoi 
  beq $s1, 32, checkLengthToken      # neu la dau cach thi checklength 
  bne $s0,$s1, jump 
  j compareToken 
  checkLengthToken: 
    beq $s0, 44, compareE         #neu $s1 la dau cach ma $s0 la dau phay thi hop le 
    beq $s0, 10, compareE         # hoac neu $s1 la dau cach ma $s0 la ket thuc chuoi thi hop le 
    j compareNE 
  jump:  
 
    addi $k1,$k1,6 
    j readTokenDone 
  compareE: 
    la $a0, hopLe11 # opcode hop le 
    syscall 
    li $v0, 4 
    la $a0, token 
    syscall 
    li $v0, 4 
    la $a0, hopLe2 
    syscall 
    addi $v1, $v1, 1 # dem so toan hang da doc. 
    li $k1, 0 # reset buoc nhay 
    beq $v1, 1, readToanHang2          
    beq $v1, 2, readToanHang3 
    beq $v1, 3, readChuKy 
    j end 
  compareNE: 
    j notFound 
#<!--ket thuc check Token Register--> 
 
#<--check toan hang la hang so nguyen-->  

checkHSN: # kiem tra co phai hang so nguyen hay ko 
  la $a0, command 
  la $a1, number # luu day chu so vao number de so sanh tung chu so co thuoc vao numberGroup hay khong. 
  li $t1, 0 
  li $t2, -1 
  addi $t1, $t9, 0 
  readNumber: 
    addi $t1, $t1, 1 # i 
    addi $t2, $t2, 1 # j 
    add $t3, $a0, $t1 
    add $t4, $a1, $t2 
    lb $s0, 0($t3) 
    add $t9, $zero, $t1 # vi tri toan hang tiep theo trong command 
    beq $s0, 44, readNumberDone # gap dau ',' 
    beq $s0, 0, readNumberDone # gap ki tu ket thuc 
    sb $s0, 0($t4) 
    j readNumber 
  readNumberDone: 
    sb $s0, 0($t4) # luu them ',' vao de compare   vi du "20," 
    li $t1, -1 # i 
    li $t4, 0  

    la $a1, number 
    j compareNumber 
compareNumber: 
  addi $t1, $t1, 1 
  add $t4, $a1, $t1 
  lb $s0, 0($t4) 
  beq $s0, 0, end 
  beq $s0, 45, compareNumber # bo dau '-' 
  beq $s0, 10, compareNumE    #gap ket thuc chuoi 
  beq $s0, 44, compareNumE    #44 la dau phay 
  li $t2, 48 
  li $t3, 57 
  slt $t5, $s0, $t2 
  bne $t5, $zero, compareNumNE 
  slt $t5, $t3, $s0 
  bne $t5, $zero, compareNumNE 
  j compareNumber 
 
  compareNumE: 
    la $a0, hopLe11 
    syscall 
    li $v0, 4  
 
    la $a0, number 
    syscall 
    li $v0, 4 
    la $a0, hopLe2 
    syscall 
    addi $v1, $v1, 1 # dem so toan hang da doc. 
    li $k1, 0 # reset buoc nhay 
    beq $v1, 1, readToanHang2 
    beq $v1, 2, readToanHang3 
    beq $v1, 3, readChuKy 
    j end 
  compareNumNE: 
    j notFound 
#<!--ket thuc check toan hang la hang so nguyen--> 
 
#<--check Indent--> 
checkIdent: 
  la $a0, command 
  la $a1, ident # luu ten thanh ghi vao indent de so sanh 
  li $t1, 0 
  li $t2, -1 
  addi $t1, $t9, 0  
 
  readIndent: 
    addi $t1, $t1, 1 # i 
    addi $t2, $t2, 1 # j 
    add $t3, $a0, $t1 
    add $t4, $a1, $t2 
    lb $s0, 0($t3) 
    add $t9, $zero, $t1 # vi tri toan hang tiep theo trong command 
    beq $s0, 44, readIdentDone # gap dau ',' 
    beq $s0, 0, readIdentDone # gap ki tu ket thuc 
    sb $s0, 0($t4) 
    j readIndent 
  readIdentDone: 
    sb $s0, 0($t4) # luu them ',' vao de compare 
    loopj: 
    li $t1, -1 # i 
    li $t2, -1 # j 
    li $t4, 0 
    li $t5, 0 
    add $t1, $t1, $k1 
    la $a1, ident 
    la $a2, charGroup 
    j compareIdent  
 
compareIdent: 
  addi $t1,$t1,1 
  add $t4, $a1, $t1 
  lb $s0, 0($t4) 
  beq $s0, 0, end 
  beq $s0, 10, compareIdentE 
  beq $s0, 44, compareIdentE 
  loop: 
  addi $t2,$t2,1 
  add $t5, $a2, $t2 
  lb $s1, 0($t5) 
  beq $s1, 0, compareIdentNE 
  beq $s0, $s1, jumpIdent # so sanh ki tu tiep theo trong ident 
  j loop # tiep tuc so sanh ki tu tiep theo trong charGroup 
   
  jumpIdent: 
    addi $k1,$k1,1 
    j loopj 
     
  compareIdentE: 
    la $a0, hopLe11 # opcode hop le 
    syscall  

    li $v0, 4 
    la $a0, ident 
    syscall 
    li $v0, 4 
    la $a0, hopLe2 
    syscall 
    addi $v1, $v1, 1 # dem so toan hang da doc. 
    li $k1, 0 # reset buoc nhay 
    beq $v1, 1, readToanHang2 
    beq $v1, 2, readToanHang3 
    beq $v1, 3, readChuKy 
    j end 
  compareIdentNE: 
    j notFound 
#<!--ket thuc check Indent--> 
 
#<--kiem tra khong co toan hang--> 
checkNT: 
  la $a0, command 
  li $t1, 0 
  li $t2, 0 
  addi $t1, $t9, 0  
 
  add $t2, $a0, $t1 
  lb $s0, 0($t2) 
  addi $v1, $v1, 1 # dem so toan hang da doc. 
  li $k1, 0 # reset buoc nhay 
  beq $v1, 1, readToanHang2 
  beq $v1, 2, readToanHang3 
  beq $v1, 3, readChuKy 
#<!--ket thuc kiem tra khong co toan hang--> 
 
#<--check Token Register 2--> 
readToanHang2: 
  # xac dinh kieu toan hang trong library 
  # t7 dang chua vi tri khuon dang lenh trong library 
  li $t1, 0 
  la $a2, library 
  addi $t7, $t7, 1 # chuyen den vi tri toan hang 2 trong library 
  add $t1, $a2, $t7 # a2 chua dia chi library 
  lb $s0, 0($t1) 
  addi $s0,$s0,-48 # chuyen tu char -> int 
  li $t8, 1 # thanh ghi = 1 
  beq $s0, $t8, checkTokenReg 
  li $t8, 2 # hang so nguyen = 2  
 
  beq $s0, $t8, checkHSN 
  li $t8, 3 # dinh danh = 3 
  beq $s0, $t8, checkIdent 
  li $t8, 0 # khong co toan hang = 0 
  beq $s0, $t8, checkNT 
  j end 
#<!--ket thuc check Token Register 2--> 
 
#<--check Token Register 3--> 
readToanHang3: 
  # xac dinh kieu toan hang trong library 
  # t7 dang chua vi tri khuon dang lenh trong library 
  li $t1, 0 
  la $a2, library 
  addi $t7, $t7, 1 # chuyen den vi tri toan hang 3 trong library 
  add $t1, $a2, $t7 # a2 chua dia chi library 
  lb $s0, 0($t1) 
  addi $s0,$s0,-48 # chuyen tu char -> int 
  li $t8, 1 # thanh ghi = 1 
  beq $s0, $t8, checkTokenReg 
  li $t8, 2 # hang so nguyen = 2 
  beq $s0, $t8, checkHSN  
 
  li $t8, 3 # dinh danh = 3 
  beq $s0, $t8, checkIdent 
  li $t8, 0 # khong co toan hang = 0 
  beq $s0, $t8, checkNT 
  j end 
#<!--ket thuc check Token Register 3--> 
#<--check Token Register 3--> 
readChuKy: 
  # xac dinh kieu toan hang trong library 
  # t7 dang chua vi tri khuon dang lenh trong library 
  li $t1, 0 
  la $a2, library 
  addi $t7, $t7, 1 # chuyen den vi tri toan hang 4 trong library 
  add $t1, $a2, $t7 # a2 chua dia chi library 
  lb $s0, 0($t1) 
  addi $s0,$s0,-48 # chuyen tu char -> int 
  li $v0, 4 
  la $a0, chuKyMess 
  syscall 
  li $v0,1 
  li $a0,0 
  add $a0,$s0,$zero  
 
  syscall 
  j end 
#<!--ket thuc check Token Register 3--> 
#<--ket thuc xu li toan hang--> 
 
continue: # lap lai chuong trinh. 
  li $v0, 4 
  la $a0, continueMessage 
  syscall 
  li $v0, 5 
  syscall 
  
  add $t0, $v0, $zero 
  beq $t0, $zero, resetAll 
  j TheEnd 
resetAll: 
  li $v0, 0  
  li $v1, 0 
  li $a0, 0  
  li $a1, 0 
  li $a2, 0 
  li $a3, 0 
  li $t0, 0   
  li $t1, 0 
  li $t2, 0 
  li $t3, 0 
  li $t4, 0 
  li $t5, 0 
  li $t6, 0 
  li $t7, 0 
  li $t8, 0 
  li $t9, 0 
  li $s0, 0 
  li $s1, 0 
  li $s2, 0 
  li $s3, 0 
  li $s4, 0 
  li $s5, 0 
  li $s6, 0 
  li $s7, 0 
  li $k0, 0 
  li $k1, 0 
  j readData	 
notFound: 
  li $v0, 4  
 
  la $a0, NF 
  syscall 
  j continue 
error: 
  li $v0, 4 
  la $a0, errMessage 
  syscall 
  j continue 
end: 
  li $v0, 4 
  la $a0, endMess 
  syscall 
  j continue 
TheEnd: 
