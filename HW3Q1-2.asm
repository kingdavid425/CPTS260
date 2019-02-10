#while (x>y+5) {
#	x--; 
#	x--; 
#	y++
#}

#x --> $s1
#y --> $s2
.text
.globl main
main:
Loop:
	add $t1, $s2, 5			#add 5 to y and store in $t1
	sgt $t1, $s1, $t1  	 	#$t1 = 1 if $s1 (x) > $t1 (y+5)
	
	beq $t1, 0, Exit		#checks to see if the loop should run
		sub $s1, $s1, 2		#x = x-2
		add $s2, $s2, 1		#y++
j Loop
Exit:

.data
lw $s1, 5
lw $s2, 5