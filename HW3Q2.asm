#Let arrA be an array of 6 integers. Write a MIPS program that
#a. read from keyboard the content of the array: 2, -10, 3, -9, -7, 23.
#b. find the second largest number in the array.
#c. print the number out.

.data
	prompt: .asciiz "Enter a number: "
	prompt2: .asciiz "The second largest number is: "
	array: .space 24 #6*4 = 24 - reserves a block in memory of size 24 bytes
.text
.globl main
	main:
		la $s0, array
		li $t0, 0
		
		Loop1:
		beq $t0, 24, Exit1  #if the loop has run 6 times it will exit	
		
		#Prompt the user for a number
		li $v0, 4	#prepare to take in a string
		la $a0, prompt	#print out prompt: "Enter a number: "
		syscall	
			
		#Get the user input
		li $v0, 5	#prepare to take in an integer
		syscall
		
		sw $v0, array($t0) #stores the users inputted value in the next spot of the array		
		add $t0, $t0, 4    #incriments $t0 by 4 so the proper memory address will be used for the next input
							
		j Loop1
		Exit1:
		
		li $t0, 0 #reset $t0 
			  #used as counter in Loop2
		
		# $t0 will count for loop iterations
		# $t1 will hold largest value
		# $t2 will hold 2nd largest value
		# $t3 will hold address of array($t0)
		
		lw $t3, array($t0)
		move $t1, $t3	#largest = intArray[0];
		add $t0, $t0, 4 #i++
		lw $t3, array($t0)
		bgt $t3, $t1, here3 #if(intArray[1] > largest) { goto here3
			move $t2, $t3 #	nextLargest = intArray[1];
		here3:
			move $t2, $t1
			move $t1, $t3
							
		Loop2:
			beq $t0, 24, Exit2	   #if the loop has run 6 times, exit
			add $t0, $t0, 4		   #i++
			
			lw $t3, array($t0)
			
			ble $t3, $t2, Loop2 #if(array[i] < 2ndLargest)
			bgt $t3, $t1, here  #if(intArray[i] > largest) {
			bgt $t3, $t2, here2 #else if(intArray[i] > nextLargest) {
			here:
				move $t2, $t1 #2ndLargest = largest
				move $t1, $t3 #largest = array(i)
				j Loop2
			here2:
				move $t2, $t3  #2ndLargest = array(i)
				j Loop2
			
		Exit2:		
		li $v0, 4	#prepare to take in a string
		la $a0, prompt2 #print "The second largest number is: "
		syscall		#execute
		
		li $v0, 1	#prepare to print an integer
		move $a0, $t2 	#print out the second largest number
		syscall		#execute
		
	#tell the system this the end of main
	li $v0, 10
	syscall
