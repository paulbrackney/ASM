# Paul Brackney
# paul.brackney@okstate.edu
# 10-17-2022
# program to print sentence in reverse


.text

.globl main

    main:

        # prompt user to enter a sentence
        li $v0, 4
        la $a0, msg1
        syscall

        # create space in the stack and add ascii code for * symbol to the top of the stack
        # we will use this later to check if we've reached the bottom of our stack
        addi $sp, $sp, 1
        li $a0, 42
        sb $a0, 0($sp)

    reverseSentence: 

        # make room in stack for a character
        addi $sp, $sp, 1

        # read a character which is stored in $v0
        li $v0, 12
        syscall

        # store $v0 to the stack
        sb $v0, 0($sp)

        # load from the stack and compare to ascii code for new line
        lb $t0, 0($sp)
        li $a0, 10

        # if the character is not a new line, recurse and add another character to the stack
        bne $a0, $t0, reverseSentence

        # if a new line is entered, begin printing

    nowPrint: 

        # remove a byte from the stack
        addi $sp, $sp, -1

        # load the character from the top of the stack
        lb $t0, 0($sp)

        # load ascii for * symbol to check if we are at the bottom of stack
        li $a0, 42

        # if so, exit program 
        beq $a0, $t0, exit

        # if not, print the character
        li $v0, 11
        move $a0, $t0
        syscall

        # recurse printing part of program
        j nowPrint

    exit: 

        # exit program
        li $v0, 10
        syscall



.data

    msg1: .asciiz "Enter a sentence: "