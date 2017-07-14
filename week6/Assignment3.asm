.data
A: .word 7, -2, 5, 1, 5,6,7,3,6,8, 59, 58, -85 #khoi tao mang A 10 phan tu
Aend:.word
.text 
main:
    la $t0, Aend    # 40 bytes cho mang A, tuong ung $t0 la phan tu cuoi cung.                            
new:             
    add $t1, $0, $0     # $t1 luu gia tri i (khoi tao = 0)
    la  $a0, A    # lay dia chi co so cua mang A cho $a0
loop:                  # kiem tra mang, swap neu can`
    lw  $t2, 0($a0)         # $t2 = A[0]
    lw  $t3, 4($a0)         # $t3 = A[1]
    slt $t5, $t2, $t3       # $t5 = 1 if $t2 < $t3
    beq $t5, $0, swap   # if $t5 = 1, doi cho A[i] voi A[i+1]
    add $t1, $0, 1          # tang i len 1
    sw  $t2, 4($a0)         # luu so lon hon vao phan tu co dia chi lon hon trong mang 
    sw  $t3, 0($a0)         # luu so nho hon vao phan tu co dia chi nho hon trong mang
swap:
    addi $a0, $a0, 4            # tang dia chi A len 4 bytes
    bne  $a0, $t0, loop    # lap loop den khi nao $a0 la phan tu cuoi cung ($a0 = $t0)
    bne  $t1, $0, new    # $t1 = 1,  quay tro ve vong lap outterLoop
		
