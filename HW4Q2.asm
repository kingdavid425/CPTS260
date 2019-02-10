#void main(){
#	int x=12;
#	int y=simpleEx(x,x-5);
#	y=y+simpleEx(14,x);
#}19
#int simpleEx(int x, int y){
#	int z=7;
#	return x+2y-z;
#}
.text
.globl main
main:
#$s0 == x
#$s1 == y
	li $s0, 12 	  #int x = 12
	move $a0, $s0     #a0 == x
	addi $a1, $a0, -5 #$a1 == x-5
	jal SimpleEx      #SimpleEx($a0, $a1)
	
	move $s1, $v0 #s1 = simpleEx(x,x-5)
	li $a0, 14
	move $a1, $s0
	jal SimpleEx #SimpleEx(14,x)
	
	move $s2, $v0 #$s2 = simpleEx(14,x)
	add $s1, $s1, $s2 #final y value in $s1

#Print string
li $v0, 1 #prepare to print a integer
move $a0, $s1 #print y
syscall

#end of main
li $v0, 10
syscall

SimpleEx:
	#Save $a0 and $a1
	addi $sp, $sp, -8 #create space on stack
	sw $a0, 0($sp) #push $a0 to top of stack
	sw $a1, 4($sp) #push $a1 to top of stack
	
	li $t2, 7     #t2 = z = 7
	
	sll $a1, $a1, 1   #y = 2y
	add $a0, $a0, $a1 #x = x +2y
	sub $a0, $a0, $t2 #x = x+2y-z
	move $v0, $a0	  #store answer in $v0 
	
	lw $a1, 4($sp) #pop $a1 from top of stack
	lw $a0, 0($sp) #pop $a0 from top of stack
	addi $sp, $sp, 8 #delete space on stack
	
	jr $ra #return $v0
ExitSE: