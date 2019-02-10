#Define the function ?(k), with k ? 2, as
#2^2 + 4^2 + 6^2 + · · · + m^2
#where m is the largest even number that is ? k. Please implement the
#function in MIPS and make sure your implementation indeed works on the
#simulator, by printing the value ?(15) to the terminal.
.data
output: .asciiz "O(15) = "

.text
.globl main
main:

#$a0 == k
li $a0, 15 #$a0 == k | Java: k = 15
li $t2, 2
divu $a0, $t2 #k % 2
mfhi $t0   #$t0 = k % 2

bne $t0, 1, O #Java: if k % 2 == 1 goto O
addi $a0, $a0, -1 #$a0-- | Java: k--

li $a1, 0 #$a1 == 0 | Java: int answer = 0;
O:
blt $a0, 2, endO  	  #go to endO if $a0 < 2 | Java: while(k >= 2) {
	mul $t1, $a0, $a0 #$t1 == anotherK | Java: int anotherK = k * k;
	add $a1, $a1, $t1 #$a1 = $a1 + $t1 | Java: answer = answer + anotherK
	addi $a0, $a0, -2 #$a0 = $a0 - 2 | Java: k-=2
j O
endO:

#Print "O(15) = "
la $a0, output
li $v0, 4
syscall

#print $a1 | Java: Sys.out(answer);
move $a0, $a1
li $v0, 1
syscall

#end of main
li $v0, 10
syscall