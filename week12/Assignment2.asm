#Mot vi du ve catche
.data 
A: .word 7, -2, 5, 1, 5,6,7,3,6,8,8,59,5 
Aend: .word  
 
.text 
main:       la   $a0,A           #$a0 = Address(A[0]) 
        la   $a1,Aend 
        addi $a1,$a1,-4      #$a1 = Address(A[n-1]) 
        j    sort            #sort 
after_sort: li   $v0, 10         #exit 
            syscall 
end_main: 
#-------------------------------------------------------------- 
#procedure sort (ascending selection sort using pointer) 
#register usage in sort program 
#$a0 pointer to the first element in unsorted part 
#$a1 pointer to the last element in unsorted part 
#$t0 temporary place for value of last element 
#$v0 pointer to max element in unsorted part 
#$v1 value of max element in unsorted part 
#-------------------------------------------------------------- 
sort:       beq    $a0,$a1,done  #single element list is sorted 
            j    max         #call the max procedure 
after_max:  lw    $t0,0($a1)  #load last element into $t0 
            sw    $t0,0($v0)  #copy last element to max location 
            sw    $v1,0($a1)  #copy max value to last element 
            addi    $a1,$a1,-4      #decrement pointer to last element 
            j    sort    #repeat sort for smaller list 
done:       j       after_sort 
 
#------------------------------------------------------------------------ 
#Procedure max 
#function: fax the value and address of max element in the list 
#$a0 pointer to first element 
#$a1 pointer to last element 
#------------------------------------------------------------------------ 
max: 
  addi  $v0,$a0,0         #init max pointer to first element 
  lw    $v1,0($v0)        #init max value to first value 
  addi  $t0,$a0,0         #init next pointer to first 
loop: 
  beq  $t0,$a1,ret       #if next=last, return 
  addi  $t0,$t0,4         #advance to next element 
  lw  $t1,0($t0)        #load next element into $t1 
  slt  $t2,$t1,$v1       #(next)<(max) ? 
  bne  $t2,$zero,loop  #if (next)<(max), repeat 
  addi  $v0,$t0,0        #next element is new max element 
  addi  $v1,$t1,0        #next value is new max value 
  j  loop              #change completed; now repeat 
ret: 
  j     after_max 

# 1) What happens when there is a cache hit:
# 	 - When the CPU tries to read from memory, the address will be sent to a cache controller. 
# 	 - The lowest k bits of the address will index a block in the cache.
# 	 - If the block is valid and the tag matches the upper (m - k) bits of the m-bit address, 
# then that data will be sent to the CPU.
 	 
# 2)What happens when there is a cache miss:
#	 - The delays that we’ve been assuming for memories (e.g., 2ns) are really assuming cache hits.
#	 - If our CPU implementations accessed main memory directly, their cycle times would have to be much larger.
#	 - Instead we assume that most memory accesses will be cache hits, which allows us to use a shorter cycle time.
#	 - However, a much slower main memory access is needed on a cache miss. 
#The simplest thing to do is to stall the pipeline until the data from main memory can be fetched (and also copied into the cache).
#
#3)what is block size?:
#	- The basic unit for cache storage. May contain multiple bytes/words of data
#	- Caches are divided into blocks, which may be of various sizes.
#	- The number of blocks in a cache is usually a power of 2.
#	- For now we’ll say that each block contains one byte. This won’t take advantage of spatial locality, but we’ll do that next time
#4)What is the function of the tag?:
#	A unique identifier for a group of data. Because different regions of memory may be mapped into a block, the tag is used to differentiate
#between them.
