	- cache block - The basic unit for cache storage. May contain multiple
bytes/words of data.
	- cache line - Same as cache block. Note that this is not the same thing as
a “row” of cache.
	- cache set - A “row” in the cache. The number of blocks per set is determined
by the layout of the cache (e.g. direct mapped, set-associative, or fully associative).
	- tag - A unique identifier for a group of data. Because different regions of 
memory may be mapped into a block, the tag is used to differentiate between them.
	- valid bit - A bit of information that indicates whether the data in a block is valid (1) or not (0).
	
	- Write policy: In addition to caching reads from memory, the system is capable of caching writes to memory. 
The handling of the address bits and the cache lines, etc. is pretty similar to how this is done when the cache is read.
However, there are two different ways that the cache can handle writes, and this is referred to as the "write policy" of the cache.
	. Write-Back Cache: Also called "copy back" cache, this policy is "full" write caching of the system memory.
When a write is made to system memory at a location that is currently cached, the new data is only written to the cache, not actually written to the system memory.
Later, if another memory location needs to use the cache line where this data is stored, it is saved ("written back") to the system memory and then the line can be used by the new address.
	. Write-Through Cache: With this method, every time the processor writes to a cached memory location,
 both the cache and the underlying memory location are updated.
 
 
 
 
	- Replacement Policy: When a MM block needs to be brought in while all the CM blocks are occupied,
one of them has to be replaced. The selection of this block to be replaced can be determined in one of the following ways.
	. Optimal Replacement: replace the block which is no longer needed in the future. If all blocks currently in CM will be used again, replace
the one which will not be used in the future for the longest time.
	. Random selection: replace a randomly selected block among all blocks currently in CM.
	. FIFO (first-in first-out): replace the block that has been in CM for the longest time.
	. LRU: replace the block in CM that has not been used for the longest time, i.e., the least recently used (LRU) block.
The optimal replacement is obviously the best but is not realistic, simply because when a block will be needed in the future is usually not known ahead of time.
The LRU is suboptimal based on the temporal locality of reference, i.e., memory items that are recently referenced are more likely to be referenced soon than those which have not been referenced for a longer time.
FIFO is not necessarily consistent with LRU therefore is usually not as good. The radom selection, surprisingly, is not necessarily bad.
LRU replacement can be implemented by attaching a number to each CM block to iidicate how recent a block has been used.
Eveytime a CPU reference is made all of these numbers are updated in such a way that the smaller a number the more recent it was used, i.e., the LRU block is always indicated by the largest number.
Block needed: set the number to zero: N=0

In case of a miss, bring the block needed in (replace an existing CM block if necessary)
Other blocks in CM:
	N=N {if N greater than that of the block needed} or = N+1 {if N is less than that of the block needed or a miss}
