#for (x=1; x<y; x++) {
#	x=x+5; 
#	y++;
#}

#x --> $s1
#y --> $s2
.text
.globl main
main:
Loop:
	sgt $t1, $s2, $s1	#$t1 stores 1 if $s2(y) > $s1(x), 0 otherwise
	
	beq $t1, 0, Exit
		add $s1, $s1, 6 #x = x+6 because x=x+5 and x++ in each loop
		add $s2, $s2, 1 #y++
j Loop
Exit:

.data
lw $s1, 1
lw $s2, 5