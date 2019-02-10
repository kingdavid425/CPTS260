#1. Define the following recursive function which is very similar to Fibonacci:
#
#	F(n) = 2 ? F(n ? 1) + 3 ? F(n ? 2);
#	F(0) = 1;
#	F(1) = 2.
#
#Please implement the function in MIPS and make sure your implementation
#indeed works on the simulator, by printing the value F(4) to the terminal.

.data
output: .asciiz "F(4) = "

.text
.globl main
main:
	li $a0, 4 #n --> $a0 | Java: int n = 4
	jal F
	move $s7, $v0 #store F(4) in $s7
	
	#Print "F(14) = "
	la $a0, output
	li $v0, 4
	syscall
	
	#Print integer
	li $v0, 1 #prepare to print a integer
	move $a0, $s7 #print y
	syscall
	
#end of main
li $v0, 10
syscall

	F: #int f (int n)
	beqz $a0, baseCase0    #base case F(0) = 1
	beq  $a0, 1, baseCase1 #base case F(1) = 2
	
	add $sp, $sp, -16 #making space on the stack
	sw $a0, 0($sp) #save value of n
	sw $t0, 4($sp) #save value of F(n-1)
	sw $t1, 8($sp) #save value of F(n-2)
	sw $ra, 12($sp)#save value of $ra
	
	#F(n-1) Recursion
	add $a0, $a0, -1 #F(n-1)
	jal F
	move $t0, $v0 #$t0 = F(n-1) | Java: int b = F(n-1)
	
	#F(n-2) recursion
	add $a0, $a0, -1 #F(n-2)
	jal F
	move $t1, $v0 #$t1 = F(n-2) | Java: int d = F(n-2)
	
	mul $t0, $t0, 2 #b = 2 * b
	mul $t1, $t1, 3 #d = 3 * d
	
	add $t0, $t0, $t1 #b = b + d
	move $v0, $t0 #return b
	
	lw $ra, 12($sp)#retrieve value of $ra
	lw $t1, 8($sp) #retrieve value of F(n-2)
	lw $t0, 4($sp) #retrieve value of F(n-1)
	lw $a0, 0($sp) #retrieve value of n
	addi $sp, $sp, 16 #deleting space on the stack
	
	jr $ra
	
	baseCase0:
	li $v0, 1
	jr $ra
	
	baseCase1:
	li $v0, 2
	jr $ra
		
	ExitF: