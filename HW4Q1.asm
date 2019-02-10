#1. Write a MIPS program that does:
#a. Read a string from keyboad whose length is at most 64;
#b. Delete the last appearance of character a from the string (assume that
#   the string always contains at least an a);
#c. Print the string to terminal.
#Masure you run the program on the simulator and it indeed works.

.data
	prompt: .asciiz "Enter a string that contains the letter 'a' : \n"
	string: .space 64
.text
.globl main
main:
	#Prompt the user for a string
	li $v0, 4      #prepare to print a string
	la $a0, prompt #print out prompt: "Enter a string that contains the letter 'a'"
	syscall
	
	#Take in user input
	li $v0, 8      #prepare to read a string
	la $a0, string #String string = Scanner(System.in)
	li $a1, 64     #set max string legth to 64
	syscall
	
	# Delete last occurrence of 'a' in string
	# Get the address of the last character in string and store in $s1
	la $s0, string #$s0 --> string
	move $s1, $s0  #$s1 = $s0
	StringLength:
		lbu $t0, 0($s1)        #$t0 --> $s1 (string)
		beq $t0, $zero, ExitSL #exit if end of string character is found
		addi $s1, $s1, 1
		j StringLength	
	ExitSL:
	addi $s1, $s1, -1 #point at char before end of line char
	
	# Get $s1 to point at the last actual 'a' in string
	LastA:
		lbu $t0, 0($s1)     #$t0 --> $s1 (string)
		beq $t0, 97, ExitLA #if $t0 contains 'a' (ascii value 97), goto ExitLA
		addi $s1, $s1, -1
		j LastA
	ExitLA:
	
	# Shift the remaining characters over.
	#	   Use $t0 to store the address of the character at $s1 + 1
	#	   Use $t1 to store the value at ($s1 + 1)
	FixString:
		move $t0, $s1          #$t0 = $s1 (points to last 'a' in the string)
		addi $t0, $t0, 1       #points to first letter after 'a'
		lb $t1, 0($t0)         #store the char at $t0 in $t1
		sb $t1, 0($s1)         #shift the char over 1
		beq $t1, $zero, ExitFS #exit if end of string is found
		addi $s1, $s1, 1       #incriment by one and repeat
		j FixString
	ExitFS:
	
	#Print string
	li $v0, 4 #prepare to print a string
	la $a0, string
	syscall
	
#tell the system this the end of main
li $v0, 10
syscall