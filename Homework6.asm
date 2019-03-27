.data
	Xn: .float 1
	number3: .float 3.0
	number2: .float 2.0
	number1: .float 1.0
	output: .asciiz "CubeRoot(3) = "
.text 
.globl main
main:
#$f0 --> xn, $f1 --> 1.0, $f2 --> 2.0, $f3 --> 2.0, $f4 --> Xn+1, $f5 --> 1/Xn^2
lwc1 $f0, Xn
lwc1 $f3, number3
lwc1 $f2, number2
lwc1 $f1, number1

#counter (loop runs 10 times)
li $s1, 0

#code runs a algebraically simplified form of Newtons method for cube root:
#        2Xn    1
# Xn+1 = --- + ----
#         3    Xn^2
Loop:
	bgt $s1, 10, exit
	
	mul.s $f4 $f0 $f2 #2*Xn 
	div.s $f4 $f4 $f3 #p = 2*Xn / 3
	
	mul.s $f5 $f0 $f0
	div.s $f5 $f1 $f5 #q = 1/ Xn^2
	
	add.s $f4 $f4 $f5
	mov.s $f0 $f4	  #Xn+1 = p + q
	
	addi $s1, $s1, 1
j Loop
exit:

la $a0, output
li $v0, 4
syscall

mov.s $f12, $f0
li $v0, 2
syscall 

li $v0, 10
syscall