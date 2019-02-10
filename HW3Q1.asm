#if (x>y+5) then 
#	x=x+y; 
#else 
#	y=x-y;

#x --> $s1
#y --> $s2

.text
.globl main
main:
	add $s2, $s2, 5			#adds 5 to y and stores in y
	sgt $t1, $s1, $s2		#check to see if x is greater than y
	
	beq $t1, 0, else		#if x is not greater
		sub $s2, $s1, $s2	#x=x+y
		j exit			#
	else: add $s1, $s1, $s2 	#y=x-y
	exit:
.data
lw $s1, 5
lw $s2, 7